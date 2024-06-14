package com.gammagamma.simplecurrency.ui.screens.home

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.viewModelScope
import com.gammagamma.simplecurrency.services.ApiService
import com.gammagamma.simplecurrency.services.Log
import com.gammagamma.simplecurrency.widgets.BaseViewModel
import kotlinx.coroutines.launch

class HomeViewModel(private val apiService: ApiService) : BaseViewModel() {
    
    var response by mutableStateOf("")
    
    fun fetchStatus() {
        
        viewModelScope.launch {
            try {
                val status = apiService.getStatus()
                response = status
            } catch (e: Exception) {
                Log.e("fetchStatus: ${e.message ?: e.cause ?: "Unknown"}")
            }
        }
        
    }
    
}
