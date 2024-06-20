package com.gammagamma.simplecurrency.di

import com.gammagamma.simplecurrency.domain.ui.features.currencies.ACurrenciesRepository
import com.gammagamma.simplecurrency.domain.ui.features.currencies.GetCurrenciesUseCase
import com.gammagamma.simplecurrency.repositories.CurrenciesRepository
import org.koin.dsl.module

val repositoriesModule = module {
    
    factory<GetCurrenciesUseCase> { GetCurrenciesUseCase(get(), get()) }
    
    // factory<CurrenciesRepository> { params -> CurrenciesRepositoryImpl(params.get(), get()) }
    factory<ACurrenciesRepository> { CurrenciesRepository(get(), get()) }
    
}
