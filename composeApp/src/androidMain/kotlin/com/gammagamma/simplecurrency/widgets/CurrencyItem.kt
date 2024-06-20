package com.gammagamma.simplecurrency.widgets

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier

@Composable
fun CurrencyItem(
    currency: String,
    onClick: () -> Unit
) {
    Row(
        verticalAlignment = Alignment.CenterVertically,
        modifier = Modifier.clickable(onClick = onClick)
    ) {
        Text(
            text = currency,
            modifier = Modifier
                .fillMaxWidth(),
        )
    }
}
