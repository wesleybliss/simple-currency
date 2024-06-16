package com.gammagamma.simplecurrency.services

import com.gammagamma.simplecurrency.domain.model.Currencies
import com.gammagamma.simplecurrency.domain.model.Pairs
import com.gammagamma.simplecurrency.domain.model.Response
import com.gammagamma.simplecurrency.domain.model.Status
import com.gammagamma.simplecurrency.utils.NetworkUtils
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.get
import io.ktor.http.Url
import models.User

interface ApiService {
    
    // suspend fun getStatus(): /*User*/ String
    suspend fun getStatus(): Status
    suspend fun getCurrencies(): Response<Currencies>
    suspend fun getPairs(base: String, vararg targets: String): Response<Pairs>
    
}

class ApiServiceImpl(private val client: HttpClient) : ApiService {
    
    override suspend fun getStatus() : Status =
        client.get("status").body()
    
    override suspend fun getCurrencies(): Response<Currencies> =
        client.get("currencies").body()
    
    override suspend fun getPairs(base: String, vararg targets: String) : Response<Pairs> {
        
        val queryString = NetworkUtils.buildQueryString(
            "value" to 1,
            "base" to base,
            "targets" to targets.joinToString(",")
        )
        
        return client.get("pairs?$queryString").body()
        
    }
    
}
