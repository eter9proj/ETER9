<?php
/**
 * @copyright Copyright (C) 2010-2024, the Friendica project
 *
 * @license GNU AGPL version 3 or any later version
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 */

namespace Friendica\Module;

use Friendica\App;
use Friendica\BaseModule;
use Friendica\Core\Addon;
use Friendica\Core\Config\Capability\IManageConfigValues;
use Friendica\Core\KeyValueStorage\Capability\IManageKeyValuePairs;
use Friendica\Core\L10n;
use Friendica\Core\Protocol;
use Friendica\Core\Worker;
use Friendica\Database\Database;
use Friendica\Model\Register;
use Friendica\Moderation\Entity\Report;
use Friendica\Util\DateTimeFormat;
use Friendica\Util\Profiler;
use Psr\Log\LoggerInterface;
use Friendica\Network\HTTPException;

class Stats extends BaseModule
{
	/** @var IManageConfigValues */
	protected $config;
	/** @var Database */
	protected $dba;
	/** @var LoggerInterface */
	protected $logger;
	/** @var IManageKeyValuePairs */
	protected $keyValue;

	public function __construct(L10n $l10n, App\BaseURL $baseUrl, App\Arguments $args, LoggerInterface $logger, Profiler $profiler, IManageConfigValues $config, IManageKeyValuePairs $keyValue, Database $dba, Response $response, array $server, array $parameters = [])
	{
		parent::__construct($l10n, $baseUrl, $args, $logger, $profiler, $response, $server, $parameters);

		$this->config   = $config;
		$this->keyValue = $keyValue;
		$this->dba      = $dba;
	}

	protected function content(array $request = []): string
	{
		if (!$this->isAllowed($request)) {
			throw new HTTPException\NotFoundException($this->l10n->t('Page not found.'));
		}
		return '';
	}

	protected function rawContent(array $request = [])
	{
		if (!$this->isAllowed($request)) {
			return;
		}

		$report = $this->dba->selectFirst('report', ['created'], [], ['order' => ['created' => true]]);
		if (!empty($report)) {
			$report_datetime  = DateTimeFormat::utc($report['created'], DateTimeFormat::JSON);
			$report_timestamp = strtotime($report['created']);
		} else {
			$report_datetime  = '';
			$report_timestamp = 0;
		}

		$statistics = [
			'cron' => [
				'lastExecution' => [
					'datetime'  => date(DateTimeFormat::JSON, (int)$this->keyValue->get('last_cron')),
					'timestamp' => (int)$this->keyValue->get('last_cron'),
				],
			],
			'worker' => [
				'lastExecution' => [
					'datetime'  => DateTimeFormat::utc($this->keyValue->get('last_worker_execution'), DateTimeFormat::JSON),
					'timestamp' => strtotime($this->keyValue->get('last_worker_execution')),
				],
				'jpm'           => [
					1 => $this->dba->count('workerqueue', ["`done` AND `executed` > ?", DateTimeFormat::utc('now - 1 minute')]),
					3 => round($this->dba->count('workerqueue', ["`done` AND `executed` > ?", DateTimeFormat::utc('now - 3 minute')]) / 3),
					5 => round($this->dba->count('workerqueue', ["`done` AND `executed` > ?", DateTimeFormat::utc('now - 5 minute')]) / 5),
				],
				'active'        => [],
				'deferred'      => [],
				'total'         => [],
			],
			'users' => [
				'total'          => intval($this->keyValue->get('nodeinfo_total_users')),
				'activeWeek'     => intval($this->keyValue->get('nodeinfo_active_users_weekly')),
				'activeMonth'    => intval($this->keyValue->get('nodeinfo_active_users_monthly')),
				'activeHalfyear' => intval($this->keyValue->get('nodeinfo_active_users_halfyear')),
				'pending'        => Register::getPendingCount(),
			],
			'posts' => [
				'inbound' => [
					'posts'    => intval($this->keyValue->get('nodeinfo_total_posts')) - intval($this->keyValue->get('nodeinfo_local_posts')),
					'comments' => intval($this->keyValue->get('nodeinfo_total_comments')) - intval($this->keyValue->get('nodeinfo_local_comments')),
				],
				'outbound' => [
					'posts'    => intval($this->keyValue->get('nodeinfo_local_posts')),
					'comments' => intval($this->keyValue->get('nodeinfo_local_comments')),
				],
			],
			'packets' => [
				'inbound' => [
					Protocol::ACTIVITYPUB => intval($this->keyValue->get('stats_packets_inbound_' . Protocol::ACTIVITYPUB) ?? 0),
					Protocol::DFRN        => intval($this->keyValue->get('stats_packets_inbound_' . Protocol::DFRN) ?? 0),
					Protocol::DIASPORA    => intval($this->keyValue->get('stats_packets_inbound_' . Protocol::DIASPORA) ?? 0),
					Protocol::OSTATUS     => intval($this->keyValue->get('stats_packets_inbound_' . Protocol::OSTATUS) ?? 0),
					Protocol::FEED        => intval($this->keyValue->get('stats_packets_inbound_' . Protocol::FEED) ?? 0),
					Protocol::MAIL        => intval($this->keyValue->get('stats_packets_inbound_' . Protocol::MAIL) ?? 0),
				],
				'outbound' => [
					Protocol::ACTIVITYPUB => intval($this->keyValue->get('stats_packets_outbound_' . Protocol::ACTIVITYPUB) ?? 0),
					Protocol::DFRN        => intval($this->keyValue->get('stats_packets_outbound_' . Protocol::DFRN) ?? 0),
					Protocol::DIASPORA    => intval($this->keyValue->get('stats_packets_outbound_' . Protocol::DIASPORA) ?? 0),
					Protocol::OSTATUS     => intval($this->keyValue->get('stats_packets_outbound_' . Protocol::OSTATUS) ?? 0),
					Protocol::FEED        => intval($this->keyValue->get('stats_packets_outbound_' . Protocol::FEED) ?? 0),
					Protocol::MAIL        => intval($this->keyValue->get('stats_packets_outbound_' . Protocol::MAIL) ?? 0),
				]
			],
			'reports' => [
				'newest' => [
					'datetime'  => $report_datetime,
					'timestamp' => $report_timestamp,
				],
				'open'   => $this->dba->count('report', ['status' => Report::STATUS_OPEN]),
				'closed' => $this->dba->count('report', ['status' => Report::STATUS_CLOSED]),
			]
		];

		if (Addon::isEnabled('bluesky')) {
			$statistics['packets']['inbound'][Protocol::BLUESKY] = intval($this->keyValue->get('stats_packets_inbound_' . Protocol::BLUESKY) ?? 0);
			$statistics['packets']['outbound'][Protocol::BLUESKY] = intval($this->keyValue->get('stats_packets_outbound_' . Protocol::BLUESKY) ?? 0);
		}
		if (Addon::isEnabled('tumblr')) {
			$statistics['packets']['inbound'][Protocol::TUMBLR] = intval($this->keyValue->get('stats_packets_inbound_' . Protocol::TUMBLR) ?? 0);
			$statistics['packets']['outbound'][Protocol::TUMBLR] = intval($this->keyValue->get('stats_packets_outbound_' . Protocol::TUMBLR) ?? 0);
		}

		$statistics = $this->getJobsPerPriority($statistics);

		$this->jsonExit($statistics);
	}

	private function isAllowed(array $request): bool
	{
		return empty(!$request['key']) && $request['key'] == $this->config->get('system', 'stats_key');
	}

	private function getJobsPerPriority(array $statistics): array
	{
		$statistics['worker']['active'] = $statistics['worker']['total'] = [
			Worker::PRIORITY_UNDEFINED  => 0,
			Worker::PRIORITY_CRITICAL   => 0,
			Worker::PRIORITY_HIGH       => 0,
			Worker::PRIORITY_MEDIUM     => 0,
			Worker::PRIORITY_LOW        => 0,
			Worker::PRIORITY_NEGLIGIBLE => 0,
			'total'                     => 0,
		];

		for ($i = 1; $i <= $this->config->get('system', 'worker_defer_limit'); $i++) {
			$statistics['worker']['deferred'][$i] = 0;
		}
		$statistics['worker']['deferred']['total'] = 0;

		$jobs = $this->dba->p("SELECT COUNT(*) AS `entries`, `priority` FROM `workerqueue` WHERE NOT `done` AND `retrial` = ? GROUP BY `priority`", 0);
		while ($entry = $this->dba->fetch($jobs)) {
			$running  = $this->dba->count('workerqueue-view', ['priority' => $entry['priority']]);
			$statistics['worker']['active']['total'] += $running;
			$statistics['worker']['active'][$entry['priority']] = $running;
			$statistics['worker']['total']['total'] += $entry['entries'];
			$statistics['worker']['total'][$entry['priority']] = $entry['entries'];
		}
		$this->dba->close($jobs);
		$statistics['worker']['active'][Worker::PRIORITY_UNDEFINED] = max(0, Worker::activeWorkers() - $statistics['worker']['active']['total']);

		$jobs = $this->dba->p("SELECT COUNT(*) AS `entries`, `retrial` FROM `workerqueue` WHERE NOT `done` AND `retrial` > ? GROUP BY `retrial`", 0);
		while ($entry = $this->dba->fetch($jobs)) {
			$statistics['worker']['deferred']['total'] += $entry['entries'];
			$statistics['worker']['deferred'][$entry['retrial']] = $entry['entries'];
		}
		$this->dba->close($jobs);

		return $statistics;
	}
}
