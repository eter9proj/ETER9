<?php

namespace Friendica\Core\Config;

use Friendica\Model;

/**
 * This class implements the Just-In-Time configuration, which will cache
 * config values in a cache, once they are retrieved.
 *
 * Default Configuration type.
 * Provides the best performance for pages loading few configuration variables.
 */
class JitConfiguration extends Configuration
{
	/** @var array */
	private $in_db;

	/**
	 * @param Cache\ConfigCache   $configCache The configuration cache (based on the config-files)
	 * @param Model\Config\Config $configModel The configuration model
	 */
	public function __construct(Cache\ConfigCache $configCache, Model\Config\Config $configModel)
	{
		parent::__construct($configCache, $configModel);
		$this->in_db = [];

		// take the values of the given cache instead of loading them from the model again
		$preSet = $configCache->getAll();
		if (!empty($preSet)) {
			foreach ($preSet as $cat => $data) {
				foreach ($data as $key => $value) {
					$this->in_db[$cat][$key] = true;
				}
			}
		}

		$this->load();
	}

	/**
	 * {@inheritDoc}
	 *
	 */
	public function load(string $cat = 'config')
	{
		// If not connected, do nothing
		if (!$this->configModel->isConnected()) {
			return;
		}

		$config = $this->configModel->load($cat);

		if (!empty($config[$cat])) {
			foreach ($config[$cat] as $key => $value) {
				$this->in_db[$cat][$key] = true;
			}
		}

		// load the whole category out of the DB into the cache
		$this->configCache->load($config, true);
	}

	/**
	 * {@inheritDoc}
	 */
	public function get(string $cat, string $key, $default_value = null, bool $refresh = false)
	{
		// if the value isn't loaded or refresh is needed, load it to the cache
		if ($this->configModel->isConnected() &&
		    (empty($this->in_db[$cat][$key]) ||
		     $refresh)) {

			$dbvalue = $this->configModel->get($cat, $key);

			if (isset($dbvalue)) {
				$this->configCache->set($cat, $key, $dbvalue);
				unset($dbvalue);
				$this->in_db[$cat][$key] = true;
			}
		}

		// use the config cache for return
		$result = $this->configCache->get($cat, $key);

		return (isset($result)) ? $result : $default_value;
	}

	/**
	 * {@inheritDoc}
	 */
	public function set(string $cat, string $key, $value)
	{
		// set the cache first
		$cached = $this->configCache->set($cat, $key, $value);

		// If there is no connected adapter, we're finished
		if (!$this->configModel->isConnected()) {
			return $cached;
		}

		$stored = $this->configModel->set($cat, $key, $value);

		$this->in_db[$cat][$key] = $stored;

		return $cached && $stored;
	}

	/**
	 * {@inheritDoc}
	 */
	public function delete(string $cat, string $key)
	{
		$cacheRemoved = $this->configCache->delete($cat, $key);

		if (isset($this->in_db[$cat][$key])) {
			unset($this->in_db[$cat][$key]);
		}

		if (!$this->configModel->isConnected()) {
			return $cacheRemoved;
		}

		$storeRemoved = $this->configModel->delete($cat, $key);

		return $cacheRemoved || $storeRemoved;
	}
}