package com.gammagamma.simplecurrency.services

import timber.log.Timber

class NotLoggingTree : Timber.Tree() {
    
    override fun log(priority: Int, tag: String, message: String, throwable: Throwable) {}
    
}
