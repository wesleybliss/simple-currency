package com.gammagamma.simplecurrency.domain.model

import kotlinx.serialization.Serializable

@Serializable
data class Status(val name: String, val version: String)
