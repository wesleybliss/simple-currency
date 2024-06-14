package com.gammagamma.simplecurrency.ui.navigation

import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.gammagamma.simplecurrency.ui.screens.about.AboutScreen
import com.gammagamma.simplecurrency.ui.screens.home.HomeScreen

@Composable
fun AppNavHost(
    modifier: Modifier = Modifier,
    navController: NavHostController = rememberNavController(),
    startDestination: String = Route.Home.path, // or Splash
) {
    
    NavHost(
        modifier = modifier,
        navController = navController,
        startDestination = startDestination
    ) {
        
        /*composable(NavigationItem.Splash.route) {
            SplashScreen(navController)
        }*/
        
        composable(Route.Home.path) {
            HomeScreen(navController)
        }
        
        composable(Route.About.path) {
            AboutScreen()
        }
        
    }
    
}
