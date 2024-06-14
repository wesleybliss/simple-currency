package com.gammagamma.simplecurrency.ui.navigation

enum class Screens {
    HOME,
    ABOUT,
}

sealed class Route(val path: String) {
    data object Home : Route(Screens.HOME.name)
    data object About : Route(Screens.ABOUT.name)
}
