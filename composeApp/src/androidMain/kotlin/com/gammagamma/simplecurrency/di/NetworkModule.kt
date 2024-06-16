package com.gammagamma.simplecurrency.di

import Constants
import io.ktor.client.HttpClient
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json
import org.koin.dsl.module
import com.gammagamma.simplecurrency.services.ApiService
import com.gammagamma.simplecurrency.services.ApiServiceImpl
import com.gammagamma.simplecurrency.services.Log
import io.ktor.client.engine.cio.CIO
import io.ktor.client.engine.okhttp.OkHttp
import io.ktor.client.plugins.DefaultRequest
import io.ktor.client.plugins.logging.LogLevel
import io.ktor.client.plugins.logging.*
import io.ktor.http.URLProtocol
import io.ktor.http.path

val networkModule = module {
    
    single { HttpClient(CIO) {
        
        engine {
            /*https {
                trustManager = SslSettings.getTrustManager()
            }*/
            /*https {
                TLSVersion.TLS10
            }*/
        }
        
        install(Logging) {
            level = LogLevel.INFO
            logger = object: Logger {
                override fun log(message: String) {
                    Log.d("HTTP Client: $message")
                }
            }
            
        }
        
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
                host = Constants.SERVER_HOST
                port = Constants.SERVER_PORT
                path("api/")
                // header("X-Custom-Header", "Hello")
            }
        }
        
    } }
    
    factory<ApiService> { ApiServiceImpl(get()) }
    
//    factoryOf(::Hello)
    
}
