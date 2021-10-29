package kannel.outis.flash_utils

import io.flutter.plugin.common.EventChannel

class FlashStreamHandler(private val eventSink:EventSink) : EventChannel.StreamHandler {
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        if(events != null) eventSink.setEventSinkAndReset(events)
    }

    override fun onCancel(arguments: Any?) {
        eventSink.setEventSinkAndReset(null)
    }
}