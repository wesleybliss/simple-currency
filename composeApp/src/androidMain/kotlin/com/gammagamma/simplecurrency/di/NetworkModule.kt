package com.gammagamma.simplecurrency.di

import Constants
import io.ktor.client.HttpClient
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json
import org.koin.dsl.module
import com.gammagamma.simplecurrency.services.ApiService
import com.gammagamma.simplecurrency.services.ApiServiceImpl
import io.ktor.client.plugins.DefaultRequest
import io.ktor.http.URLProtocol
import org.koin.core.module.dsl.factoryOf

val networkModule = module {
    
    single { HttpClient {
        
        install(ContentNegotiation) {
            json(Json {
                ignoreUnknownKeys = true
                prettyPrint = true
                isLenient = true
            })
        }
        
        install(DefaultRequest) {
            url {
                protocol = URLProtocol.HTTP
                host = Constants.serverHost
                port = Constants.serverPort
            }
        }
        
    } }
    
    factory<ApiService> { ApiServiceImpl(get()) }
    
//    factoryOf(::Hello)
    
}
