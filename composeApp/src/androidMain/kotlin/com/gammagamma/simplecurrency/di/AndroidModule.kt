package com.gammagamma.simplecurrency.di

import com.gammagamma.simplecurrency.ui.screens.home.HomeViewModel
import org.koin.androidx.viewmodel.dsl.viewModelOf
import org.koin.dsl.module

val androidModule = module {
    
    /*single { rememberNavController() }*/
    
    viewModelOf(::HomeViewModel)
    
}
