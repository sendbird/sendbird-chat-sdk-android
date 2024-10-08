# Changelog

## v4.17.0 (Jul 18, 2024)
### Improvements
-  Replaced all ktx interfaces with either an `await` prefix or a `Flow` postfix and deprecated the existing interfaces.
    - This is to prevent issue with auto-import within the IDE where the interface cannot be imported automatically due to the previous interfaces having the same name as the original Chat SDK interfaces.
    ```kotlin
    /**
    * All `suspend fun` now has an `await` prefix.
    */
    // Previous
    suspend fun SendbirdChat.connect(userId: String, authToken: String? = null, apiHost: String? = null, wsHost: String? = null): AuthUser
    // New
    suspend fun SendbirdChat.awaitConnect(userId: String, authToken: String? = null, apiHost: String? = null, wsHost: String? = null): AuthUser

    /**
    * All methods returning a `Flow` now has a `Flow` postfix.
    */
    // Previous
    fun SendbirdChat.init(initParams: InitParams): Flow<InitResult>
    // New
    fun SendbirdChat.initFlow(initParams: InitParams): Flow<InitResult>
    ```

- Added interface for `SendbirdPushHelper` class
- Added `SendbirdChat.awaitAuthenticate()` as a replacement for `SendbirdChat.authenticateFeed()`
- Added `SendbirdChat.awaitGetTotalUnreadNotificationCount()`
## v4.16.1 (Apr 12, 2024)
### Improvements
- Added `suspend fun` for Chat SDK's `Query` classes
## v4.16.0 (Mar 27, 2024)
### Features
Added `MessageTemplate` feature for UIKit to render messages with templates.
  - Added suspend function `SendbirdChat.getMessageTemplate(String): MessageTemplate` and `SendbirdChat.getMessageTemplatesByToken(String?, MessageTemplateListParams): MessageTemplatesResult`
  - Added result handler function for message templates `SendbirdChat.getMessageTemplate(String, ResultHandler<MessageTemplate>?)` and `fun SendbirdChat.getMessageTemplatesByToken(String?, MessageTemplateListParams, ResultHandler<MessageTemplatesResult>?)`.
## v4.15.3 (Mar 07, 2024)
### Removed Features
- Removed extension function in `BaseMessage` related to threaded message released in `v4.15.2`
## v4.15.2 (Feb 28, 2024)
### Features
- Added new Kotlin Extension for SendbirdChat SDK
   ```kotlin
    class User {
        suspend fun createMetaData(metaDataMap: Map<String, String>): Map<String, String>
        suspend fun updateMetaData(metaDataMap: Map<String, String>): Map<String, String>
        suspend fun deleteMetaData(key: String)
        suspend fun deleteAllMetaData()
    }

    class Poll {
        companion object {
            suspend fun create(params: PollCreateParams): Poll
            suspend fun get(params: PollRetrievalParams): Poll
        }
    }

    class PollOption {
        companion object {
            suspend fun get(params: PollOptionRetrievalParams): PollOption
        }
    }
    ```
- Added extension function in `BaseMessage` related to threaded message
    ```kotlin
    class BaseMessage {
        suspend fun markThreadAsRead()
        suspend fun setPushNotificationEnabled(enabled: Boolean)
    }
    ```
## v4.15.1 (Feb 22, 2024)
### Improvements
- Improved stability
## v4.15.0 (Feb 07, 2024)
### Features
- Introducing new Kotlin Extension for SendbirdChat SDK
  - Supported for all public interfaces
