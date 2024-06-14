package com.gammagamma.simplecurrency.services

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.get
import io.ktor.http.Url
import models.User

interface ApiService {
    
    suspend fun getStatus(): /*User*/ String
    
}

class ApiServiceImpl(private val client: HttpClient) : ApiService {
    
    override suspend fun getStatus(): String = client
//        .get(Url("${Constants.SERVER_HOST}:${Constants.SERVER_PORT}")).body()
        .get(Url("https://wesleybliss.com")).body()
    
}
