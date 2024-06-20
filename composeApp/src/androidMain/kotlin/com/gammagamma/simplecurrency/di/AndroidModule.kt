package com.gammagamma.simplecurrency.di

import com.gammagamma.simplecurrency.ui.screens.home.HomeViewModel
import kotlinx.coroutines.Dispatchers
import org.koin.androidx.viewmodel.dsl.viewModelOf
import org.koin.dsl.module

val androidModule = module {
    
    factory { Dispatchers.Default }
    
    /*single { rememberNavController() }*/
    
    viewModelOf(::HomeViewModel)
    
}
