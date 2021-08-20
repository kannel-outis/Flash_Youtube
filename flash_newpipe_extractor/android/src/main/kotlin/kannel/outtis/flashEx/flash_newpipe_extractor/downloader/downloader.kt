package kannel.outtis.flashEx.flash_newpipe_extractor.downloader

import android.text.TextUtils
import android.util.Log
import org.schabi.newpipe.extractor.downloader.Downloader
import org.schabi.newpipe.extractor.downloader.Request
import org.schabi.newpipe.extractor.downloader.Response
import okhttp3.OkHttpClient
import java.util.*
import java.util.concurrent.TimeUnit


import org.schabi.newpipe.extractor.exceptions.ReCaptchaException

import okhttp3.RequestBody


//object FlashDownloaderSingletonClass{
//    fun instance():FlashDownloader=FlashDownloader().getInstance(OkHttpClient.Builder())
//}


class FlashDownloader(private val builder:OkHttpClient.Builder):Downloader(){
    private val userAgent = "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Firefox/68.0"
    private val youtubeRestrictedModeCookieKey = "youtube_restricted_mode_key"
    private val recaptchaCookiesKey = "recaptcha_cookies"
    private val youtubeDomain = "youtube.com"
    private var cookies: MutableMap<String, String> = mutableMapOf()
    private var client: OkHttpClient = builder.readTimeout(30, TimeUnit.SECONDS).build()

    companion object{
        var instance:FlashDownloader? = null


        fun instance(): FlashDownloader{
            if(instance == null){
                instance = FlashDownloader(OkHttpClient.Builder())
            }
            return instance!!
        }
    }



    private fun getCookies(url: String): String {
        val resultCookies: MutableList<String> = ArrayList()
        if (url.contains(youtubeDomain)) {
            val youtubeCookie = getCookie(youtubeRestrictedModeCookieKey)
            if (youtubeCookie != null) {
                resultCookies.add(youtubeCookie)
            }
        }
        val recaptchaCookie = getCookie(recaptchaCookiesKey)
        if (recaptchaCookie != null) {
            resultCookies.add(recaptchaCookie)
        }
        return concatCookies(resultCookies)
    }

    private fun getCookie(key: String?): String? {
        return cookies[key]
    }

    fun setCookie(cookie: String) {
        cookies[recaptchaCookiesKey] = cookie
    }

    fun removeCookie(key: String?) {
        cookies.remove(key)
    }



    override fun execute(request: Request): Response {
        val httpMethod = request.httpMethod()
        val url = request.url()
        val headers = request.headers()
        val dataToSend = request.dataToSend()

        var requestBody: RequestBody? = null
        if (dataToSend != null) {
            requestBody = RequestBody.create(null, dataToSend)
        }

        val requestBuilder = okhttp3.Request.Builder()
                .method(httpMethod, requestBody).url(url)
                .addHeader("User-Agent", userAgent)

        val cookies = getCookies(url)
        Log.d("COOKIE", cookies)
        if (cookies.isNotEmpty()) {
            requestBuilder.addHeader("Cookie", cookies)
        }

        for ((headerName, headerValueList) in headers) {
            if (headerValueList.size > 1) {
                requestBuilder.removeHeader(headerName)
                for (headerValue in headerValueList) {
                    requestBuilder.addHeader(headerName, headerValue)
                }
            } else if (headerValueList.size == 1) {
                requestBuilder.header(headerName, headerValueList[0])
            }
        }

        val response = client.newCall(requestBuilder.build()).execute()

        if (response.code() == 429) {
            response.close()
            throw ReCaptchaException("reCaptcha Challenge requested: $url", url)
        }

        val body = response.body()
        var responseBodyToReturn: String? = null

        if (body != null) {
            responseBodyToReturn = body.string()
        }

        val latestUrl = response.request().url().toString()
        return Response(response.code(), response.message(), response.headers().toMultimap(),
                responseBodyToReturn, latestUrl)
    }



    private fun concatCookies(resultCookies:List<String>): String{
        val cookieSet: MutableSet<String> = mutableSetOf()
        for (cookies in resultCookies) {
            cookieSet.addAll(splitCookies(cookies))
        }
        return TextUtils.join("; ", cookieSet).trim();
    }

    private fun splitCookies(cookies: String): Set<String> {
        return cookies.split("; *").toMutableSet()
    }

}