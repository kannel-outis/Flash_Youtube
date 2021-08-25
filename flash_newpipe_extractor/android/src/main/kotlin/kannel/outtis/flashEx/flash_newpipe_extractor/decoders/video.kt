package kannel.outtis.flashEx.flash_newpipe_extractor.decoders

import org.schabi.newpipe.extractor.stream.StreamExtractor
import org.schabi.newpipe.extractor.stream.StreamInfoItem

class VideoInfoDecode(){
    companion object{
        fun decodeAudioStreams(extractor: StreamExtractor):Map<Int, Map<String, Any?>>{
            val audioStreams:MutableMap<Int, Map<String, Any?>> = mutableMapOf()
            val streams = extractor.audioStreams
            for (i in 0 until extractor.audioStreams.size){
                val it = streams[i]
                val audioStreamInfo:MutableMap<String, Any?> = mutableMapOf()
                audioStreamInfo["url"] = it.url
                audioStreamInfo["quality"] = it.quality
                audioStreamInfo["averageBitrate"] = it.averageBitrate
                audioStreamInfo["bitrate"] = it.bitrate
                audioStreamInfo["codec"] = it.codec
                audioStreamInfo["torrentUrl"] = it.torrentUrl
                audioStreamInfo["iTag"] = it.itag
                audioStreamInfo["format"] = it.getFormat().suffix
                audioStreams[i] = audioStreamInfo
            }
            return audioStreams
        }

        fun decodeVideoOnlyStreams(extractor: StreamExtractor):Map<Int, Map<String, Any?>>{
            val videoOnlyStreams:MutableMap<Int, Map<String, Any?>> = mutableMapOf()
            val streams = extractor.videoOnlyStreams
            for(i in 0 until streams.size) {
                val videoOnlyStreamInfo:MutableMap<String, Any?> = mutableMapOf()
                val it = streams[i]
                videoOnlyStreamInfo["url"] = it.url
                videoOnlyStreamInfo["quality"] = it.quality
                videoOnlyStreamInfo["fps"] = it.fps
                videoOnlyStreamInfo["bitrate"] = it.bitrate
                videoOnlyStreamInfo["codec"] = it.codec
                videoOnlyStreamInfo["torrentUrl"] = it.torrentUrl
                videoOnlyStreamInfo["iTag"] = it.itag
                videoOnlyStreamInfo["format"] = it.getFormat().suffix
                videoOnlyStreamInfo["resolution"] = it.resolution
                videoOnlyStreamInfo["height"] = it.height
                videoOnlyStreamInfo["width"] = it.width
                videoOnlyStreamInfo["isVideoOnly"] = it.isVideoOnly
                videoOnlyStreams[i] = videoOnlyStreamInfo
            }
            return videoOnlyStreams
        }

        fun decodeVideoAudioStream(extractor: StreamExtractor):Map<Int, Map<String, Any?>>{
            val videoAudioStreams:MutableMap<Int, Map<String, Any?>> = mutableMapOf()
            val streams = extractor.videoStreams
            for(i in 0 until streams.size) {
                val videoAudioStreamInfo:MutableMap<String, Any?> = mutableMapOf()
                val it = streams[i]
                videoAudioStreamInfo["url"] = it.url
                videoAudioStreamInfo["quality"] = it.quality
                videoAudioStreamInfo["fps"] = it.fps
                videoAudioStreamInfo["bitrate"] = it.bitrate
                videoAudioStreamInfo["codec"] = it.codec
                videoAudioStreamInfo["torrentUrl"] = it.torrentUrl
                videoAudioStreamInfo["iTag"] = it.itag
                videoAudioStreamInfo["format"] = it.getFormat().suffix
                videoAudioStreamInfo["resolution"] = it.resolution
                videoAudioStreamInfo["height"] = it.height
                videoAudioStreamInfo["width"] = it.width
                videoAudioStreamInfo["isVideoOnly"] = it.isVideoOnly
                videoAudioStreams[i] = videoAudioStreamInfo
            }
            return videoAudioStreams
        }

        fun decoderToMap(extractor:StreamExtractor): Map<String, Any?>{
            val fullVideoInformation:MutableMap<String, Any?> = mutableMapOf()
            fullVideoInformation["id"] = extractor.id
            fullVideoInformation["url"] = extractor.url
            fullVideoInformation["videoName"] = extractor.name
            fullVideoInformation["uploaderName"] = extractor.uploaderName
            fullVideoInformation["uploaderUrl"] = extractor.uploaderUrl
            fullVideoInformation["uploaderAvatarUrl"] = extractor.uploaderAvatarUrl
            fullVideoInformation["textualUploadDate"] = extractor.textualUploadDate
            fullVideoInformation["uploadDate"] = extractor.uploadDate!!.offsetDateTime().toString()
            fullVideoInformation["description"] = extractor.description.content
            fullVideoInformation["length"] = extractor.length
            fullVideoInformation["viewCount"] = extractor.viewCount
            fullVideoInformation["likeCount"] = extractor.likeCount
            fullVideoInformation["dislikeCount"] = extractor.dislikeCount
            fullVideoInformation["category"] = extractor.category
            fullVideoInformation["ageLimit"] = extractor.ageLimit
            fullVideoInformation["tags"] = extractor.tags.toString()
            fullVideoInformation["thumbnailUrl"] = extractor.thumbnailUrl
            return fullVideoInformation
        }

        fun toMap( item: StreamInfoItem):Map<String , Any?>{
            val itemMap: MutableMap<String, Any?> = mutableMapOf()
            itemMap["name"] = item.name
            itemMap["url"] = item.url
            itemMap["viewCount"] = item.viewCount
            itemMap["textualUploadDate"] = item.textualUploadDate
            itemMap["uploaderName"] = item.uploaderName
            itemMap["uploaderUrl"] = item.uploaderUrl
            itemMap["thumbnailUrl"] = item.thumbnailUrl
            itemMap["duration"] = item.duration
            itemMap["uploadDate"] = item.uploadDate!!.offsetDateTime().toString()
            itemMap["isUploaderVerified"] = item.isUploaderVerified
            return itemMap
        }
    }

}

