package com.gammagamma.simplecurrency.di

import org.koin.core.context.startKoin
import org.koin.dsl.KoinAppDeclaration

fun initKoin(appDeclaration: KoinAppDeclaration = {}) = startKoin {
    
    appDeclaration()
    
    modules(
        androidModule,
        storeModule,
        networkModule,
        repositoriesModule,
    )
    
}
