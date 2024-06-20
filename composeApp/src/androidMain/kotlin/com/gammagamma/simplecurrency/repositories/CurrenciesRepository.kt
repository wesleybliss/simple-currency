package com.gammagamma.simplecurrency.repositories

import com.gammagamma.simplecurrency.domain.model.Currencies
import com.gammagamma.simplecurrency.domain.ui.features.currencies.ACurrenciesRepository
import com.gammagamma.simplecurrency.domain.ui.state.CurrenciesUiState
import com.gammagamma.simplecurrency.services.IApiService
import com.gammagamma.simplecurrency.services.Store
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update

class CurrenciesRepository(apiService: IApiService, private val store: Store) : ACurrenciesRepository(apiService) {
    
    private val _currencies = MutableStateFlow<CurrenciesUiState>(CurrenciesUiState.Loading)
    override val currencies = _currencies.asStateFlow()
    
    override suspend fun fetchCurrencies() : Currencies {
        
        val cached = store.currencies.get()
        
        if (cached?.currencies?.isNotEmpty() == true)
            _currencies.update { CurrenciesUiState.Success(cached) }
        
        val res = apiService.getCurrencies()
//        val items = mutableListOf<String>()
        
        store.currencies.set(res.data)
        
        /*res.data.currencies.forEach { (symbol, name) ->
            items.add("${symbol}: $name")
        }
        
        val result = items.joinToString("\n")*/
        
        _currencies.update { CurrenciesUiState.Success(res.data) }
        
        return res.data
        
    }
    
}
