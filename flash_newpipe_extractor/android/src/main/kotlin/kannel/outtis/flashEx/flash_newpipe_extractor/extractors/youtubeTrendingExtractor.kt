package kannel.outtis.flashEx.flash_newpipe_extractor.extractors


import android.util.Log
import org.schabi.newpipe.extractor.ListExtractor
import org.schabi.newpipe.extractor.stream.StreamInfoItem
import org.schabi.newpipe.extractor.ServiceList.YouTube
import org.schabi.newpipe.extractor.services.youtube.extractors.YoutubeTrendingExtractor
import java.lang.NullPointerException

class YoutubeTrending{
    companion object{
        var trendingExtractor: YoutubeTrendingExtractor? = null
        var itemsPage : ListExtractor.InfoItemsPage<StreamInfoItem>? = null


        fun getTrendingPage(): Map<Int, Map<String, String?>>{
            Log.d("StreamInfo", "streamInfoItem.name" )
            trendingExtractor =  YouTube.kioskList.defaultKioskExtractor as YoutubeTrendingExtractor
            trendingExtractor!!.fetchPage()
            itemsPage = trendingExtractor!!.initialPage
            val streamInfoItems = itemsPage!!.items
            val itemsMap: MutableMap<Int, Map<String, String?>> = mutableMapOf()
            for (i in 0 until streamInfoItems.size) {
                val item: StreamInfoItem = streamInfoItems[i]
                val itemMap: MutableMap<String, String?> = mutableMapOf()
                itemMap["name"] = item.name
                itemMap["url"] = item.url
                itemMap["viewCount"] = item.viewCount.toString()
                itemMap["textualUploadDate"] = item.textualUploadDate
                itemMap["uploaderName"] = item.uploaderName
                itemMap["uploaderUrl"] = item.uploaderUrl
                itemMap["thumbnailUrl"] = item.thumbnailUrl
                itemMap["duration"] = item.duration.toString()
                itemMap["uploadDate"] = item.uploadDate!!.offsetDateTime().toString()
                itemMap["isUploaderVerified"] = item.isUploaderVerified.toString()
                itemsMap[i] = itemMap
            }
            return itemsMap

        }
    }
}