{{if $delivery.queue_count >= -1 && $delivery.queue_count !== '' && $delivery.queue_count !== null}}
<span class="delivery">
	&bull;
	{{if $delivery.queue_count == 0}}
		<i class="fa ri-time-line" aria-hidden="true" title="{{$delivery.notifier_pending}}"></i>
		<span class="sr-only">{{$delivery.notifier_pending}}</span>
	{{elseif $delivery.queue_done == 0}}
		<i class="fa ri-time-fill" aria-hidden="true" title="{{$delivery.delivery_pending}} {{$item.delivery.queue_done}}/{{$item.delivery.queue_count}}"></i>
		<span class="sr-only">{{$delivery.delivery_pending}}</span>
	{{elseif $delivery.queue_done / $delivery.queue_count < 0.75}}
		<i class="fa ri-send-plane-2-fill-o" aria-hidden="true" title="{{$delivery.delivery_underway}} {{$item.delivery.queue_done}}/{{$item.delivery.queue_count}}"></i>
		<span class="sr-only">{{$delivery.delivery_underway}}</span>
	{{elseif $delivery.queue_done < $delivery.queue_count}}
		<i class="fa ri-send-plane-2-fill" aria-hidden="true" title="{{$delivery.delivery_almost}} {{$item.delivery.queue_done}}/{{$item.delivery.queue_count}}"></i>
		<span class="sr-only">{{$delivery.delivery_almost}}</span>
	{{else}}
		<i class="fa ri-check-line" aria-hidden="true" title="{{$delivery.delivery_done}} {{$item.delivery.queue_done}}/{{$item.delivery.queue_count}}"></i>
		<span class="sr-only">{{$delivery.delivery_done}}</span>
	{{/if}}
</span>
{{/if}}
