package com.gammagamma.simplecurrency.domain.ui.state

import com.gammagamma.simplecurrency.domain.model.Currencies

sealed class CurrenciesUiState {
    data class Error(val error: Throwable) : CurrenciesUiState()
    data object Loading : CurrenciesUiState()
    data class Success(val currencies: Currencies) : CurrenciesUiState()
}
