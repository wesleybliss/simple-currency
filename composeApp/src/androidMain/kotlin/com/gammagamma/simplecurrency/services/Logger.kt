package com.gammagamma.simplecurrency.services

import timber.log.Timber

object Log {
    
    fun d(message: String, vararg args: Any) {
        Timber.d(message, *args)
    }
    
    fun i(message: String, vararg args: Any) {
        Timber.i(message, *args)
    }
    
    fun w(message: String, vararg args: Any) {
        Timber.w(message, *args)
    }
    
    fun e(message: String, vararg args: Any) {
        Timber.e(message, *args)
    }
    
    fun wtf(message: String, vararg args: Any) {
        Timber.wtf(message, *args)
    }
    
}

