package com.gammagamma.simplecurrency.app

import android.app.Application
import android.content.Context
import android.content.pm.ApplicationInfo
import com.gammagamma.simplecurrency.di.initKoin
import com.gammagamma.simplecurrency.services.NotLoggingTree
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger
import org.koin.core.logger.Level
import timber.log.Timber

fun Context.isDebug() = 0 != applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE

class SimpleCurrencyApp : Application() {
    
    override fun onCreate() {
        
        super.onCreate()
        
        if (isDebug())
            Timber.plant(Timber.DebugTree())
        else
            Timber.plant(NotLoggingTree())
        
        initKoin {
            androidContext(this@SimpleCurrencyApp)
//            androidLogger(if (isDebug()) Level.ERROR else Level.NONE)
            androidLogger(Level.INFO)
        }
        
    }
    
}
