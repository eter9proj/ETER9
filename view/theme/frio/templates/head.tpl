{{* This content will be added to the html page <head> *}}

<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<base href="{{$baseurl}}/" />
<meta name="generator" content="{{$generator}}" />
<meta name="viewport" content="initial-scale=1.0">

{{* All needed CSS files - NOTE: CSS must be inserted before JS files *}}
<link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet" />

<link rel="stylesheet" href="view/global.css?v={{$VERSION}}" type="text/css" media="all" />
<link rel="stylesheet" href="view/asset/jquery-colorbox/example5/colorbox.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet" href="view/asset/jgrowl/jquery.jgrowl.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="view/asset/jquery-datetimepicker/build/jquery.datetimepicker.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="view/asset/perfect-scrollbar/dist/css/perfect-scrollbar.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />

<link rel="stylesheet"
	href="view/theme/frio/frameworks/bootstrap/css/bootstrap.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="view/theme/frio/frameworks/bootstrap/css/bootstrap-theme.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet" href="view/asset/fork-awesome/css/fork-awesome.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="view/theme/frio/frameworks/jasny/css/jasny-bootstrap.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="view/theme/frio/frameworks/bootstrap-select/css/bootstrap-select.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="view/theme/frio/frameworks/ekko-lightbox/ekko-lightbox.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="view/theme/frio/frameworks/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="view/theme/frio/frameworks/justifiedGallery/justifiedGallery.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="view/theme/frio/frameworks/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet"
	href="view/theme/frio/frameworks/bootstrap-toggle/css/bootstrap-toggle.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet" href="view/theme/frio/font/open_sans/open-sans.css?v={{$VERSION}}"
	type="text/css" media="screen" />
<link rel="stylesheet" href="view/js/fancybox/jquery.fancybox.min.css?v={{$VERSION}}"
	type="text/css" media="screen" />

{{* Own CSS files *}}
<link rel="stylesheet" href="view/theme/frio/css/hovercard.css?v={{$VERSION}}" type="text/css"
	media="screen" />
<link rel="stylesheet" href="view/theme/frio/css/font-awesome.custom.css?v={{$VERSION}}"
	type="text/css" media="screen" />

{{foreach $stylesheets as $stylesheetUrl => $media}}
	<link rel="stylesheet" href="{{$stylesheetUrl}}" type="text/css" media="{{$media}}" />
{{/foreach}}

{{* Boxicons CSS *}}
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" />

<link rel="icon" href="/images/favicon.svg" />
<link rel="apple-touch-icon" href="/images/apple-touch-icon.png" />

<meta name="apple-mobile-web-app-capable" content="yes" />
<link rel="manifest" href="{{$baseurl}}/friendica.webmanifest">


<script type="text/javascript">
	// @license magnet:?xt=urn:btih:d3d9a9a6595521f9666a5e94cc830dab83b65699&dn=expat.txt Expat
	// Prevents links to switch to Safari in a home screen app - see https://gist.github.com/irae/1042167
	(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d=d.parentNode;"href"in d&&(chref=d.href).replace("{{$baseurl}}/", "").replace(e.href,"").indexOf("#")&&(!/^[a-z\+\.\-]+:/i.test(chref)||chref.indexOf(e.protocol+"//"+e.host)===0)&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone");
		// |license-end
	</script>

	<link rel="search" href="{{$baseurl}}/opensearch" type="application/opensearchdescription+xml"
		title="Search in Friendica" />
		
		
		
	
	
	<!-- IBM Plex Mono -->
	<link rel="preconnect" href="https://fonts.googleapis.com" />
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />
	<!-- M PLUS 1 Code -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=M+PLUS+1+Code:wght@100..700&display=swap" rel="stylesheet">
	<!-- Play -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Play:wght@400;700&display=swap" rel="stylesheet">
	<!-- Anta -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Anta&display=swap" rel="stylesheet">
	<!-- Titillium Web -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Titillium+Web:ital,wght@0,200;0,300;0,400;0,600;0,700;0,900;1,200;1,300;1,400;1,600;1,700&display=swap" rel="stylesheet">
	<!-- Roboto Mono -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
	<!-- Ubuntu Mono -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Ubuntu+Mono:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">
	<!-- Red Hat Mono -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Red+Hat+Mono:ital,wght@0,300..700;1,300..700&display=swap" rel="stylesheet">

	
	
	
		
		
		
		
		
		
	


	{{* The JS files we use *}}
	<!--[if IE]>
<script type="text/javascript" src="https://html5shiv.googlecode.com/svn/trunk/html5.js?v={{$VERSION}}"></script>
<![endif]-->
	<script type="text/javascript" src="view/js/modernizr.js?v={{$VERSION}}"></script>
	<script type="text/javascript" src="view/asset/jquery/dist/jquery.min.js?v={{$VERSION}}">
	</script>
	<script type="text/javascript" src="view/js/jquery.textinputs.js?v={{$VERSION}}"></script>
	<script type="text/javascript"
		src="view/asset/textcomplete/dist/textcomplete.min.js?v={{$VERSION}}"></script>
	<script type="text/javascript" src="view/js/autocomplete.js?v={{$VERSION}}"></script>
	<script type="text/javascript"
		src="view/asset/jquery-colorbox/jquery.colorbox-min.js?v={{$VERSION}}"></script>
	<script type="text/javascript" src="view/asset/jgrowl/jquery.jgrowl.min.js?v={{$VERSION}}">
	</script>
	<script type="text/javascript"
		src="view/asset/jquery-datetimepicker/build/jquery.datetimepicker.full.min.js?v={{$VERSION}}">
	</script>
	<script type="text/javascript"
		src="view/asset/perfect-scrollbar/dist/js/perfect-scrollbar.jquery.min.js?v={{$VERSION}}">
	</script>
	<script type="text/javascript"
		src="view/asset/imagesloaded/imagesloaded.pkgd.min.js?v={{$VERSION}}"></script>
	<script type="text/javascript" src="view/asset/base64/base64.min.js?v={{$VERSION}}"></script>
	<script type="text/javascript" src="view/asset/dompurify/dist/purify.min.js?v={{$VERSION}}">
	</script>
	<script type="text/javascript">
		const updateInterval = {{$update_interval}};
		const localUser = {{if $local_user}}{{$local_user}}{{else}}false{{/if}};
	</script>
	<script type="text/javascript" src="view/js/main.js?v={{$VERSION}}"></script>

	<script type="text/javascript"
		src="view/theme/frio/frameworks/bootstrap/js/bootstrap.min.js?v={{$VERSION}}"></script>
	<script type="text/javascript"
		src="view/theme/frio/frameworks/jasny/js/jasny-bootstrap.custom.js?v={{$VERSION}}"></script>
	<script type="text/javascript"
		src="view/theme/frio/frameworks/bootstrap-select/js/bootstrap-select.min.js?v={{$VERSION}}">
	</script>
	<script type="text/javascript"
		src="view/theme/frio/frameworks/ekko-lightbox/ekko-lightbox.min.js?v={{$VERSION}}"></script>
	<script type="text/javascript"
		src="view/theme/frio/frameworks/justifiedGallery/jquery.justifiedGallery.min.js?v={{$VERSION}}">
	</script>
	<script type="text/javascript"
		src="view/theme/frio/frameworks/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js?v={{$VERSION}}">
	</script>
	<script type="text/javascript"
		src="view/theme/frio/frameworks/flexMenu/flexmenu.custom.js?v={{$VERSION}}"></script>
	<script type="text/javascript"
		src="view/theme/frio/frameworks/jquery-scrollspy/jquery-scrollspy.js?v={{$VERSION}}">
	</script>
	<script type="text/javascript"
		src="view/theme/frio/frameworks/autosize/autosize.min.js?v={{$VERSION}}"></script>
	<script type="text/javascript"
		src="view/theme/frio/frameworks/sticky-kit/jquery.sticky-kit.min.js?v={{$VERSION}}"></script>

	{{* Own JS files *}}
	<script type="text/javascript" src="view/theme/frio/js/theme.js?v={{$VERSION}}"></script>
	<script type="text/javascript" src="view/theme/frio/js/modal.js?v={{$VERSION}}"></script>
	{{if ! $block_public}}
		<script type="text/javascript" src="view/theme/frio/js/hovercard.js?v={{$VERSION}}"></script>
	{{/if}}
	<script type="text/javascript" src="view/theme/frio/js/textedit.js?v={{$VERSION}}"></script>
	<script type="text/javascript" src="vendor/enyo/dropzone/dist/min/dropzone.min.js?v={{$VERSION}}"></script>
	<script type="text/javascript" src="view/js/dropzone-factory.js?v={{$VERSION}}"></script>
	<script type="text/javascript"> const dzFactory = new DzFactory({{$max_imagesize}});</script>
	<script type="text/javascript" src="view/js/fancybox/jquery.fancybox.min.js?v={{$VERSION}}"></script>
	<script type="text/javascript" src="view/js/fancybox/fancybox.config.js?v={{$VERSION}}"></script>
	<script type="text/javascript" src="view/js/vanillaEmojiPicker/vanillaEmojiPicker.min.js?v={{$VERSION}}"></script>
	<script>
	window.onload = function(){
		new EmojiPicker({
			trigger: [
				{
					selector: '.emojis',
					insertInto: ['#comment-edit-text-0', '.profile-jot-text-full', '.comment-edit-text-full']
				}
			],
			closeButton: true
		});
	};
	</script>

	{{* Include the strings which are needed for some js functions (e.g. translation)
They are loaded into the html <head> so that js functions can use them *}}
	{{include file="js_strings.tpl"}}
