package com.gammagamma.simplecurrency.services

import com.gammagamma.simplecurrency.domain.model.Status
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.get
import io.ktor.http.Url
import models.User

interface ApiService {
    
    // suspend fun getStatus(): /*User*/ String
    suspend fun getStatus(): Status
//    suspend fun getStatus(): /*User*/ String
    
}

class ApiServiceImpl(private val client: HttpClient) : ApiService {
    
    override suspend fun getStatus(): Status = client
//        .get(Url("${Constants.SERVER_HOST}:${Constants.SERVER_PORT}")).body()
        .get("status").body()
    
    /*override suspend fun getStatus(): String = client
        .get("/status").body()*/
    
}
