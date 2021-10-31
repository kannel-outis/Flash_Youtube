package kannel.outis.flash_utils

import android.app.Activity
import android.app.PictureInPictureParams
import android.content.Context
import android.content.Context.MODE_PRIVATE
import android.content.res.Configuration
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.util.Rational
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri

import android.util.Log
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.PluginRegistry
import org.json.JSONObject
import kotlin.properties.Delegates


/** FlashUtilsPlugin */
class FlashUtilsPlugin: FlutterPlugin, MethodCallHandler , ActivityAware, PluginRegistry.ActivityResultListener, PluginRegistry.UserLeaveHintListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
//  private var shouldEnterPip by Delegates.notNull<Boolean>()
  private lateinit var eventChannel: EventChannel
  private lateinit var channel : MethodChannel
  private lateinit var activity: Activity
  private lateinit var binding: ActivityPluginBinding
  private val requestCode:Int = 1234321234
  private val eventSink = EventSink()
  private lateinit var prefs: SharedPreferences
  val PIPBuilder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
    PictureInPictureParams.Builder()
  } else {
    TODO("VERSION.SDK_INT < O")
  }


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flash_utils")
    channel.setMethodCallHandler(this)
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger,"flashEventChannel")
    prefs = flutterPluginBinding.applicationContext.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)

//    shouldEnterPip = shouldPipPrefs
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val methodCalled = call.method
    when{
      methodCalled.equals("enterPiPMode")->{
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {


          val height = call.argument<Int>("height")
          val width = call.argument<Int>("width")
          val ratio = Rational(width!!, height!!)
          PIPBuilder.setAspectRatio(ratio)
          activity.enterPictureInPictureMode(PIPBuilder.build())
          activity.onPictureInPictureModeChanged(false, Configuration())
          result.success(true)
        }
      }
      methodCalled.equals("select_folder")->{
        val intent =
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                  Intent(Intent.ACTION_OPEN_DOCUMENT_TREE)
                } else {
                  TODO("VERSION.SDK_INT < LOLLIPOP")
                }
//        intent.setType("*/*")
        activity.startActivityForResult(intent, requestCode)
        eventChannel.setStreamHandler(FlashStreamHandler(eventSink))
        result.success(null)

      }
    }
  }



  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    this.binding = binding
    binding.addActivityResultListener(this)
    binding.addOnUserLeaveHintListener(this)
  }

//  @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    var returnBool = false
    if(requestCode == this.requestCode){
      when{
        checkResult(resultCode, Activity.RESULT_OK)->{
          returnBool = true
          val uri: Uri = data?.data!!
          eventSink.success(mapOf("result" to mapOf("path" to "${uri.path}", "isAbsolute" to uri.isAbsolute, "isRelative" to uri.isRelative, "encodedPath" to "${uri.encodedPath}")))
          Log.d("Flash_utils", "${uri.path}")
        }
        checkResult(resultCode, Activity.RESULT_CANCELED)->{
          eventSink.success(mapOf("canceled" to "Request canceled"))
          Log.d("Flash_utils", "Nothing picked")
        }
      }
    }
    return returnBool
  }


  override fun onUserLeaveHint() {
    val shouldEnterPip = prefs.getBoolean("flutter.allow_PIP", false)
    val canEnterPiP = prefs.getBoolean("flutter.can_go_pip", false)
    Log.d("user_hint_leave", "shouldEnterPip $shouldEnterPip , canEnterPip $canEnterPiP")
    if(shouldEnterPip && canEnterPiP){
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        activity.enterPictureInPictureMode(PIPBuilder.build())
      }
    }
  }




  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
   onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    this.binding.removeActivityResultListener(this)
    this.binding.removeOnUserLeaveHintListener(this)
  }

  private fun checkResult(resultCode:Int, activityResultCode:Int): Boolean{
    return resultCode == activityResultCode
  }

  private fun JSONObject.toMap(): Map<String, String> {
    val map = mutableMapOf<String, String>()
    val keysItr: Iterator<String> = this.keys()
    while (keysItr.hasNext()) {
      val key = keysItr.next()
      val value: String = this.get(key) as String
      map[key] = value
    }
    println(map)
    return map
  }
}
