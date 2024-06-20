package com.gammagamma.simplecurrency.widgets

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.receiveAsFlow
import kotlinx.coroutines.launch
import org.koin.core.component.KoinComponent
import presentation.mvi.UiEffect
import presentation.mvi.UiEvent
import presentation.mvi.UiState

// @todo investigate https://github.com/adrielcafe/voyager

abstract class BaseViewModel<Event : UiEvent, State : UiState, Effect : UiEffect> : ViewModel(), KoinComponent {
    
    // @deprecated("Use `state` instead")
    var error by mutableStateOf<String?>(null)
    // @deprecated("Use `state` instead")
    var loading by mutableStateOf(false)
    
    // @deprecated("Use `state` instead")
    protected fun withLoading(func: suspend CoroutineScope.() -> Unit) {
        
        error = null
        loading = true
        
        viewModelScope.launch {
            
            try {
                func()
            } finally {
                loading = false
            }
            
        }
        
    }
    
    //
    
    private val initialState: State by lazy { createInitialState() }
    abstract fun createInitialState(): State
    
    protected val currentState: State
        get() = uiState.value
    
    private val _uiState: MutableStateFlow<State> = MutableStateFlow(initialState)
    val uiState = _uiState.asStateFlow()
    
    private val _event: MutableSharedFlow<Event> = MutableSharedFlow()
    val event = _event.asSharedFlow()
    
    private val _effect: Channel<Effect> = Channel()
    val effect = _effect.receiveAsFlow()
    
    init {
        subscribeEvents()
    }
    
    /**
     * Start listening to Event
     */
    private fun subscribeEvents() {
        viewModelScope.launch {
            event.collect {
                handleEvent(it)
            }
        }
    }
    
    /**
     * Handle each event
     */
    abstract fun handleEvent(event: Event)
    
    /**
     * Set new Event
     */
    fun setEvent(event: Event) {
        val newEvent = event
        viewModelScope.launch { _event.emit(newEvent) }
    }
    
    /**
     * Set new Ui State
     */
    protected fun setState(reduce: State.() -> State) {
        val newState = currentState.reduce()
        _uiState.value = newState
    }
    
    /**
     * Set new Effect
     */
    protected fun setEffect(builder: () -> Effect) {
        val effectValue = builder()
        viewModelScope.launch { _effect.send(effectValue) }
    }
    
}
