package com.gammagamma.simplecurrency

import Greeting
import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun main() {
    
    embeddedServer(Netty, port = Constants.SERVER_PORT, host = Constants.SERVER_HOST, module = Application::module)
        .start(wait = true)
    
}

fun Application.module() {
    
    routing {
        
        get("/") {
            call.respondText("Ktor: ${Greeting().greet()}")
        }
        
    }
    
}
