package kannel.outtis.flashEx.flash_newpipe_extractor.extractors


import kannel.outtis.flashEx.flash_newpipe_extractor.models.VideoInfoDecode
import org.schabi.newpipe.extractor.ListExtractor
import org.schabi.newpipe.extractor.stream.StreamInfoItem
import org.schabi.newpipe.extractor.ServiceList.YouTube
import org.schabi.newpipe.extractor.services.youtube.extractors.YoutubeTrendingExtractor

class YoutubeTrending{
    companion object{
        var trendingExtractor: YoutubeTrendingExtractor? = null
        var itemsPage : ListExtractor.InfoItemsPage<StreamInfoItem>? = null


        fun getTrendingPage(): Map<Int, Map<String, Any?>>{
            trendingExtractor =  YouTube.kioskList.defaultKioskExtractor as YoutubeTrendingExtractor
            trendingExtractor!!.fetchPage()
            itemsPage = trendingExtractor!!.initialPage
            println(trendingExtractor!!.initialPage.hasNextPage())
            val streamInfoItems = itemsPage!!.items
            val itemsMap: MutableMap<Int, Map<String, Any?>> = mutableMapOf()
            for (i in 0 until streamInfoItems.size) {
                val item: StreamInfoItem = streamInfoItems[i]

                itemsMap[i] = VideoInfoDecode.toMap(item)
            }
            return itemsMap

        }
    }
}