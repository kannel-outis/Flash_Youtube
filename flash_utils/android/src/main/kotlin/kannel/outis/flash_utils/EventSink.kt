package kannel.outis.flash_utils

import io.flutter.plugin.common.EventChannel

data class EventError(
        val message:String?,
        val code:String?,
        val details:Any?
)

class EventSink : EventChannel.EventSink{
    private var eventSink:EventChannel.EventSink? = null
    private var endOfStream:Boolean = false
    private var event:Any? = null
    private var error:EventError? = null

    fun setEventSinkAndReset(newSink:EventChannel.EventSink?): Unit{
        this.eventSink = newSink
        resetStream()
    }

    override fun success(event: Any?) {
        this.event = event
        resetStream()
    }

    override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
        error = EventError(code = errorCode, message = errorMessage, details = errorDetails)
        resetStream()
    }


    override fun endOfStream() {
        endOfStream = true
        resetStream()
    }

    private fun resetStream():Unit{
        if(eventSink == null) return
        if(endOfStream) {
            eventSink!!.endOfStream()
            endOfStream = false
        }
        if (event != null){
            eventSink!!.success(event)
            event = null
        }
        if (error != null){
            eventSink!!.error(error!!.code, error!!.message, error!!.details)
            error = null
        }
    }

}