package kannel.outtis.flashEx.flash_newpipe_extractor.extractors


import kannel.outtis.flashEx.flash_newpipe_extractor.decoders.VideoInfoDecode
import org.schabi.newpipe.extractor.ListExtractor
import org.schabi.newpipe.extractor.stream.StreamInfoItem
import org.schabi.newpipe.extractor.ServiceList.YouTube
import org.schabi.newpipe.extractor.services.youtube.extractors.YoutubeChannelExtractor
import org.schabi.newpipe.extractor.services.youtube.extractors.YoutubeTrendingExtractor

class YoutubeExtractors{
    companion object{



        fun getTrendingPage(): Map<Int, Map<String, Any?>>{
            var trendingExtractor: YoutubeTrendingExtractor? = null
            var itemsPage : ListExtractor.InfoItemsPage<StreamInfoItem>? = null
            trendingExtractor =  YouTube.kioskList.defaultKioskExtractor as YoutubeTrendingExtractor

                trendingExtractor.fetchPage()
                itemsPage = trendingExtractor.initialPage
                println(trendingExtractor.initialPage.hasNextPage())
                val streamInfoItems = itemsPage.items
                val itemsMap: MutableMap<Int, Map<String, Any?>> = mutableMapOf()
                for (i in 0 until streamInfoItems.size) {
                    val item: StreamInfoItem = streamInfoItems[i]

                    itemsMap[i] = VideoInfoDecode.toMap(item)
                }
                return itemsMap

        }

        fun getChannelInfo(channelUrl: String): Map<String, Map<Int, Map<String, Any?>>> {
            var channelExtractor: YoutubeChannelExtractor? = null
            channelExtractor = YouTube.getChannelExtractor(channelUrl) as YoutubeChannelExtractor
            channelExtractor.fetchPage()
            val returnMap: MutableMap<String, Map<Int, Map<String, Any?>>> = mutableMapOf()
            val channelMap: MutableMap<String, Any> = mutableMapOf(
                    "channelName" to channelExtractor.name,
                    "channelDescription" to channelExtractor.description,
                    "channelId" to channelExtractor.id,
                    "channelAvatarUrl" to channelExtractor.avatarUrl,
                    "channelBannerUrl" to channelExtractor.bannerUrl,
                    "channelFeedUrl" to channelExtractor.feedUrl,
                    "channelSubscriberCount" to channelExtractor.subscriberCount,
                    "channelUrl" to channelExtractor.url)
            val items = channelExtractor.initialPage.items
            val itemsMap: MutableMap<Int, Map<String, Any?>> = mutableMapOf()
            for (i in 0 until items.size) {
                val item = items[i]
                itemsMap[i] = VideoInfoDecode.toMap(item)

            }
            returnMap["channelInfo"] = mapOf(0 to channelMap)
            returnMap["channelFirstPageVideos"] = itemsMap
            return returnMap
        }
    }
}