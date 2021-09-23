package kannel.outtis.flashEx.flash_newpipe_extractor.extractors


import android.content.ContentValues.TAG
import android.util.Log
import kannel.outtis.flashEx.flash_newpipe_extractor.decoders.VideoInfoDecode
import org.schabi.newpipe.extractor.ListExtractor
import org.schabi.newpipe.extractor.Page
import org.schabi.newpipe.extractor.ServiceList
import org.schabi.newpipe.extractor.stream.StreamInfoItem
import org.schabi.newpipe.extractor.ServiceList.YouTube
import org.schabi.newpipe.extractor.comments.CommentsInfoItem
import org.schabi.newpipe.extractor.exceptions.ContentNotAvailableException
import org.schabi.newpipe.extractor.services.youtube.extractors.YoutubeChannelExtractor
import org.schabi.newpipe.extractor.services.youtube.extractors.YoutubeTrendingExtractor

class YoutubeExtractors{
    companion object{



        fun getTrendingPage(): Map<Int, Map<String, Any?>>{
            val trendingExtractor =  YouTube.kioskList.defaultKioskExtractor as YoutubeTrendingExtractor

                trendingExtractor.fetchPage()
                val itemsPage = trendingExtractor.initialPage
                val streamInfoItems = itemsPage.items
                val itemsMap: MutableMap<Int, Map<String, Any?>> = mutableMapOf()
                for (i in 0 until streamInfoItems.size) {
                    val item: StreamInfoItem = streamInfoItems[i]

                    itemsMap[i] = VideoInfoDecode.toMap(item)
                }
                return itemsMap

        }

        fun getChannelInfo(channelUrl: String): Map<String, Map<Int, Map<String, Any?>>?> {
            val returnMap: MutableMap<String, Map<Int, Map<String, Any?>>?> = mutableMapOf()


            try {
               val channelExtractor = YouTube.getChannelExtractor(channelUrl) as YoutubeChannelExtractor
               channelExtractor.fetchPage()
               val channelMap: MutableMap<String, Any?> = mutableMapOf(
                       "channelName" to channelExtractor.name,
                       "channelDescription" to channelExtractor.description,
                       "channelId" to channelExtractor.id,
                       "channelAvatarUrl" to channelExtractor.avatarUrl,
                       "channelBannerUrl" to channelExtractor.bannerUrl,
                       "channelFeedUrl" to channelExtractor.feedUrl,
                       "channelSubscriberCount" to channelExtractor.subscriberCount,
                       "channelUrl" to channelExtractor.url
               )
                if(channelExtractor.initialPage.hasNextPage()){
                    channelMap["nextPageInfo"] = mutableMapOf(
                            "id" to channelExtractor.initialPage.nextPage.id,
                            "url" to channelExtractor.initialPage.nextPage.url,
                            "ids" to channelExtractor.initialPage.nextPage.ids,
                            "body" to channelExtractor.initialPage.nextPage.body,
                            "channelHasNextPage" to channelExtractor.initialPage.hasNextPage()
                    )
//                    channelExtractor.getPage().
                }else{
                    channelMap["nextPageInfo"] = mutableMapOf(
                            "id" to null,
                            "url" to null,
                            "body" to null,
                            "ids" to null,
                            "channelHasNextPage" to channelExtractor.initialPage.hasNextPage()
                    )
                }
               val items = channelExtractor.initialPage.items
//                channelExtractor.initialPage
               val itemsMap: MutableMap<Int, Map<String, Any?>> = mutableMapOf()
               for (i in 0 until items.size) {
                   val item = items[i]
                   itemsMap[i] = VideoInfoDecode.toMap(item)

               }
               returnMap["channelInfo"] = mapOf(0 to channelMap)
               returnMap["channelFirstPageVideos"] = itemsMap
               return returnMap
           }catch (e: ContentNotAvailableException){
               returnMap["channelInfo"] = null
               returnMap["channelFirstPageVideos"] = null
                return returnMap
           }
        }

        fun getNextPageItems(page: Page, channelUrl: String?, isComments: Boolean, videoUrl:String?): Map<String, Map<Int, Map<String, Any?>>?>{
            val returnMap: MutableMap<String, Map<Int, Map<String, Any?>>?> = mutableMapOf()
            val extractor = if(isComments)  YouTube.getCommentsExtractor(videoUrl)  else YouTube.getChannelExtractor(channelUrl) as YoutubeChannelExtractor
            extractor.fetchPage()
            val newPage = if(isComments) extractor.getPage(Page(videoUrl, page.id))  else extractor.getPage(page)
            val pageMap:MutableMap<String, Any?> = mutableMapOf()
            if(newPage.hasNextPage()){
                pageMap["newPageInfo"] = mutableMapOf(
                        "id" to newPage.nextPage.id,
                        "url" to newPage.nextPage.url,
                        "ids" to newPage.nextPage.ids,
                        "body" to newPage.nextPage.body,
                        "channelHasNextPage" to newPage.hasNextPage()
                )
            }else{
                pageMap["newPageInfo"] = mutableMapOf(
                        "id" to null,
                        "url" to null,
                        "body" to null,
                        "ids" to null,
                        "channelHasNextPage" to newPage.hasNextPage()
                )
            }
            returnMap["page"] = mapOf(0 to pageMap)
            val itemsMap: MutableMap<Int, Map<String, Any?>> = mutableMapOf()
            for (i in 0 until newPage.items.size){
                val item = newPage.items[i]
                itemsMap[i] = if(isComments)  VideoInfoDecode.decodeCommentsToMap(item as CommentsInfoItem)
                else VideoInfoDecode.toMap(item as StreamInfoItem)
            }
            returnMap["items"] = itemsMap
            return returnMap

        }
    }
}