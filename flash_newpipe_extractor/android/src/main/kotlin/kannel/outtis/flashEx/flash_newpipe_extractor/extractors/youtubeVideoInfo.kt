package kannel.outtis.flashEx.flash_newpipe_extractor.extractors

import kannel.outtis.flashEx.flash_newpipe_extractor.decoders.VideoInfoDecode
import org.schabi.newpipe.extractor.ServiceList


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
          return fullVideoInformation
      }
  }
}