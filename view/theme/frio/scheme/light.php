<?php
/*
 * Name: Light
 * Licence: AGPL
 * Author: Hypolite Petovan <hypolite@friendica.mrpetovan.com>
 * Overwrites: nav_bg, nav_icon_color, link_color, background_color, background_image, login_bg_color, contentbg_transp
 * Accented: yes
 */

require_once 'view/theme/frio/php/PHPColors/Color.php';

$accentColor = new Color($scheme_accent);
$nav_bg = '#E9E9E9'; // E9 White
$menu_background_hover_color = '#' . $accentColor->darken(5);
$nav_icon_color = "#141414"; // E9 Black
$link_color = '#' . $accentColor->getHex();
$background_color = "#F0F2F5";
$login_bg_color = "#F0F2F5";
$contentbg_transp = 100;
$background_image = '';
