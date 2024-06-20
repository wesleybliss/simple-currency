package com.gammagamma.simplecurrency.widgets

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import com.gammagamma.simplecurrency.domain.model.Currencies

@Composable
fun CurrenciesList(
    currencies: Currencies,
    onCurrencyClick: (Int) -> Unit,
) {
    LazyColumn(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.Top
    ) {
        val items: List<String> = currencies.currencies.entries.map { "${it.key}: ${it.value}" }
        items(items) { currency ->
            CurrencyItem(
                currency = currency,
                onClick = { onCurrencyClick(/*currency.id*/1) }
            )
        }
    }
}
