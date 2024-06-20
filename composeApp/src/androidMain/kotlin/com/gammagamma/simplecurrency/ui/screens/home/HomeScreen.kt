package com.gammagamma.simplecurrency.ui.screens.home

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.Scaffold
import androidx.compose.material.Text
import androidx.compose.material.TopAppBar
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.gammagamma.simplecurrency.domain.ui.features.currencies.ACurrenciesRepository
import com.gammagamma.simplecurrency.domain.ui.features.currencies.CurrenciesContract
import com.gammagamma.simplecurrency.services.Log
import com.gammagamma.simplecurrency.ui.common.ActionBarIcon
import com.gammagamma.simplecurrency.ui.common.state.ManagementResourceUiState
import com.gammagamma.simplecurrency.widgets.CurrenciesList
import kotlinx.coroutines.flow.collectLatest
import org.jetbrains.compose.resources.painterResource
import org.koin.androidx.compose.koinViewModel
import simplecurrency.composeapp.generated.resources.Res
import simplecurrency.composeapp.generated.resources.compose_multiplatform
import org.koin.compose.koinInject
import presentation.mvi.ResourceUiState

//const val sortableEnabled = false

//    val helloService by inject<Hello>()

@Composable
fun HomeScreen(
    navController: NavController
) {
    
    val viewModel = koinViewModel<HomeViewModel>()
    val currenciesRepository = koinInject<ACurrenciesRepository>()
    var showContent by remember { mutableStateOf(false) }
    
    val state by viewModel.uiState.collectAsState()
    
    LaunchedEffect(key1 = Unit) {
        viewModel.effect.collectLatest { effect ->
            when (effect) {
                is CurrenciesContract.Effect.NavigateToDetailCharacter ->
                    //navigator.push(CurrencieDetailScreen(effect.idCurrencie))
                    Log.d("HomeScreen @todo debug NavigateToDetailCharacter")
                
                CurrenciesContract.Effect.NavigateToFavorites ->
                    //navigator.push(CurrenciesFavoritesScreen())
                    Log.d("HomeScreen @todo debug NavigateToFavorites")
            }
        }
    }
    
    Scaffold(
        topBar = { ActionAppBar { viewModel.setEvent(CurrenciesContract.Event.OnFavoritesClick) } }
    ) { padding ->
        
        Column(Modifier.fillMaxWidth(), horizontalAlignment = Alignment.CenterHorizontally) {
            
            Button(onClick = { viewModel.fetchStatus() }) { Text("Fetch Status") }
            Button(onClick = { viewModel.fetchCurrencies() }) { Text("Fetch Currencies") }
            Button(onClick = { viewModel.fetchPairs() }) { Text("Fetch Pairs") }
            
            AnimatedVisibility(viewModel.loading) {
                Column(
                    Modifier.fillMaxWidth(),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text("Loading...")
                }
            }
            
            AnimatedVisibility(viewModel.response.isNotBlank()) {
                Column(
                    Modifier.fillMaxWidth(),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Image(painterResource(Res.drawable.compose_multiplatform), null)
                    /*Text("Response: ${viewModel.response}")*/
                    
                }
            }
            
            ManagementResourceUiState(
                modifier = Modifier
                    .padding(padding)
                    .fillMaxSize(),
                resourceUiState = state.currencies,
                errorView = { Text("Error: ${it.message}") },
                loadingView = { Text("Loading...") },
                successView = { currencies ->
                    CurrenciesList(
                        currencies = currencies,
                        onCurrencyClick = { idCharacter: Int ->
                            viewModel.setEvent(
                                CurrenciesContract.Event.OnCurrencyClick(
                                    idCharacter
                                )
                            )
                        }
                    )
                },
                onTryAgain = { viewModel.setEvent(CurrenciesContract.Event.OnTryCheckAgainClick) },
                onCheckAgain = { viewModel.setEvent(CurrenciesContract.Event.OnTryCheckAgainClick) },
            )
            
            /*if (sortableEnabled) SortableList()*/
            
        }
        
    }
    
}

@Composable
fun ActionAppBar(
    onClickFavorite: () -> Unit,
) {
    TopAppBar(
        title = { Text(text = "Simple Currency") },
        actions = {
            ActionBarIcon(
                onClick = onClickFavorite,
                icon = Icons.Filled.Favorite
            )
        }
    )
}
