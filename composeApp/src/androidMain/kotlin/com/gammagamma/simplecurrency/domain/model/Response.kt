package com.gammagamma.simplecurrency.domain.model

import kotlinx.serialization.Serializable

@Serializable
data class Response<T>(val source: String, val timestamp: Long, val data: T)
