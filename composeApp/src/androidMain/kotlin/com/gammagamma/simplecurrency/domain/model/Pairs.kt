package com.gammagamma.simplecurrency.domain.model

import kotlinx.serialization.Serializable

@Serializable
data class Pairs(val rates: Map<String, Float>)
