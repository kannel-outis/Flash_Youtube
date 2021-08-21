package kannel.outtis.flashEx.flash_newpipe_extractor.models

import org.schabi.newpipe.extractor.stream.StreamInfoItem

class VideoInfo(private val item: StreamInfoItem){
    fun toMap():Map<String , Any?>{
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

