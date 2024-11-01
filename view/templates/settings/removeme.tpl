<div class="generic-page-wrapper">
    {{include file="section_title.tpl" title=$l10n.title}}

	<div id="remove-account-wrapper">
		<div id="remove-account-desc">{{$l10n.desc nofilter}}</div>

		{{$hovercard nofilter}}

		<form action="settings/removeme" autocomplete="off" method="post">
            {{include file="field_password.tpl" field=$password}}

			<div class="form-group pull-right settings-submit-wrapper">
				<button type="submit" name="submit" class="btn btn-danger" value="{{$l10n.title}}"><i class="fa ri-delete-bin-fill fa-fw"></i>&nbsp;{{$l10n.title}}</button>
			</div>
			<div class="clear"></div>
		</form>
	</div>
</div>
