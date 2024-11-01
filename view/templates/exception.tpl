<div id="exception" class="generic-page-wrapper">
    <h1>{{$title}}</h1>
    <p>{{$message}}</p>
{{if $thrown}}
	<pre>{{$thrown}}
{{$stack_trace}}
{{$trace}}</pre>
{{/if}}
{{if $request_id}}
	<pre>Request: {{$request_id}}</pre>
{{/if}}
{{if $back}}
	<p><button type="button" onclick="window.history.back()" class="btn btn-primary">{{$back}}</button></p>
{{/if}}
</div>
