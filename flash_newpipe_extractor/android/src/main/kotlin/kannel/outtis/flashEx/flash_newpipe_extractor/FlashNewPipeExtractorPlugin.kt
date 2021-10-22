package kannel.outtis.flashEx.flash_newpipe_extractor

import android.content.Context
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
import kannel.outtis.flashEx.flash_newpipe_extractor.extractors.YoutubeExtractors
import kannel.outtis.flashEx.flash_newpipe_extractor.extractors.YoutubeVideoInfoExtractor
import org.json.JSONArray
import org.json.JSONObject
import org.schabi.newpipe.extractor.NewPipe
import org.schabi.newpipe.extractor.Page
import org.schabi.newpipe.extractor.localization.ContentCountry
import org.schabi.newpipe.extractor.localization.Localization
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

class FlashNewPipeExtractorPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val context = flutterPluginBinding.applicationContext
    val contentPref = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
    val sharedString = contentPref.getString("flutter.content_country", null)
    val jsonMapObj = JSONObject(sharedString)
    val contentCountryString = jsonMapObj.toMap()["code"]?:"NG"
    
//    TODO: always get contentCountry from shared preferences
    NewPipe.init(FlashDownloader.instance(), Localization.DEFAULT, ContentCountry(contentCountryString))
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
    val  handler = Handler(Looper.getMainLooper());

    try {
      executor.execute(Runnable {
        when {
          call.method.equals("getTrending") -> {
            val listOfTrendingVideos = YoutubeExtractors.getTrendingPage()
            handler.post {
              result.success(listOfTrendingVideos)
            }
          }
          call.method.equals("getVideoInfoFromUrl") -> {
            val url = call.argument<String>("url")
            val fullVideoInfo = YoutubeVideoInfoExtractor.getVideoInfoFromUrl(url!!)
            handler.post {
              result.success(fullVideoInfo)
            }
          }

          call.method.equals("getChannelInfo")->{
            val channelUrl = call.argument<String>("channelUrl")
            val channelInfo = YoutubeExtractors.getChannelInfo(channelUrl!!)
            handler.post {
              result.success(channelInfo)
            }
          }
          call.method.equals("getComments")->{
            val url = call.argument<String>("url")
            val comments = YoutubeVideoInfoExtractor.getCommentsFromUrl(url!!)
            handler.post {
              result.success(comments)
            }
          }
          call.method.equals("getChannelNextPageItems")->{
            val value = call.argument<String>("value")
            val type = call.argument<String>("Type")
            val pageUrl = call.argument<Map<String, Any>>("pageInfo")!!["url"] as String?
            val body = call.argument<Map<String, Any>>("pageInfo")!!["body"] as ByteArray?
            val id = call.argument<Map<String, Any>>("pageInfo")!!["id"] as String?
            val ids = call.argument<Map<String, Any>>("pageInfo")!!["ids"] as List<String>?
//          val isComment = call.argument<Boolean>("isComments")

            val newItems = YoutubeExtractors.getNextPageItems(
                    page = Page(pageUrl, id, ids, null, body),
                    type = type!!,
                    value = value!!
            )
            handler.post {
              result.success(newItems)
            }
          }

          call.method.equals("getSearchSuggestions")->{
            val query = call.argument<String>("query")
            val suggestions = YoutubeExtractors.getQuerySuggestions(query!!)
            handler.post {
              result.success(suggestions)
            }
          }
          call.method.equals("getSearchResults")->{
            val query = call.argument<String>("query")
            val searchResult = YoutubeExtractors.getSearchResults(query!!)
            handler.post {
              result.success(searchResult)
            }
          }
          call.method.equals("getPlaylistInfo")->{
            val url = call.argument<String>("url")
            val info = YoutubeExtractors.getPlaylistInfo(url!!)
            handler.post {
              result.success(info)
            }
          }
          else -> {
            handler.post(Runnable {
              result.notImplemented()
            })
          }
        }
      })

    }catch (e: Exception){

      result.error("404", e.message, e.stackTrace)

    }



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

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}




