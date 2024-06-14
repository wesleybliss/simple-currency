package di

import Platform
import getPlatform
import org.koin.core.module.dsl.singleOf
import org.koin.dsl.module

val platformModule = module {
    single { getPlatform() }
}
