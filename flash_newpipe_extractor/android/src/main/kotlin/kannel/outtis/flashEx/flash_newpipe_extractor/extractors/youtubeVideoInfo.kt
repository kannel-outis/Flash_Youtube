package kannel.outtis.flashEx.flash_newpipe_extractor.extractors

import kannel.outtis.flashEx.flash_newpipe_extractor.decoders.VideoInfoDecode
import org.schabi.newpipe.extractor.ListExtractor
import org.schabi.newpipe.extractor.ServiceList
import org.schabi.newpipe.extractor.comments.CommentsInfoItem
import org.schabi.newpipe.extractor.services.youtube.extractors.YoutubeTrendingExtractor
import org.schabi.newpipe.extractor.stream.StreamInfoItem
import org.schabi.newpipe.extractor.stream.StreamInfoItemsCollector


class YoutubeVideoInfoExtractor{
  companion object{
      fun getVideoInfoFromUrl( url:String): Map<String, Map<Int, Map<String, Any?>>>{
          val extractor = ServiceList.YouTube.getStreamExtractor(url)
          extractor.fetchPage()
          val fullVideoInformation:MutableMap<String, Map<Int, Map<String, Any?>>> = mutableMapOf()
          fullVideoInformation["fullVideoInfo"] = mapOf(0 to VideoInfoDecode.decoderToMap(extractor))
          fullVideoInformation["audioStreamsMap"] = VideoInfoDecode.decodeAudioStreams(extractor)
          fullVideoInformation["videoOnlyStream"] = VideoInfoDecode.decodeVideoOnlyStreams(extractor)
          fullVideoInformation["videoAudioStream"] = VideoInfoDecode.decodeVideoAudioStream(extractor)

          val streamCollector:StreamInfoItemsCollector = extractor.relatedItems as StreamInfoItemsCollector
          val streamItemsInfo = streamCollector.streamInfoItemList
          val itemsInfoMap: MutableMap<Int, Map<String, Any?>> = mutableMapOf()
          for (i in 0 until streamItemsInfo.size){
              val item: StreamInfoItem = streamItemsInfo[i]
              itemsInfoMap[i] = VideoInfoDecode.toMap(item)
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
              fullCommentsInfo[200] = mutableMapOf("disabled" to extractor.isCommentsDisabled)
          }
          for(i in 0 until items.size){
              val item: CommentsInfoItem = items[i]
              fullCommentsInfo[i] = VideoInfoDecode.decodeCommentsToMap(item)
          }
          return fullCommentsInfo
      }

  }
}