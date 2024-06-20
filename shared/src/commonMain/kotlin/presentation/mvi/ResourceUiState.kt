package presentation.mvi

sealed class ResourceUiState<out T> {
    data object Idle : ResourceUiState<Nothing>()
    data object Empty : ResourceUiState<Nothing>()
    data object Loading : ResourceUiState<Nothing>()
    data class Error(val error: Throwable) : ResourceUiState<Nothing>()
    data class Success<T>(val data: T) : ResourceUiState<T>()
}
