package com.gammagamma.simplecurrency.di

import com.gammagamma.simplecurrency.services.Store
import org.koin.dsl.module

val storeModule = module {
    
    single { Store(get()) }
    
}
