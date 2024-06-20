package com.gammagamma.simplecurrency.domain.ui.features.currencies

import com.gammagamma.simplecurrency.domain.model.Currencies
import com.gammagamma.simplecurrency.domain.ui.BaseUseCase
import kotlinx.coroutines.CoroutineDispatcher

class GetCurrenciesUseCase(
    private val repository: ACurrenciesRepository,
    dispatcher: CoroutineDispatcher,
) : BaseUseCase<Unit, Currencies>(dispatcher){
    
    override suspend fun block(param: Unit): Currencies = repository.fetchCurrencies()
    
}
