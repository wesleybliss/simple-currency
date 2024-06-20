package com.gammagamma.simplecurrency.domain.ui.features.currencies

import com.gammagamma.simplecurrency.domain.model.Currencies
import com.gammagamma.simplecurrency.domain.ui.state.CurrenciesUiState
import com.gammagamma.simplecurrency.services.IApiService
import kotlinx.coroutines.flow.StateFlow

abstract class ACurrenciesRepository(protected val apiService: IApiService) {
    
    abstract val currencies: StateFlow<CurrenciesUiState>
    
    abstract suspend fun fetchCurrencies() : Currencies
    
}
