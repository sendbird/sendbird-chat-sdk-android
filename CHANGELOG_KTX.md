# Changelog

## v4.15.1 (Feb 22, 2024)
### Features
- Added extension function in `BaseMessage` related to threaded message
```kotlin
class BaseMessage {
    fun setPushNotificationEnabled(enabled: Boolean, handler: ResultHandler<Boolean>?)

    suspend fun markThreadAsRead()
    suspend fun setPushNotificationEnabled(enabled: Boolean): Boolean
}
```
## v4.15.0 (Feb 07, 2024)
### Features
- Introducing new Kotlin Extension for SendbirdChat SDK
  - Supported for all public interfaces
