package com.gammagamma.simplecurrency.ui.screens.home

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.viewModelScope
import com.gammagamma.simplecurrency.domain.ui.features.currencies.ACurrenciesRepository
import com.gammagamma.simplecurrency.domain.ui.features.currencies.CurrenciesContract
import com.gammagamma.simplecurrency.domain.ui.features.currencies.GetCurrenciesUseCase
import com.gammagamma.simplecurrency.services.IApiService
import com.gammagamma.simplecurrency.services.Log
import com.gammagamma.simplecurrency.widgets.BaseViewModel
import kotlinx.coroutines.launch
import org.koin.core.component.inject
import presentation.mvi.ResourceUiState

class HomeViewModel(
    private val apiService: IApiService,
    private val getCurrenciesUseCase: GetCurrenciesUseCase)
    : BaseViewModel<CurrenciesContract.Event, CurrenciesContract.State, CurrenciesContract.Effect>() {
    
        init {
            fetchCurrencies()
        }
    
    override fun createInitialState(): CurrenciesContract.State =
        CurrenciesContract.State(currencies = ResourceUiState.Idle)
    
    override fun handleEvent(event: CurrenciesContract.Event) {
        when (event) {
            CurrenciesContract.Event.OnTryCheckAgainClick -> fetchCurrencies()
            is CurrenciesContract.Event.OnCurrencyClick -> setEffect {
                CurrenciesContract.Effect.NavigateToDetailCharacter(
                    event.idCharacter
                )
            }
            
            CurrenciesContract.Event.OnFavoritesClick -> setEffect { CurrenciesContract.Effect.NavigateToFavorites }
        }
    }
    
    fun fetchCurrencies() {
        setState { copy(currencies = ResourceUiState.Loading) }
        viewModelScope.launch {
            getCurrenciesUseCase(Unit)
                .onSuccess {
                    setState {
                        copy(
                            currencies = if (it.currencies.isEmpty())
                                ResourceUiState.Empty
                            else
                                ResourceUiState.Success(it)
                        )
                    }
                }
                .onFailure {
                    setState { copy(currencies = ResourceUiState.Error(it)) } }
        }
    }
    
    var response by mutableStateOf("")
    
    private val currenciesRepository by inject<ACurrenciesRepository>()
    
    /*init {
        viewModelScope.launch {
            currenciesRepository.currencies.collect { state ->
                response = when (state) {
                    is CurrenciesUiState.Error -> {
                        "Error: ${state.error.message}".also {
                            error = it
                        }
                    }
                    is CurrenciesUiState.Loading -> {
                        error = null
                        loading = true
                        ""
                    }
                    is CurrenciesUiState.Success -> state.currencies.asDemoString()
                }
            }
        }
    }*/
    
    fun fetchStatus() = withLoading {
        try {
            val status = apiService.getStatus()
            response = "${status.name} @ version: ${status.version}"
        } catch (e: Exception) {
            Log.e("fetchStatus: ${e.message ?: e.cause ?: "Unknown"}")
        }
    }
    
    /*fun fetchCurrencies() = withLoading {
        try {
            currenciesRepository.fetchCurrencies()
        } catch (e: Exception) {
            Log.e("fetchCurrencies: ${e.message ?: e.cause ?: "Unknown"}")
        }
    }*/
    
    fun fetchPairs() = withLoading {
        try {
            val res = apiService.getPairs("USD", "EUR", "JPY")
            response = "(from ${res.source}): ${res.data.rates["USD"]} = ${res.data.rates["EUR"]}EUR, ${res.data.rates["JPY"]}JPY"
        } catch (e: Exception) {
            Log.e("fetchPairs: ${e.message ?: e.cause ?: "Unknown"}")
        }
    }
    
}
