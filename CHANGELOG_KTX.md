# Changelog
## v4.33.0 (Feb 10, 2026)
### Features
- Added AI Agent conversation initialization coroutine extension
    - Added `GroupChannel.awaitInitConversation(params: InitConversationParams)` suspend function

## v4.32.0 (Nov 06, 2025)
### Features
- Added AI Agent Message Feedback coroutine extensions
    - Added `SendbirdChat.AIAgent.awaitCreateMessageFeedback()` suspend function
    - Added `SendbirdChat.AIAgent.awaitUpdateMessageFeedback()` suspend function
    - Added `SendbirdChat.AIAgent.awaitDeleteMessageFeedback()` suspend function
## v4.31.1 (Nov 03, 2025)
### Features
- Updated chat sdk to version 4.31.1
  - Fixed a possible binary compatibility issue when using Chat SDK in multiple products.
## v4.31.0 (Oct 29, 2025)
### Features
- Added support for closing conversation manually for AI Agent in `GroupChannel`
    - `GroupChannel.awaitCloseConversation()`

## v4.30.0 (Oct 22, 2025)
### Features

- Added `onConnectionDelayed` callback to `ConnectionHandler`.
  - A new callback method that is invoked when the server is overloaded. This callback provides information about the delay time before automatic reconnection. After the delayed time period, the SDK automatically initiates reconnection and triggers the callback sequence: `onReconnectStarted` → `onReconnectSucceeded`
    ```kotlin
    interface ConnectionHandler {
        fun onConnected(userId: String) {}
        fun onDisconnected(userId: String) {}
        fun onReconnectStarted() {}
        fun onReconnectSucceeded() {}
        fun onReconnectFailed() {}

        /**
        * A callback for when the connection is delayed.
        *
        * @param retryAfter The time in seconds to wait before the next reconnection attempt.
        */
        fun onConnectionDelayed(retryAfter: Long) {}
    }

    runCatching {
        SendbirdChat.awaitConnect(USER_ID, AUTH_TOKEN)
    }.onSuccess { user ->
        // Connection successful
    }.onFailure { e ->
        val sendbirdException = e as SendbirdException
        if (sendbirdException.code == SendbirdError.ERR_CONNECTION_DELAYED) {
            val data = sendbirdException.data
            // The delay time in seconds before automatic reconnection
            val retryAfter: Long = data["retry_after"] as? Long ?: 0
            // Server-provided reason code for the delay
            val message = data["message"] as? String ?: ""
            // Detailed error message explaining the delay
            val reasonCode: Int = data["reason_code"] as? Int ?: 0

            // The SDK will automatically retry after the specified delay time
            // and the result will be notified through ConnectionHandler.onReconnectSucceeded().
        }
    }
    ```
- Added `SendbirdChat.Options.setTypingIndicatorInvalidateTime(invalidateTimeMillis: Long)`
   - Sets typing indicator invalidation time. Defaults to 10000 (10 seconds)

### Improvements
- Added a condition in `AIAgentGroupChannelListQuery.belongsTo()` to exclude non–AI Agent and non–Desk channels from the query results.
## v4.29.0 (Sep 25, 2025)
### Features
- Added new properties to `Conversation`:
    - `handedOverAt: Long?` — The timestamp when the conversation was handed over to a human agent.
    - `aiAgentId: String?` — The ID of the AI agent associated with the conversation.
- Added new properties to `GroupChannel`:
    - `helpdesk: HelpdeskInfo` — The helpdesk information of this channel for accessing helpdesk-related data.

### Improvements
- Improved SQL safety in SDK local DB
## v4.28.0 (Jul 24, 2025)
### Features
- Added support for managing context objects for AI Agent in `GroupChannel`
    - `awaitGetContextObject(aiAgentId: String): String`
    - `awaitUpdateContextObject(aiAgentId: String, contextMap: Map<String, String>): String`
    - `awaitPatchContext(aiAgentId: String, contextMap: Map<String, String>): String`

- Added AI Agent group channel query APIs
    - `awaitGetMyGroupChannelChangeLogsByTimestamp(ts: Long, params: AIAgentGroupChannelChangeLogsParams)`
    - `awaitGetMyGroupChannelChangeLogsByToken(token: String, params: AIAgentGroupChannelChangeLogsParams)`
    - `awaitGetUnreadMessageCount(params: AIAgentGroupChannelUnreadMessageCountParams)`
## v4.27.1 (May 28, 2025)
### Improvements
- Updated chat sdk to version 4.27.1
## v4.27.0 (May 26, 2025)
### Improvements
- Updated chat sdk to version 4.27.0
## v4.26.0 (May 17, 2025)
### Features
- Added `awaitMarkAsUnread(message: BaseMessage)` to `GroupChannel`. This new feature changes the read status of messages in the channel to `unread`, starting from the specified message.
```kotlin
suspend fun GroupChannel.awaitMarkAsUnread(message: BaseMessage)
```
- Added AIAgent extension functions:
  - `SendbirdChat.AIAgent.awaitRequestMessengerSettings(params: MessengerSettingsParams): String`
    - Suspended function to request the chatbot’s settings using the provided parameters.
  - `SendbirdChat.AIAgent.awaitGetMessageTemplateList(params: AIAgentMessageTemplateListParams): AIAgentMessageTemplatesResult`
    - Suspended function to retrieve a list of message templates for the AI Agent.
  - `GroupChannel.awaitSubmitCSAT(params: CSATSubmitParams): Conversation`
    - Suspended function to submit a Customer Satisfaction (CSAT) score for conversations with the AI Agent chatbot.
  - `GroupChannel.awaitMarkConversationAsHandoff(): Conversation`
    - Suspended function to request handoff from the AI Agent to a human agent for the current conversation.
  - `ConversationListQuery.awaitNext()`
    - Suspended function to asynchronously fetch a list of conversations from a ConversationListQuery.

## v4.24.0 (Feb 28, 2025)
### Features
- Added `GroupChannel.messageDeletionTimestamp` representing the message deletion timestamp from the message archive.

### Improvements
- Added `AuthTokenType`
- Added authTokenType parameter to `authenticate()`, `awaitAuthenticate()` (Default Value: AuthTokenType.SESSION_TOKEN)

```kotlin
// using AccessToken
SendbirdChat.authenticate(userId: USER_ID, authToken: ACCESS_TOKEN, authTokenType: AuthTokenType.ACCESS_TOKEN)
SendbirdChat.awaitAuthenticate(userId: USER_ID, authToken: ACCESS_TOKEN, authTokenType: AuthTokenType.ACCESS_TOKEN)

// using SessionToken
SendbirdChat.authenticate(userId: USER_ID, authToken: SESSION_TOKEN)
SendbirdChat.authenticate(userId: USER_ID, authToken: SESSION_TOKEN, authTokenType: AuthTokenType.SESSION_TOKEN)
SendbirdChat.awaitAuthenticate(userId: USER_ID, authToken: SESSION_TOKEN)
SendbirdChat.awaitAuthenticate(userId: USER_ID, authToken: SESSION_TOKEN, authTokenType: AuthTokenType.SESSION_TOKEN)
```
## v4.23.0 (Jan 8, 2025)
### Improvements
- Performed internal modularization to enhance flexibility and stability.
## v4.22.0 (Nov 21, 2024)
- Supports for `Poll` feature is added for all message types.
    - Added `poll` and `applyPoll(poll: Poll)` method in `BaseMessage`.
    - Added `pollId` in `FileMessageCreateParams` and `MultipleFilesMessageCreateParams`.

- Added `sampledReactedUserInfoList` in `Reaction` to support getting reaction-related data
- Added `ReactedUserInfo`
- Deprecated `sampledUserIds` in `Reaction`

``` kotlin
class Reaction {
    val sampledReactedUserInfoList: List<ReactedUserInfo>
}
```

### Improvements

- Improved sender profile update in super group channel.
- Fixed a bug where connecting fails with a user ID containing special characters.
## v4.21.0 (Nov 21, 2024)
SDK now supports `Custom Report Categories` configured through Sendbird Dashboard, which takes effect after restarting the app. Previous report categories will remain until app restart.
- Added `SendbirdChat.awaitGetReportCategoryInfoList()`
- Added `awaitReport(ReportCategoryInfo, String?)`
- Added `awaitReportUser(User, ReportCategoryInfo, String?)`
- Added `awaitReportMessage(BaseMessage, ReportCategoryInfo, String?)`
- Deprecated `awaitReport(ReportCategory, String?)`
- Deprecated `awaitReportUser(User, ReportCategory, String?)`
- Deprecated `awaitReportMessage(BaseMessage, ReportCategory, String?)`
## v4.20.0 (Nov 7, 2024)
- Added new properties in `Reaction` to support more users
``` kotlin
class Reaction {
    // A list of sampled userIds that have reacted to this Reaction.
    val sampledUserIds: List<String>

    // A count of the number of users who have reacted to this.
    var count: Long

    // A flag indicating whether the current user has reacted to this.
    var hasCurrentUserReacted: Boolean
}
```
## v4.19.0 (Sep 11, 2024)
- Added interfaces for `MessageForm` to work with Sendbird dashboard and `Form` interfaces have been deprecated
    - Added `awaitSubmitMessageForm()` method in `BaseMessage` class
    - Deprecated `awaitSubmitForm(Form)` method in `BaseMessage` class
- Added `SendbirdChat.getUnreadItemCount(GroupChannelUnreadItemCountParams, ResultHandler<Map<UnreadItemKey, Int>>?)` and `SendbirdChat.awaitGetUnreadItemCount(GroupChannelUnreadItemCountParams)` method to support filtering unread message count by custom types
## v4.18.0 (Aug 7, 2024)
### Features
Support `pinned message` in `OpenChannel`
- Expanded `awaitPinMessage()`, `awaitUnpinMessage()` to `BaseChannel` to support `OpenChannel`
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
