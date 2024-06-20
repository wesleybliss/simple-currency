package com.gammagamma.simplecurrency.services

import android.content.Context
import com.gammagamma.simplecurrency.domain.model.Currencies
import io.github.xxfast.kstore.KStore
import io.github.xxfast.kstore.file.storeOf
import okio.Path.Companion.toPath
import java.nio.file.Paths

class Store(context: Context) {
    
    // for documents directory
    // val root = context.filesDir.path
    
    // for caches directory
    private val root = context.cacheDir.path
    
    private fun cachePath(path: String) : String = Paths.get(root)
        .resolve(path).toAbsolutePath().toString()
    
    val currencies: KStore<Currencies> = storeOf(file = cachePath("currencies.json").toPath())
    val pairs: KStore<Currencies> = storeOf(file = cachePath("pairs.json").toPath())
    
}
