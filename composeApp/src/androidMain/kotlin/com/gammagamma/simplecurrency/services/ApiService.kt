package com.gammagamma.simplecurrency.services

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.get
import models.User

interface ApiService {
    
    suspend fun getStatus(): /*User*/ String
    
}

class ApiServiceImpl(private val client: HttpClient) : ApiService {
    
    override suspend fun getStatus(): String = client
        .get("/").body()
    
}
