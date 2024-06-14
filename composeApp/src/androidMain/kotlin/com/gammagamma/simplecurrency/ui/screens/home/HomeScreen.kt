package com.gammagamma.simplecurrency.ui.screens.home

import Greeting
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material.Button
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.navigation.NavController
import com.gammagamma.simplecurrency.ui.navigation.Route
import com.gammagamma.simplecurrency.widgets.SortableList
import org.jetbrains.compose.resources.painterResource
import org.koin.androidx.compose.koinViewModel
import simplecurrency.composeapp.generated.resources.Res
import simplecurrency.composeapp.generated.resources.compose_multiplatform
import org.koin.androidx.compose.viewModel

const val sortableEnabled = false

//    val helloService by inject<Hello>()

@Composable
fun HomeScreen(
    navController: NavController
) {
    
    val viewModel = koinViewModel<HomeViewModel>()
    
    var showContent by remember { mutableStateOf(false) }
    
    Column(Modifier.fillMaxWidth(), horizontalAlignment = Alignment.CenterHorizontally) {
        
        Button(onClick = { showContent = !showContent }) {
            Text("Click me!")
        }
        
        Button(onClick = { navController.navigate(Route.About.path) }) {
            Text("Go to About screen")
        }
        
        Button(onClick = { viewModel.fetchStatus() }) {
            Text("Fetch Status")
        }
        
        AnimatedVisibility(showContent) {
            val greeting = remember { Greeting().greet() }
            Column(Modifier.fillMaxWidth(), horizontalAlignment = Alignment.CenterHorizontally) {
                Image(painterResource(Res.drawable.compose_multiplatform), null)
                Text("Compose: $greeting")
            }
        }
        
        /*AnimatedVisibility(viewModel.response.isNotBlank()) {
            Column(Modifier.fillMaxWidth(), horizontalAlignment = Alignment.CenterHorizontally) {
                Image(painterResource(Res.drawable.compose_multiplatform), null)
                Text("Response: ${viewModel.response}")
            }
        }*/
        
        /*if (sortableEnabled) SortableList()*/
        
    }
    
}
