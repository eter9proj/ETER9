			<!-- Modal  -->
			<div id="modal" class="modal fade" tabindex="-1" role="dialog">
				<div class="modal-dialog modal-full-screen">
					<div class="modal-content">
						<div id="modal-header" class="modal-header">
							<button id="modal-close" type="button" class="close" data-dismiss="modal">
								<i class="fa ri-close-circle-line"></i>
							</button>
							<h4 id="modal-title" class="modal-title"></h4>
						</div>
						<div id="modal-body" class="modal-body">
							<!-- /# content goes here -->
						</div>
					</div>
				</div>
			</div>

			<!-- Dummy div to append other div's when needed (e.g. used for js function editpost() -->
		<div id="cache-container">
			<div id="footerE9info" class="footerE9info">
			Copyright © 2011-2024 ETER9 and its affiliates. All rights reserved. <a href="https://eter9.net/tos">Terms of Service</a>
				| <a href="https://www.eter9.com/privacy.html" target="_BLANK">Privacy Policy</a>
				| <a href="https://www.eter9.com/dmca.html" target="_BLANK">DMCA</a>
				| <a href="https://www.eter9.com/gdpr.html" target="_BLANK">GDPR</a>
				| <a href="#0">Open Source</a>
				| <a href="#0">Press Inquiries</a>
				</center>
			</div></div>

{{foreach $footerScripts as $scriptUrl}}
			<script type="text/javascript" src="{{$scriptUrl}}"></script>
{{/foreach}}