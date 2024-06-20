package com.gammagamma.simplecurrency.domain.ui.features.currencies

import com.gammagamma.simplecurrency.domain.model.Currencies
import presentation.mvi.ResourceUiState
import presentation.mvi.UiEffect
import presentation.mvi.UiEvent
import presentation.mvi.UiState

interface CurrenciesContract {
    
    sealed interface Event : UiEvent {
        object OnTryCheckAgainClick : Event
        object OnFavoritesClick : Event
        data class OnCurrencyClick(val idCharacter: Int) : Event
    }
    
    data class State(
        val currencies: ResourceUiState<Currencies>
    ) : UiState
    
    sealed interface Effect : UiEffect {
        data class NavigateToDetailCharacter(val idCharacter: Int) : Effect
        data object NavigateToFavorites : Effect
    }
    
}
