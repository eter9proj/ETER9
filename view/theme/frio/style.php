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

use Friendica\DI;
use Friendica\Network\HTTPException\NotModifiedException;
use Friendica\Util\Strings;

require_once 'view/theme/frio/theme.php';
require_once 'view/theme/frio/php/scheme.php';
require_once 'view/theme/frio/php/PHPColors/Color.php';

$schemecssfile = false;
$scheme_modified = 0;

/*
 * This script can be included when the maintenance mode is on, which requires us to avoid any config call and
 * use the following hardcoded defaults
 */

//$scheme           = FRIO_DEFAULT_SCHEME;
$scheme           = null;
$scheme_accent    = FRIO_SCHEME_ACCENT_BLUE;
$nav_bg           = '#F8F8F8'; // Guyabano
$nav_icon_color   = '#141414'; // E9 Black
$link_color       = '#316BFF'; // E9 Main Color
$background_color = '#f2f5f7';
$contentbg_transp = 100;
$background_image = 'img/none.png';
$bg_image_option  = '';
//$login_bg_image   = 'img/landscape-009.png';
$login_bg_image   = 'img/landscape-003.jpg';
$login_bg_color   = '';
$modified         = time();





if (DI::mode()->has(\Friendica\App\Mode::MAINTENANCEDISABLED)) {
	DI::config()->reload();

	// Default to hard-coded values for empty settings
	$scheme           = frio_scheme_get_current();
	$scheme_accent    = DI::config()->get('frio', 'scheme_accent')    ?: $scheme_accent;
	$nav_bg           = DI::config()->get('frio', 'nav_bg')           ?: $nav_bg;
	$nav_icon_color   = DI::config()->get('frio', 'nav_icon_color')   ?: $nav_icon_color;
	$link_color       = DI::config()->get('frio', 'link_color')       ?: $link_color;
	$background_color = DI::config()->get('frio', 'background_color') ?: $background_color;
	$contentbg_transp = DI::config()->get('frio', 'contentbg_transp') ?? $contentbg_transp;
	$background_image = DI::config()->get('frio', 'background_image') ?: $background_image;
	$bg_image_option  = DI::config()->get('frio', 'bg_image_option')  ?: $bg_image_option;
	$login_bg_image   = DI::config()->get('frio', 'login_bg_image')   ?: $login_bg_image;
	$login_bg_color   = DI::config()->get('frio', 'login_bg_color')   ?: $login_bg_color;
	$modified         = DI::config()->get('frio', 'css_modified')     ?: $modified;

	// Get the UID of the profile owner.
	$uid = $_REQUEST['puid'] ?? 0;
	if ($uid) {
		DI::pConfig()->load($uid, 'frio');

		// Only override display settings that have actually been set
		$scheme           = frio_scheme_get_current_for_user($uid);
		$scheme_accent    = DI::pConfig()->get($uid, 'frio', 'scheme_accent')    ?: $scheme_accent;
		$nav_bg           = DI::pConfig()->get($uid, 'frio', 'nav_bg')           ?: $nav_bg;
		$nav_icon_color   = DI::pConfig()->get($uid, 'frio', 'nav_icon_color')   ?: $nav_icon_color;
		$link_color       = DI::pConfig()->get($uid, 'frio', 'link_color')       ?: $link_color;
		$background_color = DI::pConfig()->get($uid, 'frio', 'background_color') ?: $background_color;
		$contentbg_transp = DI::pConfig()->get($uid, 'frio', 'contentbg_transp') ?? $contentbg_transp;
		$background_image = DI::pConfig()->get($uid, 'frio', 'background_image') ?: $background_image;
		$bg_image_option  = DI::pConfig()->get($uid, 'frio', 'bg_image_option')  ?: $bg_image_option;
		$modified         = DI::pConfig()->get($uid, 'frio', 'css_modified')     ?: $modified;
	}
}

if (!$login_bg_image && !$login_bg_color) {
	$login_bg_image = 'img/login_bg.jpg';
}
$login_bg_color = $login_bg_color ?: '#f2f5f7';

$scheme = Strings::sanitizeFilePathItem($scheme);

if ($scheme != FRIO_CUSTOM_SCHEME) {
	if (file_exists('view/theme/frio/scheme/' . $scheme . '.php')) {
		$schemefile = 'view/theme/frio/scheme/' . $scheme . '.php';
		require_once $schemefile;
	}
	if (file_exists('view/theme/frio/scheme/' . $scheme . '.css')) {
		$schemecssfile = 'view/theme/frio/scheme/' . $scheme . '.css';
	}
}

$contentbg_transp = $contentbg_transp != '' ? $contentbg_transp : 100;

// Calculate some colors in dependance of existing colors.
// Some colors are calculated to don't have too many selection
// fields in the theme settings.
if (!isset($menu_background_hover_color)) {
	$mbhc = new Color($nav_bg);
	$mcolor = $mbhc->getHex();

	if ($mbhc->isLight($mcolor, 75)) {
		$menu_is = 'light';
		$menu_background_hover_color = '#' . $mbhc->darken(5);
	} else {
		$menu_is = 'dark';
		$menu_background_hover_color = '#' . $mbhc->lighten(5);
	}
}
if (!isset($nav_icon_hover_color)) {
	$nihc = new Color($nav_bg);

	if ($nihc->isLight()) {
		$nav_icon_hover_color = '#' . $nihc->darken(10);
	} else {
		$nav_icon_hover_color = '#' . $nihc->lighten(20);
	}
}
if (!isset($link_hover_color)) {
	$lhc = new Color($link_color);
	$lcolor = $lhc->getHex();

	if ($lhc->isLight($lcolor, 75)) {
		$link_hover_color = '#' . $lhc->darken(5);
	} else {
		$link_hover_color = '#' . $lhc->lighten(5);
	}
}

// Convert $bg_image_options into css.
if (!isset($bg_image_option)) {
	$bg_image_option = null;
}

switch ($bg_image_option) {
	case 'stretch':
		$background_size_img = '100%';
		$background_repeat = 'no-repeat';
		break;
	case 'cover':
		$background_size_img = 'cover';
		$background_repeat = 'no-repeat';
		break;
	case 'repeat':
		$background_size_img = 'auto';
		$background_repeat = 'repeat';
		break;
	case 'contain':
		$background_size_img = 'contain';
		$background_repeat = 'repeat';
		break;

	default:
		$background_size_img = 'auto';
		$background_repeat = 'no-repeat';
		break;
}

// Convert transparency level from percentage to opacity value.
$contentbg_transp = $contentbg_transp / 100;

$options = [
	'$nav_bg'                      => $nav_bg,
	'$nav_icon_color'              => $nav_icon_color,
	'$nav_icon_hover_color'        => $nav_icon_hover_color,
	'$link_color'                  => $link_color,
	'$link_hover_color'            => $link_hover_color,
	'$menu_background_hover_color' => $menu_background_hover_color,
	'$btn_primary_color'           => $nav_icon_color,
	'$btn_primary_hover_color'     => $menu_background_hover_color,
	'$background_color'            => $background_color,
	'$contentbg_transp'            => $contentbg_transp,
	'$background_image'            => $background_image,
	'$background_size_img'         => $background_size_img,
	'$background_repeat'           => $background_repeat,
	'$login_bg_image'              => $login_bg_image,
	'$login_bg_color'              => $login_bg_color,
	'$font_color_darker'           => $font_color_darker ?? '#141414',
	'$font_color_lighter'          => $font_color_lighter ?? '#aaa',
	'$font_color'                  => $font_color ?? '#141414',
]; // E9 Black: #141414

$css_tpl = file_get_contents('view/theme/frio/css/style.css');
$css_tpl .= file_get_contents('view/theme/frio/css/dropzone.min.frio.css');

// Get the content of the scheme css file and the time of the last file change.
if ($schemecssfile) {
	$css_tpl .= file_get_contents($schemecssfile);
	$scheme_modified = filemtime($schemecssfile);
}

// We need to check which is the most recent css data.
// We will use this time later to decide if we load the cached or fresh css data.
if ($scheme_modified > $modified) {
	$modified = $scheme_modified;
}
// Apply the settings to the css template.
$css = str_replace(array_keys($options), array_values($options), $css_tpl);

$modified = gmdate('r', $modified);

$etag = md5($css);

// Set a header for caching.
header('Cache-Control: public');
header('ETag: "' . $etag . '"');
header('Last-Modified: ' . $modified);

// Only send the CSS file if it was changed.
/// @todo Check if this works at all (possibly clients are sending only the one or the other header) - compare with mod/photo.php
if (isset($_SERVER['HTTP_IF_MODIFIED_SINCE']) && isset($_SERVER['HTTP_IF_NONE_MATCH'])) {
	$cached_modified = gmdate('r', strtotime($_SERVER['HTTP_IF_MODIFIED_SINCE']));
	$cached_etag = str_replace(['"', '-gzip'], ['', ''],
				stripslashes($_SERVER['HTTP_IF_NONE_MATCH']));

	if (($cached_modified == $modified) && ($cached_etag == $etag)) {
		throw new NotModifiedException();
	}
}

echo $css;
