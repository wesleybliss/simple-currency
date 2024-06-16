package com.gammagamma.simplecurrency.domain.model

import kotlinx.serialization.Serializable

@Serializable
data class Currencies(val currencies: Map<String, String>)

/*
Example response:

{
    "AED": "United Arab Emirates Dirham",
    "AFN": "Afghan Afghani",
    "ALL": "Albanian Lek",
    "AMD": "Armenian Dram",
    "ANG": "Netherlands Antillean Guilder",
    "AOA": "Angolan Kwanza"
}
*/
