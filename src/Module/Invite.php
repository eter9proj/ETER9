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

use Friendica\BaseModule;
use Friendica\Core\Renderer;
use Friendica\Core\Search;
use Friendica\DI;
use Friendica\Model;
use Friendica\Model\User;
use Friendica\Network\HTTPException;
use Friendica\Protocol\Email;
use Friendica\Util\Strings;

/**
 * Invite people to friendica
 */
class Invite extends BaseModule
{
	protected function post(array $request = [])
	{
		if (!DI::userSession()->getLocalUserId()) {
			throw new HTTPException\ForbiddenException(DI::l10n()->t('Permission denied.'));
		}

		self::checkFormSecurityTokenRedirectOnError('/', 'send_invite');

		$app = DI::app();
		$config = DI::config();

		$max_invites = intval($config->get('system', 'max_invites'));
		if (!$max_invites) {
			$max_invites = 50;
		}

		$current_invites = intval(DI::pConfig()->get(DI::userSession()->getLocalUserId(), 'system', 'sent_invites'));
		if ($current_invites > $max_invites) {
			throw new HTTPException\ForbiddenException(DI::l10n()->t('Total invitation limit exceeded.'));
		}


		$recipients = !empty($_POST['recipients']) ? explode("\n", $_POST['recipients']) : [];
		$message = !empty($_POST['message']) ? Strings::escapeHtml(trim($_POST['message'])) : '';

		$total = 0;
		$invitation_only = false;
		$invites_remaining = null;

		if ($config->get('system', 'invitation_only')) {
			$invitation_only = true;
			$invites_remaining = DI::pConfig()->get(DI::userSession()->getLocalUserId(), 'system', 'invites_remaining');
			if ((!$invites_remaining) && (!DI::userSession()->isSiteAdmin())) {
				throw new HTTPException\ForbiddenException();
			}
		}

		$user = User::getById(DI::userSession()->getLocalUserId());

		foreach ($recipients as $recipient) {
			$recipient = trim($recipient);

			if (!filter_var($recipient, FILTER_VALIDATE_EMAIL)) {
				DI::sysmsg()->addNotice(DI::l10n()->t('%s : Not a valid email address.', $recipient));
				continue;
			}

			if ($invitation_only && ($invites_remaining || DI::userSession()->isSiteAdmin())) {
				$code = Model\Register::createForInvitation();
				$nmessage = str_replace('$invite_code', $code, $message);

				if (!DI::userSession()->isSiteAdmin()) {
					$invites_remaining--;
					if ($invites_remaining >= 0) {
						DI::pConfig()->set(DI::userSession()->getLocalUserId(), 'system', 'invites_remaining', $invites_remaining);
					} else {
						return;
					}
				}
			} else {
				$nmessage = $message;
			}

			$additional_headers = 'From: "' . $user['email'] . '" <' . DI::emailer()->getSiteEmailAddress() . ">\n"
				. 'Content-type: text/plain; charset=UTF-8' . "\n"
				. 'Content-transfer-encoding: 8bit';

			$res = mail(
				$recipient,
				Email::encodeHeader(DI::l10n()->t('Please join us on Friendica'), 'UTF-8'),
				$nmessage,
				$additional_headers);

			if ($res) {
				$total++;
				$current_invites++;
				DI::pConfig()->set(DI::userSession()->getLocalUserId(), 'system', 'sent_invites', $current_invites);
				if ($current_invites > $max_invites) {
					DI::sysmsg()->addNotice(DI::l10n()->t('Invitation limit exceeded. Please contact your site administrator.'));
					return;
				}
			} else {
				DI::sysmsg()->addNotice(DI::l10n()->t('%s : Message delivery failed.', $recipient));
			}

		}
		DI::sysmsg()->addInfo(DI::l10n()->tt('%d message sent.', '%d messages sent.', $total));
	}

	protected function content(array $request = []): string
	{
		if (!DI::userSession()->getLocalUserId()) {
			throw new HTTPException\ForbiddenException(DI::l10n()->t('Permission denied.'));
		}

		$app = DI::app();
		$config = DI::config();

		$inviteOnly = false;

		if ($config->get('system', 'invitation_only')) {
			$inviteOnly = true;
			$x = DI::pConfig()->get(DI::userSession()->getLocalUserId(), 'system', 'invites_remaining');
			if ((!$x) && (!DI::userSession()->isSiteAdmin())) {
				throw new HTTPException\ForbiddenException(DI::l10n()->t('You have no more invitations available'));
			}
		}

		$dirLocation = Search::getGlobalDirectory();
		if (strlen($dirLocation)) {
			if (Register::getPolicy() === Register::CLOSED) {
				$linkTxt = DI::l10n()->t('Visit %s for a list of public sites that you can join. Friendica members on other sites can all connect with each other, as well as with members of many other social networks.', $dirLocation . '/servers');
			} else {
				$linkTxt = DI::l10n()->t('To accept this invitation, please visit and register at %s or any other public Friendica website.', DI::baseUrl() . '/register');
			}
		} else { // there is no global directory URL defined
			if (Register::getPolicy() === Register::CLOSED) {
				return DI::l10n()->t('Our apologies. This system is not currently configured to connect with other public sites or invite members.');
			} else {
				$linkTxt = DI::l10n()->t('To accept thisssss invitation, please sign up at %s.', DI::baseUrl() . '/register' 
					. "\r\n" . "\r\n" . DI::l10n()->t('Friendica sites all inter-connect to create a huge privacy-enhanced social web that is owned and controlled by its members. They can also connect with many traditional social networks.'));
			}
		}

		$tpl = Renderer::getMarkupTemplate('invite.tpl');
		return Renderer::replaceMacros($tpl, [
			'$form_security_token' => self::getFormSecurityToken('send_invite'),
			'$title'               => DI::l10n()->t('Send invitations'),
			'$recipients'          => ['recipients', DI::l10n()->t('Enter email addresses, one per line:')],
			'$message'             => [
				'message',
				DI::l10n()->t('Your message:'),
				DI::l10n()->t('You are cordially invited to join me and other close friends on ETER9 to help us create a better social web.') . "\r\n" . "\r\n"
				. $linkTxt
				. "\r\n" . "\r\n" . (($inviteOnly) ? DI::l10n()->t('You will need to supply this invitation code: $invite_code') . "\r\n" . "\r\n" : '') . DI::l10n()->t('Once you\'ve signed up, connect with me through my profile page:')
				. "\r\n" . DI::baseUrl() . '/profile/' . DI::userSession()->getLocalUserNickname()
				. "\r\n" . "\r\n" . DI::l10n()->t('For more information about the ETER9 Project and its significance, please visit https://www.eter9.com') . "\r\n" . "\r\n",
			],
			'$submit'              => DI::l10n()->t('Send Invitation(s)')
		]);
	}
}
