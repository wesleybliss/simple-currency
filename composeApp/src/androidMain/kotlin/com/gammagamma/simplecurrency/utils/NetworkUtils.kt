package com.gammagamma.simplecurrency.utils

object NetworkUtils {
    
    fun buildQueryString(vararg params: Pair<String, Any>) : String {
        
        val queryParams = mutableMapOf<String, Any>()
        
        params.forEach {
            queryParams[it.first] = it.second
        }
        
        // Encoding the query parameters into a query string
        return queryParams.entries.joinToString("&") { "${it.key}=${it.value}" }
        
    }
    
}
