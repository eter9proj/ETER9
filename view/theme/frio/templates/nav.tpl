{{* we have modified the navmenu (look at function frio_remote_nav() ) to have remote links. *}}
{{if $userinfo}}
	<header>
		{{* {{$langselector}} *}}

		<div id="site-location">{{$sitelocation}}</div>
		<div id="banner" class="hidden-sm hidden-xs">
			{{* show on remote/visitor connections another logo which symbols that fact*}}
			{{if $nav.remote}}
				<a href="{{$baseurl}}">
					<div id="remote-logo-img" aria-label="{{$home}}"></div>
				</a>
			{{else}}
				{{* #logo-img is the placeholder to insert a mask (friendica logo) into this div
				For Firefox we have to call the paths of the mask (look at the bottom of this file).
				Because for FF we need relative paths we apply them with js after the page is loaded (look at theme.js *}}
				<a href="{{$baseurl}}">
					<div>
					<!-- E⁹ logomark centered on the top navigation bar -->
					<svg width="25" height="25" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M0 12C0 5.373 5.373 0 12 0h76c6.627 0 12 5.373 12 12v76c0 6.627-5.373 12-12 12H12c-6.627 0-12-5.373-12-12Z" style="fill:#316BFF;stroke:none;stroke-width:1;stroke-dasharray:none;stroke-opacity:1"/><path d="M54.792 36.472h1.963v-9.968H16.5v9.968h12.764Zm-25.53 37.062V59.831h25.53v-9.967H16.5V83.5h40.582v-9.966z" fill="#FFFFFF" style="stroke-width:.956016" transform="translate(.746 .746)scale(.98507)"/><path d="M69.932 23.917v7.372q0 1.51.978 2.62 1.018 1.11 2.404 1.11 1.425 0 2.403-1.11 1.02-1.11 1.02-2.62v-7.372q0-1.555-1.02-2.621-.978-1.11-2.403-1.11-1.386 0-2.404 1.11-.978 1.11-.978 2.62m6.804 11.104q-.407 3.686-3.422 3.686h-3.382q-2.771 0-4.808-2.176-1.996-2.176-1.996-5.241v-7.372q0-3.02 1.996-5.196 2.037-2.221 4.808-2.221h6.804q2.77 0 4.768 2.22 1.996 2.177 1.996 5.197V36.84q0 5.33-3.504 9.149-3.464 3.82-8.353 3.82H66.55V46.12h3.382q2.811 0 4.807-2.176 1.997-2.22 1.997-5.24z" style="fill:#FFFFFF;stroke-width:.956016" transform="translate(.746 .746)scale(.98507)"/></svg>
					<!--
					<svg width="25" height="25" viewBox="0 0 17.462 17.462" xmlns="http://www.w3.org/2000/svg"><path d="M54.792 36.472h1.963v-9.968H16.5v9.968h12.764Zm-25.53 37.062V59.831h25.53v-9.967H16.5V83.5h40.582v-9.966z" fill="#316BFF" style="stroke-width:.956016" transform="translate(-4.3 -4.3)scale(.26063)"/><path d="M69.932 23.917v7.372q0 1.51.978 2.62 1.018 1.11 2.404 1.11 1.425 0 2.403-1.11 1.02-1.11 1.02-2.62v-7.372q0-1.555-1.02-2.621-.978-1.11-2.403-1.11-1.386 0-2.404 1.11-.978 1.11-.978 2.62m6.804 11.104q-.407 3.686-3.422 3.686h-3.382q-2.771 0-4.808-2.176-1.996-2.176-1.996-5.241v-7.372q0-3.02 1.996-5.196 2.037-2.221 4.808-2.221h6.804q2.77 0 4.768 2.22 1.996 2.177 1.996 5.197V36.84q0 5.33-3.504 9.149-3.464 3.82-8.353 3.82H66.55V46.12h3.382q2.811 0 4.807-2.176 1.997-2.22 1.997-5.24z" style="fill:#316BFF;stroke-width:.956016" transform="translate(-4.3 -4.3)scale(.26063)"/></svg>
					-->
					</div>
				</a>
			{{/if}}
		</div>
	</header>
	<nav id="topbar-first" class="topbar">
		<div class="container">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 no-padding">
				<!-- div for navbar width-->
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="topbar-nav" role="navigation">

					{{* Buttons for the mobile view *}}
					<button type="button" class="navbar-toggle offcanvas-right-toggle pull-right"
						aria-controls="offcanvasUsermenu" aria-haspopup="true">
						<span class="sr-only">Toggle navigation</span>
						<i class="fa fa-ellipsis-v fa-fw fa-lg" aria-hidden="true"></i>
					</button>
					<button type="button" class="navbar-toggle collapsed pull-right" data-toggle="collapse"
						data-target="#search-mobile" aria-expanded="false" aria-controls="search-mobile">
						<span class="sr-only">Toggle Search</span>
						<i class="fa ri-search-2-fill fa-fw fa-lg" aria-hidden="true"></i>
					</button>
					<button type="button" class="navbar-toggle collapsed pull-left visible-sm visible-xs"
						data-toggle="offcanvas" data-target="aside" aria-haspopup="true">
						<span class="sr-only">Toggle navigation</span>
						<i class="fa ri-arrow-right-wide-line fa-fw fa-lg" aria-hidden="true"></i>
					</button>

					{{* Left section of the NavBar with navigation shortcuts/icons *}}
					<div style="font-size: 18px;">
					<ul class="nav navbar-left" role="menubar">
						{{if $nav.network}}
							<li class="nav-segment">
								<a accesskey="n" class="nav-menu {{$sel.network}}" href="{{$nav.network.0}}"
									data-toggle="tooltip" aria-label="{{$nav.network.3}}" title="{{$nav.network.3}}"><i
										class="fa fa-lg ri-p2p-fill fa-fw" aria-hidden="true"></i><span id="net-update"
										class="nav-network-badge badge nav-notification"></span></a>
							</li>
						{{/if}}

						{{if $nav.channel}}
							<li class="nav-segment">
								<a accesskey="l" class="nav-menu {{$sel.channel}}" href="{{$nav.channel.0}}"
									data-toggle="tooltip" aria-label="{{$nav.channel.3}}" title="{{$nav.channel.3}}"><i
										class="fa fa-lg fa-newspaper-o fa-fw" aria-hidden="true"></i></a>
							</li>
						{{/if}}

						{{if $nav.home}}
							<li class="nav-segment">
								<a accesskey="p" class="nav-menu {{$sel.home}}" href="{{$nav.home.0}}" data-toggle="tooltip"
									aria-label="{{$nav.home.3}}" title="{{$nav.home.3}}"><i class="fa fa-lg ri-user-4-fill fa-fw"
										aria-hidden="true"></i><span id="home-update"
										class="nav-home-badge badge nav-notification"></span></a>
							</li>
						{{/if}}

						{{if $nav.community}}
							<li class="nav-segment">
								<a accesskey="c" class="nav-menu {{$sel.community}}" href="{{$nav.community.0}}"
									data-toggle="tooltip" aria-label="{{$nav.community.3}}" title="{{$nav.community.3}}"><i
										class="fa fa-lg ri-exchange-2-fill fa-fw" aria-hidden="true"></i></a>
							</li>
						{{/if}}

						{{if $nav.messages}}
							<li class="nav-segment hidden-xs">
								<a accesskey="m" id="nav-messages-link" href="{{$nav.messages.0}}" data-toggle="tooltip"
									aria-label="{{$nav.messages.1}}" title="{{$nav.messages.1}}"
									class="nav-menu {{$sel.messages}}"><i class="fa ri-message-3-fill fa-lg fa-fw"
										aria-hidden="true"></i><span id="mail-update"
										class="nav-mail-badge badge nav-notification"></span></a>
							</li>
						{{/if}}

						{{if $nav.calendar}}
							<li class="nav-segment hidden-xs">
								<a accesskey="e" id="nav-calendar-link" href="{{$nav.calendar.0}}" data-toggle="tooltip"
									aria-label="{{$nav.calendar.1}}" title="{{$nav.calendar.1}}" class="nav-menu"><i
										class="fa fa-lg ri-calendar-schedule-fill fa-fw"></i></a>
							</li>
						{{/if}}

						{{if $nav.contacts}}
							<li class="nav-segment hidden-xs">
								<a accesskey="k" id="nav-contacts-link" href="{{$nav.contacts.0}}" data-toggle="tooltip"
									aria-label="{{$nav.contacts.1}}" title="{{$nav.contacts.1}}"
									class="nav-menu {{$sel.contacts}} {{$nav.contacts.2}}">
									<!-- SVG Icon: Synapses -->
									<i class="fa ri-apps-line fa-lg fa-fw"></i></a>
							</li>
						{{/if}}

						{{* The notifications dropdown *}}
						{{if $nav.notifications}}
							<li id="nav-notification" class="nav-segment dropdown" role="presentation">
								<button id="nav-notifications-menu-btn" class="btn-link dropdown-toggle" data-toggle="dropdown"
									type="button" aria-haspopup="true" aria-expanded="false"
									aria-controls="nav-notifications-menu">
									<span id="notification-update" class="nav-notification-badge badge nav-notification"></span>
									<!-- SVG Icon: Bell -->
									<i class="fa ri-notification-3-fill fa-lg" data-toggle="tooltip" aria-label="{{$nav.notifications.1}}" title="{{$nav.notifications.1}}"></i>
								</button>
								{{* The notifications dropdown menu. There are two parts of menu. The second is at the bottom of this file. It is loaded via js. Look at nav-notifications-template *}}
								<ul id="nav-notifications-menu" class="dropdown-menu menu-popup" role="menu"
									aria-labelledby="nav-notifications-menu-btn">
									{{* the following list entry must have the id "nav-notifications-mark-all". Without it this isn't visible. ....strange behavior :-/ *}}
									<li role="presentation" id="nav-notifications-mark-all" class="dropdown-header">
										<div class="arrow"></div>
										{{$nav.notifications.1}}
										<div class="dropdown-header-link">
											<button role="menuitem" type="button" class="btn-link"
												onclick="notificationMarkAll();" data-toggle="tooltip"
												aria-label="{{$nav.notifications.mark.3}}"
												title="{{$nav.notifications.mark.3}}">{{$nav.notifications.mark.1}}</button>
										</div>

									</li>

									<li role="presentation">
										<p role="menuitem" class="text-muted"><i>{{$emptynotifications}}</i></p>
									</li>
								</ul>
							</li>
						{{/if}}

					</ul>
					</div>
				</div>

				{{* This is the right part of the NavBar. It includes the search and the user menu *}}
				<div class="topbar-actions pull-right">
					<ul class="nav">

						{{* The search box *}}
						{{if $nav.search}}
							<li id="search-box" class="hidden-xs">
								<form class="navbar-form" role="search" method="get" action="{{$nav.search.0}}">
									<div class="form-group form-group-search">
										<input accesskey="s" id="nav-search-input-field" class="form-control form-search"
											type="text" name="q" data-toggle="tooltip" title="{{$search_hint}}"
											placeholder="{{$nav.search.1}}">
											
											
											
											
										<button class="btn btn-default btn-sm form-button-search" type="submit">
											<svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="currentColor"><path d="M19.0001 13.9999L19.0002 5L17.0002 4.99997L17.0001 11.9999L9.41405 11.9999V6.58578L2.99985 13L9.41405 19.4142L9.41406 13.9999L19.0001 13.9999Z"></path></svg>
										</button>
										<!--
										<button class="btn btn-default btn-sm form-button-search"
											type="submit">{{$nav.search.1}}
										</button>
										-->	
									</div>
								</form>
							</li>
						{{/if}}

						{{* The user dropdown menu *}}
						{{if $userinfo}}
							<li id="nav-user-linkmenu" class="dropdown account nav-menu hidden-xs">
								<button accesskey="u" id="main-menu" class="btn-link dropdown-toggle nav-avatar"
									data-toggle="dropdown" type="button" aria-haspopup="true" aria-expanded="false"
									aria-controls="nav-user-menu">
									<div aria-hidden="true" class="user-title pull-left hidden-xs hidden-sm hidden-md">
										<strong>{{$userinfo.name}}</strong><br>
										{{if $nav.remote}}<span class="truncate">{{$nav.remote}}</span>{{/if}}
									</div>

									<img id="avatar" src="{{$userinfo.icon}}" alt="{{$userinfo.name}}">
									<span class="caret"></span>
								</button>

								{{* The list of available usermenu links *}}
								<ul id="nav-user-menu" class="dropdown-menu pull-right menu-popup" role="menu"
									aria-labelledby="main-menu">
									{{if $nav.remote}}
										{{if $nav.sitename}}
											<li id="nav-sitename" role="menuitem">{{$nav.sitename}}</li>
											<li role="presentation" class="divider"></li>
										{{/if}}
									{{/if}}
									{{foreach $nav.usermenu as $usermenu}}
										<li role="presentation">
											<a role="menuitem" class="{{$usermenu.2}}" href="{{$usermenu.0}}"
												title="{{$usermenu.3}}">
												{{$usermenu.1}}
											</a>
										</li>
									{{/foreach}}
									<li role="presentation" class="divider"></li>
									{{if $nav.notifications}}
										<li role="presentation">
											<a role="menuitem" href="{{$nav.notifications.all.0}}" title="{{$nav.notifications.1}}">
												<i class="fa ri-notification-3-fill fa-fw" aria-hidden="true"></i>
												{{$nav.notifications.1}}
											</a>
										</li>
									{{/if}}
									{{if $nav.messages}}
										<li role="presentation">
											<a role="menuitem"
												class="nav-commlink {{$nav.messages.2}} {{$sel.messages}}"
												href="{{$nav.messages.0}}" title="{{$nav.messages.3}}">
												<i class="fa ri-message-3-fill fa-fw" aria-hidden="true"></i>
												{{$nav.messages.1}} <span id="mail-update-li"
													class="nav-mail-badge badge nav-notification"></span>
											</a>
										</li>
									{{/if}}
									<li role="presentation" class="divider"></li>
									{{if $nav.contacts}}
										<li role="presentation">
											<a role="menuitem" id="nav-menu-contacts-link"
												class="nav-link {{$nav.contacts.2}}" href="{{$nav.contacts.0}}"
												title="{{$nav.contacts.3}}">
												<i class="fa ri-apps-line fa-fw" aria-hidden="true"></i>
												{{$nav.contacts.1}}
											</a>
										</li>
									{{/if}}
									{{if $nav.delegation}}
										<li role="presentation">
											<a role="menuitem" id="nav-delegation-link"
												class="nav-commlink {{$nav.delegation.2}} {{$sel.delegation}}"
												href="{{$nav.delegation.0}}" title="{{$nav.delegation.3}}">
												<i class="fa ri-account-pin-box-fill fa-fw" aria-hidden="true"></i> {{$nav.delegation.1}}
											</a>
										</li>
									{{/if}}
									<li role="presentation">
										<a role="menuitem" id="nav-directory-link" class="nav-link {{$nav.directory.2}}"
											href="{{$nav.directory.0}}" title="{{$nav.directory.3}}">
											<i class="fa ri-organization-chart fa-fw" aria-hidden="true"></i> {{$nav.directory.1}}
										</a>
									</li>
									<li role="presentation" class="divider"></li>
									{{if $nav.apps}}
										<li role="presentation">
											<a role="menuitem" id="nav-apps-link" class="nav-link {{$nav.apps.2}}"
												href="{{$nav.apps.0}}" title="{{$nav.apps.3}}">
												<i class="fa fa-puzzle-piece fa-fw" aria-hidden="true"></i> {{$nav.apps.1}}
											</a>
										</li>
										<li role="presentation" class="divider"></li>
									{{/if}}

									{{if $nav.settings}}
										<li role="presentation">
											<a role="menuitem" id="nav-settings-link" class="nav-link {{$nav.settings.2}}"
												href="{{$nav.settings.0}}" title="{{$nav.settings.3}}">
												<i class="fa ri-settings-3-fill fa-fw" aria-hidden="true"></i> {{$nav.settings.1}}
											</a>
										</li>
									{{/if}}
									{{if $nav.admin}}
										<li role="presentation">
											<a accesskey="a" role="menuitem" id="nav-admin-link"
												class="nav-link {{$nav.admin.2}}" href="{{$nav.admin.0}}"
												title="{{$nav.admin.3}}"><i class="fa ri-user-6-fill fa-fw" aria-hidden="true"></i>
												{{$nav.admin.1}}
											</a>
										</li>
									{{/if}}
									{{if $nav.moderation}}
										<li role="presentation">
											<a accesskey="m" role="menuitem" id="nav-moderation-link"
												class="nav-link {{$nav.moderation.2}}" href="{{$nav.moderation.0}}"
												title="{{$nav.moderation.3}}"><i class="fa ri-auction-fill fa-fw" aria-hidden="true"></i>
												{{$nav.moderation.1}}
											</a>
										</li>
									{{/if}}
									<li role="presentation" class="divider"></li>
									<li role="presentation">
										<a role="menuitem" id="nav-about-link" class="nav-link {{$nav.about.2}}"
											href="https://www.eter9.com/" title="{{$nav.about.3}}" target="_BLANK">
											<i class="fa ri-information-fill fa-fw" aria-hidden="true"></i> {{$nav.about.1}}
										</a>
									</li>
									{{if $nav.tos}}
										<li role="presentation">
											<a role="menuitem" id="nav-tos-link" class="nav-link {{$nav.tos.2}}"
												href="{{$nav.tos.0}}" title="{{$nav.tos.3}}"><i class="fa ri-file-list-3-fill"
													aria-hidden="true"></i> {{$nav.tos.1}}
											</a>
										</li>
									{{/if}}
									<li role="presentation" class="divider"></li>
									{{if $nav.logout}}
										<li role="presentation">
											<a role="menuitem" id="nav-logout-link"
												class="nav-link {{$nav.logout.2}}" href="{{$nav.logout.0}}"
												title="{{$nav.logout.3}}"><i class="fa fa ri-logout-box-r-fill fa-fw" aria-hidden="true"></i>
												{{$nav.logout.1}}
											</a>
										</li>
									{{else}}
										<li role="presentation">
											<a role="menuitem" id="nav-login-link"
												class="nav-login-link {{$nav.login.2}}" href="{{$nav.login.0}}"
												title="{{$nav.login.3}}"><i class="fa fa-power-off fa-fw" aria-hidden="true"></i>
												{{$nav.login.1}}
											</a>
										</li>
									{{/if}}
								</ul>
							</li>{{* End of userinfo dropdown menu *}}
						{{/if}}

						<!-- Language selector, I do not find it relevant, activate if necessary.
						<li>{{$langselector}}</li>
						-->
					</ul>
				</div>{{* End of right navbar *}}

				{{* The usermenu dropdown for the mobile view. Offcanvas on the right side of the screen.
					It is called via the buttons. Have a look at the top of this file *}}
				<div class="offcanvas-right-overlay visible-xs-block"></div>
				<div id="offcanvasUsermenu" class="offcanvas-right visible-xs-block">
					<div class="nav-container">
						<ul role="menu" class="list-group">
							{{if $nav.remote}}
								{{if $nav.sitename}}
									<li role="menuitem" class="nav-sitename list-group-item">{{$nav.sitename}}</li>
								{{/if}}
							{{/if}}
							<li role="presentation" class="list-group-item">
								<img src="{{$userinfo.icon}}" alt="{{$userinfo.name}}"
									style="max-width:15px; max-height:15px; min-width:15px; min-height:15px; width:15px; height:15px;">
								{{$userinfo.name}}{{if $nav.remote}} ({{$nav.remote}}){{/if}}
							</li>
							{{foreach $nav.usermenu as $usermenu}}
								<li role="presentation" class="list-group-item">
									<a role="menuitem" class="{{$usermenu.2}}"
										href="{{$usermenu.0}}" title="{{$usermenu.3}}">{{$usermenu.1}}
									</a>
								</li>
							{{/foreach}}
							{{if $nav.notifications || $nav.contacts || $nav.messages || $nav.delegation}}
								<li role="presentation" class="divider"></li>
							{{/if}}
							{{if $nav.notifications}}
								<li role="presentation" class="list-group-item">
									<a role="menuitem"
										href="{{$nav.notifications.all.0}}" title="{{$nav.notifications.1}}"><i
											class="fa ri-notification-3-fill fa-fw" aria-hidden="true"></i> {{$nav.notifications.1}}
									</a>
								</li>
							{{/if}}
							{{if $nav.contacts}}
								<li role="presentation" class="list-group-item">
									<a role="menuitem"
										class="nav-link {{$nav.contacts.2}}" href="{{$nav.contacts.0}}"
										title="{{$nav.contacts.3}}"><i class="fa ri-apps-line fa-fw" aria-hidden="true"></i>
										{{$nav.contacts.1}}
									</a>
								</li>
							{{/if}}
							{{if $nav.messages}}
								<li role="presentation" class="list-group-item">
									<a role="menuitem"
										class="nav-link {{$nav.messages.2}} {{$sel.messages}}" href="{{$nav.messages.0}}"
										title="{{$nav.messages.3}}"><i class="fa ri-message-3-fill fa-fw" aria-hidden="true"></i>
										{{$nav.messages.1}}
									</a>
								</li>
							{{/if}}
							{{if $nav.delegation}}
								<li role="presentation" class="list-group-item">
									<a role="menuitem"
										class="nav-commlink {{$nav.delegation.2}} {{$sel.delegation}}"
										href="{{$nav.delegation.0}}" title="{{$nav.delegation.3}}"><i class="fa ri-account-pin-box-fill fa-fw"
											aria-hidden="true"></i> {{$nav.delegation.1}}
									</a>
								</li>
							{{/if}}
							{{if $nav.settings || $nav.admin || $nav.logout}}
								<li role="presentation" class="divider"></li>
							{{/if}}
							{{if $nav.settings}}
								<li role="presentation" class="list-group-item">
									<a role="menuitem" class="nav-link {{$nav.settings.2}}" href="{{$nav.settings.0}}"
										title="{{$nav.settings.3}}"><i class="fa ri-settings-3-fill fa-fw" aria-hidden="true"></i>
										{{$nav.settings.1}}
									</a>
								</li>
							{{/if}}
							{{if $nav.admin}}
								<li role="presentation" class="list-group-item">
									<a role="menuitem"
										class="nav-link {{$nav.admin.2}}" href="{{$nav.admin.0}}" title="{{$nav.admin.3}}"><i
											class="fa ri-user-6-fill fa-fw" aria-hidden="true"></i>
										{{$nav.admin.1}}
									</a>
								</li>
							{{/if}}
							{{if $nav.moderation}}
								<li role="presentation" class="list-group-item">
									<a role="menuitem"
										class="nav-link {{$nav.moderation.2}}" href="{{$nav.moderation.0}}" title="{{$nav.moderation.3}}"><i
											class="fa ri-auction-fill fa-fw" aria-hidden="true"></i>
										{{$nav.moderation.1}}
									</a>
								</li>
							{{/if}}
							<li role="presentation" class="divider"></li>
							<li role="presentation" class="list-group-item">
								<a role="menuitem" class="nav-link {{$nav.about.2}}"
								   href="{{$nav.about.0}}" title="{{$nav.about.3}}">
									<i class="fa ri-information-fill fa-fw" aria-hidden="true"></i> {{$nav.about.1}}
								</a>
							</li>
							<li role="presentation" class="divider"></li>
							{{if $nav.logout}}
								<li role="presentation" class="list-group-item">
									<a role="menuitem"
										class="nav-link {{$nav.logout.2}}" href="{{$nav.logout.0}}" title="{{$nav.logout.3}}"><i
											class="fa fa ri-logout-box-r-fill fa-fw" aria-hidden="true"></i>
										{{$nav.logout.1}}
									</a>
								</li>
							{{else}}
								<li role="presentation" class="list-group-item">
									<a role="menuitem"
										class="nav-login-link {{$nav.login.2}}" href="{{$nav.login.0}}"
										title="{{$nav.login.3}}"><i class="fa fa-power-off fa-fw" aria-hidden="true"></i>
										{{$nav.login.1}}
									</a>
								</li>
							{{/if}}
						</ul>
					</div>
				</div>
				<!--/.sidebar-offcanvas-->
			</div><!-- end of div for navbar width-->
		</div><!-- /.container -->
	</nav><!-- /.navbar -->
{{else}}
	{{* The navbar for users which are not logged in *}}
	<nav class="navbar navbar-fixed-top">
		<div class="container">
			<div class="navbar-header pull-left">
				<button type="button" class="navbar-toggle collapsed pull-left visible-sm visible-xs"
				        data-toggle="offcanvas" data-target="aside" aria-haspopup="true">
					<span class="sr-only">Toggle navigation</span>
					<i class="fa fa-ellipsis-v fa-fw fa-lg" aria-hidden="true"></i>
				</button>
				<a class="navbar-brand" href="https://eter9.net">
					<div id="navbrand-container">
						<div>
							<!-- ETER⁹ logo positioned on the left side of the top navigation bar -->
							<svg width="96" height="29" viewBox="0 0 215.75 65.927" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M65.71 32.946h1.677V24H33v8.946h10.903zM43.903 66.215V53.914H65.71v-8.946H33V75.16h34.667v-8.946z" style="fill:#316BFF" transform="matrix(1.15318 0 0 1.09743 -38.055 -16.558)" fill="#fff"/><path d="M151.922 32.797h1.678v-8.946h-34.387v8.946h10.903zm-21.806 33.269v-12.3h21.806v-8.947h-32.709v30.193h34.666v-8.946z" style="fill:#316BFF" transform="matrix(1.15318 0 0 1.09743 -39.633 -16.394)" fill="#fff"/><path d="M48.92 19.578V9.781h39.978v9.797H74.004v46.349H63.847V19.578Zm97.842 46.349V9.78h19.971q5.75 0 9.799 2.26 4.082 2.262 6.226 6.407 2.177 4.107 2.177 9.684t-2.177 9.609-6.328 6.18q-4.117 2.11-9.97 2.11h-13.37v-9.534h11.636q3.096 0 5.103-.942 2.041-.942 3.028-2.788 1.02-1.847 1.02-4.635 0-2.826-1.02-4.71-.987-1.922-3.028-2.902-2.041-1.017-5.137-1.017h-7.247v46.424Zm28.137 0-12.35-25.548h11.567l12.622 25.548z" style="fill:#316BFF"/><path d="M69.932 23.917v7.372q0 1.51.978 2.62 1.018 1.11 2.404 1.11 1.425 0 2.403-1.11 1.02-1.11 1.02-2.62v-7.372q0-1.555-1.02-2.621-.978-1.11-2.403-1.11-1.386 0-2.404 1.11-.978 1.11-.978 2.62m6.804 11.104q-.407 3.686-3.422 3.686h-3.382q-2.771 0-4.808-2.176-1.996-2.176-1.996-5.241v-7.372q0-3.02 1.996-5.196 2.037-2.221 4.808-2.221h6.804q2.77 0 4.768 2.22 1.996 2.177 1.996 5.197V36.84q0 5.33-3.504 9.149-3.464 3.82-8.353 3.82H66.55V46.12h3.382q2.811 0 4.807-2.176 1.997-2.22 1.997-5.24z" style="fill:#316BFF" transform="translate(133.496 -16.253)scale(.98509)"/></svg>	
						</div>
					</div>
				</a>
			</div>
			<div class="pull-right">
				<ul class="nav navbar-nav navbar-right">
					<li role="presentation">
						<a href="login?mode=none" id="nav-login" data-toggle="tooltip" aria-label="{{$nav.login.3}}"
							title="{{$nav.login.3}}">
							<i class="" aria-hidden="true">
								<!-- ri-share-circle-fill -->
								<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M11 2.04938V4.06189C7.05369 4.55399 4 7.92038 4 12C4 16.4183 7.58172 20 12 20C16.0796 20 19.446 16.9463 19.9381 13H21.9506C21.4489 18.0533 17.1853 22 12 22C6.47715 22 2 17.5228 2 12C2 6.81465 5.94668 2.5511 11 2.04938ZM18.7071 6.70711L12 13.4142L10.5858 12L17.2929 5.29289L14 2H22V10L18.7071 6.70711Z"></path></svg>
							</i>
						</a>
					</li>
					<li role="presentation">
						<a href="https://www.eter9.com" id="nav-about" data-toggle="tooltip" aria-label="Where Time Meets Infinity, and Dreams Find Eternal Echoes."
						title="Where Time Meets Infinity, and Dreams Find Eternal Echoes.">
						<i class="" aria-hidden="true">
							<!-- (i) -->
							<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="#316BFF"><path d="M12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12C22 17.5228 17.5228 22 12 22ZM12 20C16.4183 20 20 16.4183 20 12C20 7.58172 16.4183 4 12 4C7.58172 4 4 7.58172 4 12C4 16.4183 7.58172 20 12 20ZM11 7H13V9H11V7ZM11 11H13V17H11V11Z"></path></svg>
						</i>
					</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
{{/if}}

{{* provide a a search input for mobile view, which expands by pressing the search icon *}}
<div id="search-mobile" class="hidden-lg hidden-md hidden-sm collapse row well">
	<div class="col-xs-12">
		<form class="navbar-form" role="search" method="get" action="{{$nav.search.0}}">
			<div class="form-group form-group-search">
				<input id="nav-search-input-field-mobile" class="form-control form-search" type="text" name="q"
					data-toggle="tooltip" title="{{$search_hint}}" placeholder="{{$nav.search.1}}">
				<button class="btn btn-default btn-sm form-button-search" type="submit">{{$nav.search.1}}</button>
			</div>
		</form>
	</div>
</div>

{{* The second navbar which contains nav points of the actual page - (nav points are actual handled by this theme through js *}}
<div id="topbar-second" class="topbar">
	<div class="container">
		<div class="col-lg-3 col-md-3 hidden-sm hidden-xs" id="nav-short-info"></div>
		<div class="col-lg-7 col-md-7 col-sm-11 col-xs-10" id="tabmenu"></div>
		<div class="col-lg-2 col-md-2 col-sm-1 col-xs-2" id="navbar-button"></div>
	</div>
</div>
