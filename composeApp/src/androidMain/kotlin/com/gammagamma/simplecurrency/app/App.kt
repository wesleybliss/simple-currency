package com.gammagamma.simplecurrency.app

import androidx.compose.material.MaterialTheme
import androidx.compose.runtime.*
import com.gammagamma.simplecurrency.ui.navigation.AppNavHost
import org.jetbrains.compose.ui.tooling.preview.Preview

@Composable
@Preview
fun App() {
    
    /*viewModelScope.launch {
    val user = myApiService.getUser(123)
    // Handle the user data
    }*/
    
    MaterialTheme {
        
        AppNavHost()
        
    }
    
}
