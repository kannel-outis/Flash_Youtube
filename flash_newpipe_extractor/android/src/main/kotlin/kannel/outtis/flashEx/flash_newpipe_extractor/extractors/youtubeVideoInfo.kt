package kannel.outtis.flashEx.flash_newpipe_extractor.extractors

import android.content.ContentValues.TAG
import android.util.Log
import kannel.outtis.flashEx.flash_newpipe_extractor.decoders.InfoDecoder
import org.schabi.newpipe.extractor.ServiceList
import org.schabi.newpipe.extractor.comments.CommentsInfoItem
import org.schabi.newpipe.extractor.stream.StreamInfoItem
import org.schabi.newpipe.extractor.stream.StreamInfoItemsCollector


class YoutubeVideoInfoExtractor{
  companion object{
      fun getVideoInfoFromUrl( url:String): Map<String, Map<Int, Map<String, Any?>>>{
          val extractor = ServiceList.YouTube.getStreamExtractor(url)
          extractor.fetchPage()
          val fullVideoInformation:MutableMap<String, Map<Int, Map<String, Any?>>> = mutableMapOf()
          fullVideoInformation["fullVideoInfo"] = mapOf(0 to InfoDecoder.decoderToMap(extractor))
          fullVideoInformation["audioStreamsMap"] = InfoDecoder.decodeAudioStreams(extractor)
          fullVideoInformation["videoOnlyStream"] = InfoDecoder.decodeVideoOnlyStreams(extractor)
          fullVideoInformation["videoAudioStream"] = InfoDecoder.decodeVideoAudioStream(extractor)

          val streamCollector:StreamInfoItemsCollector = extractor.relatedItems as StreamInfoItemsCollector
          val streamItemsInfo = streamCollector.streamInfoItemList
          val itemsInfoMap: MutableMap<Int, Map<String, Any?>> = mutableMapOf()
          for (i in 0 until streamItemsInfo.size){
              val item: StreamInfoItem = streamItemsInfo[i]
              itemsInfoMap[i] = InfoDecoder.toMap(item)
          }
          fullVideoInformation["relatedVideos"] = itemsInfoMap
          return fullVideoInformation
      }


      fun getCommentsFromUrl(url: String): Map<Int, Map<String, Any?>>{
          val extractor = ServiceList.YouTube.getCommentsExtractor(url)
          val fullCommentsInfo:MutableMap<Int, Map<String, Any?>> = mutableMapOf()
          extractor.fetchPage()
          val items = extractor.initialPage.items
          if(extractor.isCommentsDisabled){
//              return mutableMapOf("disabled" to extractor.isCommentsDisabled)
              fullCommentsInfo[20000] = mutableMapOf("disabled" to extractor.isCommentsDisabled)
          }

          if(extractor.initialPage.hasNextPage()){
              fullCommentsInfo[20001] = mutableMapOf(
                      "id" to extractor.initialPage.nextPage.id,
                      "url" to extractor.initialPage.nextPage.url,
                      "ids" to extractor.initialPage.nextPage.ids,
                      "body" to extractor.initialPage.nextPage.body,
                      "channelHasNextPage" to extractor.initialPage.hasNextPage()

              )
          }else{
              fullCommentsInfo[20001] = mutableMapOf(
                      "id" to null,
                      "url" to null,
                      "body" to null,
                      "ids" to null,
                      "channelHasNextPage" to extractor.initialPage.hasNextPage()
              )
          }

          for(i in 0 until items.size){
              val item: CommentsInfoItem = items[i]
              fullCommentsInfo[i] = InfoDecoder.decodeCommentsToMap(item)
          }
          return fullCommentsInfo
      }

  }
}