package kannel.outtis.flashEx.flash_newpipe_extractor

import android.content.SharedPreferences
import android.os.Handler
import android.os.Looper
import androidx.preference.PreferenceManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kannel.outtis.flashEx.flash_newpipe_extractor.downloader.FlashDownloader
import kannel.outtis.flashEx.flash_newpipe_extractor.extractors.YoutubeTrending
import org.schabi.newpipe.extractor.NewPipe
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

class FlashNewPipeExtractorPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val context = flutterPluginBinding.applicationContext
    NewPipe.init(FlashDownloader.instance())
    val preferences: SharedPreferences = PreferenceManager
            .getDefaultSharedPreferences(context);
    val cookie:String? = preferences.getString("prefs_cookies_key", "");
    if (cookie != null) {
      FlashDownloader.instance().setCookie(cookie);
    }
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flash_newPipe_extractor")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val executor: ExecutorService = Executors.newSingleThreadExecutor();
    val  handler:Handler = Handler(Looper.getMainLooper());

    executor.execute(Runnable {
      if (call.method.equals("getTrending")) {
        val listOfTrendingVideos = YoutubeTrending.getTrendingPage()
        handler.post(Runnable {
          result.success(listOfTrendingVideos)
        })
      } else {
        handler.post(Runnable {
          result.notImplemented()
        })
      }
    })

  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

