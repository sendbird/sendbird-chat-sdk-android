# Changelog

## v4.25.0 (May 09, 2025)
### Improvements
- The Chat SDK no longer includes `Conscrypt` by default. If your app targets Android 9 (Pie, API level 28) or lower and you want to enable TLS 1.3, you need to manually add the `Conscrypt` dependency as shown below. Android 10 and above natively support TLS 1.3, so this step is only necessary for older OS versions. Even if you don’t add the `Conscrypt` dependency, the SDK will still work using TLS 1.2 without any functional issues. Once the dependency is added, the SDK will automatically detect and use `Conscrypt`—no additional code is needed.
```kotlin
dependencies {
    implementation("org.conscrypt:conscrypt-android:2.5.2")
}
```

## v4.24.2 (Apr 24, 2025)
### Improvements
- Fixed a bug where calling `GroupChannel.markAsRead()` too frequently within a short latency period caused ackTimeout error.
## v4.24.1 (Mar 27, 2025)
### Improvements
Fixed a bug that parts of the local cache data were reset after calling `connect()` or `authenticate()`. This fix improves local cache performance and messages loading.
## v4.24.0 (Feb 28, 2025)
### Features

- Added `GroupChannel.messageDeletionTimestamp` representing the message deletion timestamp from the message archive.

### Improvements

- Fixed a duplicated module namespace warning.
- Added `AuthTokenType`
- Added authTokenType parameter to `authenticate()` (Default Value: AuthTokenType.SESSION_TOKEN)

```kotlin
// using AccessToken
SendbirdChat.authenticate(userId: USER_ID, authToken: ACCESS_TOKEN, authTokenType: AuthTokenType.ACCESS_TOKEN)

// using SessionToken
SendbirdChat.authenticate(userId: USER_ID, authToken: SESSION_TOKEN)
SendbirdChat.authenticate(userId: USER_ID, authToken: SESSION_TOKEN, authTokenType: AuthTokenType.SESSION_TOKEN)
```
## v4.23.1 (Jan 17, 2025)
### Improvements

- Fixed a bug where loading more group channels in a `GroupChannelCollection` with `includeEmpty` set to `true` did not work as expected.
## v4.23.0 (Dec 24, 2024)
### Improvements

- Performed internal modularization to enhance flexibility and stability.
## v4.22.0 (Dec 20, 2024)
### Features

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
## v4.21.1 (Nov 21, 2024)
### Features
SDK now supports `Custom Report Categories` configured through Sendbird Dashboard, which takes effect after restarting the app. Previous report categories will remain until app restart.

- Added `getReportCategoryInfoList()`
- Added `ReportCategoryInfo`
- Added `report(ReportCategoryInfo, String?, CompletionHandler?)` method in `BaseChannel`
- Added `reportUser(User, ReportCategoryInfo, String?, CompletionHandler?)` method in `BaseChannel`
- Added `reportMessage(BaseMessage, ReportCategoryInfo, String?, CompletionHandler?)` method in `BaseChannel`
- Deprecated `ReportCategory`
- Deprecated `report(ReportCategory, String?, CompletionHandler?)` method in `BaseChannel`
- Deprecated `reportUser(User, ReportCategory, String?, CompletionHandler?)` method in `BaseChannel`
- Deprecated `reportMessage(BaseMessage, ReportCategory, String?, CompletionHandler?)` method in `BaseChannel`

### Improvements
- Removed the `shadow plugin` and switched to referencing dependencies directly.
    - The `shadow plugin` was previously used to relocate package names of dependencies to avoid conflicts and resolve dependency management issues.
    - The affected libraries are `gson` and `okhttp`.
    - This change was made because `okhttp` and `gson` are widely used in Android apps. Shadowing these libraries duplicates their code in the final app, increasing app size. By removing shadowing, we aim to help developers optimize performance and reduce storage requirements.

## <strike>v4.21.0 (Nov 21, 2024)</strike> *DEPRECATED*
### Features
SDK now supports `Custom Report Categories` configured through Sendbird Dashboard, which takes effect after restarting the app. Previous report categories will remain until app restart.

- Added `getReportCategoryInfoList()`
- Added `ReportCategoryInfo`
- Added `report(ReportCategoryInfo, String?, CompletionHandler?)` method in `BaseChannel`
- Added `reportUser(User, ReportCategoryInfo, String?, CompletionHandler?)` method in `BaseChannel`
- Added `reportMessage(BaseMessage, ReportCategoryInfo, String?, CompletionHandler?)` method in `BaseChannel`
- Deprecated `ReportCategory`
- Deprecated `report(ReportCategory, String?, CompletionHandler?)` method in `BaseChannel`
- Deprecated `reportUser(User, ReportCategory, String?, CompletionHandler?)` method in `BaseChannel`
- Deprecated `reportMessage(BaseMessage, ReportCategory, String?, CompletionHandler?)` method in `BaseChannel`

### Improvements
- Removed the `shadow plugin` and switched to referencing dependencies directly.
    - The `shadow plugin` was previously used to relocate package names of dependencies to avoid conflicts and resolve dependency management issues.
    - The affected libraries are `gson` and `okhttp`.
    - This change was made because `okhttp` and `gson` are widely used in Android apps. Shadowing these libraries duplicates their code in the final app, increasing app size. By removing shadowing, we aim to help developers optimize performance and reduce storage requirements.
## v4.20.1 (Nov 19, 2024)
### Improvements
- Fixed a bug where `Reaction.count` resets to 0 when `Reaction.sampledUserIds` is empty
## v4.20.0 (Nov 07, 2024)
### Features
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
## v4.19.4 (Oct 24, 2024)
### Improvements
- Improved speed of `GroupChannelCollection.loadMore()` when the `GroupChannelListQuery` is set with filters.
## v4.19.3 (Oct 11, 2024)
### Improvements
- Fixed a crash issue due to lack of proguard rule for `PublicSuffixDatabase` in the okhttp library.
## v4.19.2 (Sep 26, 2024)
### Improvements
- Fixed a bug where non-operator's message affects the last message and the unread message count for exclusive channels
- Fixed a bug where a channel gets unexpectedly unhidden upon receiving a new message.
- Added `useDnsFallback` to `InitParams` which enables a fallback where a second DNS lookup is attempted using a public DNS when the initial lookup using the system DNS fails. Its default value is `false`.
## v4.19.1 (Sep 12, 2024)
### Improvements
- Improved speed of `MessageCollection.initialize()` when there are lots of reply messages in the channel.
## v4.19.0 (Sep 11, 2024)
### Features
- Added interfaces for `MessageForm` to work with Sendbird dashboard and `Form` interfaces have been deprecated.
    - Added `submitMessageForm(CompletionHandler?)` method in `BaseMessage` class
    - Added `messageForm` property in `BaseMessage` class
    - Added `MessageForm` class
    - Added `MessageFormItem` class
    - Added `MessageFormItem.Style` class
    - Added `MessageFormItem.LayoutType` enum
    - Added `MessageFormItem.ResultCount` enum
    - Deprecated `submitForm(Form, CompletionHandler)` method in `BaseMessage` class
    - Deprecated `forms` property in `BaseMessage` class
    - Deprecated `Form` class and interfaces
    - Deprecated `FormField` class and interfaces
    - Deprecated `FormFieldAnswer` class and interfaces
- Added `TemplateContainerOptions` in `TemplateMessageData`
- Added `SendbirdChat.getUnreadItemCount(GroupChannelUnreadItemCountParams, GroupChannelGetUnreadItemCountHandler?)` method to support filtering unread message count by custom types
    - Added `GroupChannelUnreadItemCountParams` class
    - Deprecated existing `SendbirdChat.getUnreadItemCount(Collection<UnreadItemKey>, GroupChannelGetUnreadItemCountHandler)` method

### Improvements
- Fixed an occasional `ConcurrentModificationException` crash from `BaseMessageCollection.getPendingMessages`.
## v4.18.0 (Aug 07, 2024)
### Features
Support `pinned message` in `OpenChannel`
- Added `pinnedMessageIds` property to `BaseChannel`
- Added `lastPinnedMessage` property to `BaseChannel`
- Added `pinMessage` method to `BaseChannel`
- Added `unpinMessage` method to `BaseChannel`
- Added `onPinnedMessageUpdated` to `OpenChannelHandler`
- Expanded `SendbirdChat.createPinnedMessageListQuery` to use in `OpenChannel`
## v4.17.0 (Jul 18, 2024)
### Features
- Added `SendbirdChat.authenticate()` for authentication
    - Deprecated `SendbirdChat.authenticateFeed()`
- Added `SendbirdChat.getTotalUnreadNotificationCount()` to get the total unread notification count of a user

### Improvements
- Added `SendbirdPushHelper.registerHandler()`
    - Deprecated `SendbirdPushHelper.registerPushHandler()`
- Added `SendbirdPushHelper.unregisterHandler(Boolean, PushRequestCompleteHandler?)`
    - Deprecated `SendbirdPushHelper.unregisterPushHandler(PushRequestCompleteHandler?)`
    - Deprecated `SendbirdPushHelper.unregisterPushHandler(Boolean, PushRequestCompleteHandler?)`
- Added `collectionLifecycle` in `GroupChannelCollection`, `MessageCollection` and `NotificationCollection`
## v4.16.4 (Jun 05, 2024)
### Improvements
- Added new properties `hasAiBot` and `hasBot` to `GroupChannel`
## v4.16.3 (May 14, 2024)
### Improvements
- Fixed an occasional `ConcurrentModificationException` crash from `reconnect()`
## v4.16.2 (Apr 25, 2024)
### Improvements
- Improved `SendbirdChat.init()` to prevent possible ANR during the init process
## v4.16.1 (Apr 12, 2024)
### Improvements
- Improved stability.
## v4.16.0 (Mar 27, 2024)
### Features
You can mark push notifications as clicked within the SDK, tracking the push notification clicked rate.
- Added `markPushNotificationAsClicked(Map<String, String>, CompletionHandler)` in `SendbirdPushHelper`
  ```kotlin
  SendbirdPushHelper.markPushNotificationAsClicked(pushData)
  ```

- Added `logViewed(List<BaseMessage>)`, `logClicked(BaseMessage)` in `FeedChannel`
- Deprecated `logImpression(List<BaseMessage>)` in `FeedChannel`


Added `MessageTemplate` feature for UIKit to render messages with templates.
  - Added `messageTemplateInfo` property to `AppInfo`.
  - Added `SendbirdChat.getMessageTemplate(String, MessageTemplateHandler?)`.
  - Added `SendbirdChat.getMessageTemplatesByToken(String, MessageTemplateParams(), MessageTemplatesResultHandler?)`.
  - Added `MessageTemplateHandler` and `MessageTemplatesResultHandler`.
  - Added models for message templates, `MessageTemplate`, `MessageTemplateInfo`, `MessageTemplatesResult` and `MessageTemplateListParams`.
## v4.15.7 (Mar 22, 2024)
### Improvements
- Added `EventDetail` in `GroupChannelContext`/`FeedChannelContext` to hold detailed information of channel events
    - i.e. Getting an inviter/invitees information when a channel has been added from receiving an invitation:
         ```kotlin
         override fun onChannelsAdded(context: GroupChannelContext, channels: List<GroupChannel>) {
             if (context.eventDetail is EventDetail.OnUserReceivedInvitation) {
                 val inviter: User? = context.eventDetail.inviter
                 val invitees: List<User> = context.eventDetail.invitees
             }
         }
         ```
## v4.15.6 (Mar 11, 2024)
### Improvements
- Fixed `DateTimeException` occurring from `SendbirdChat.init()` in some devices
## v4.15.5 (Mar 07, 2024)
### Removed Features
- Removed `ThreadedParentMessageListQuery` and related interfaces released in `v4.15.4`
## v4.15.4 (Feb 28, 2024)
### Features
- Added `ThreadedParentMessageListQuery`
```kotlin
class GroupChannel {
	val totalUnreadReplyCount: Int

	fun createThreadedParentMessageListQuery(
		params: ThreadedParentMessageListQueryParams
	): ThreadedParentMessageListQuery
}

class BaseMessage {
	fun markThreadAsRead(handler: CompletionHandler?)
	fun setPushNotificationEnabled(enabled: Boolean, handler: CompletionHandler?)
}

class ThreadInfo {
	val unreadReplyCount: Int
	val memberCount: Int
	val isPushNotificationEnabled: Boolean
}
```
## v4.15.3 (Feb 22, 2024)
### Improvements
- Improved stability
## v4.15.2 (Feb 14, 2024)
### Improvements
- Reduced SDK Size by optimizing kotlin function usage
- Added new property `notificationPriority` in BaseMessage
- Fixed a bug where `MessageMetaArray` related operation doesn't work with `MultipleFilesMessage`
## v4.15.1 (Feb 14, 2024)
- The SDK version 4.15.1 has been deprecated because it has been released by mistake. DO NOT USE THIS VERSION.
## v4.15.0 (Feb 07, 2024)
### Features
- Supports new SendbirdChat KTX
## v4.14.2 (Jan 31, 2024)
### Improvements
- Fixed a bug where `NotificationCollectionHandler.onMessagesUpdated()` is called indefinitely in some cases
## v4.14.1 (Jan 17, 2024)
### Improvements
- Fix intermittent `ConcurrentModificationException` in `MessageCollection`
## v4.14.0 (Dec 20, 2023)
### Features
- Three new features related to Generative AI have been added: Form type, Suggested replies and Feedback.
  - Form type: A form type message is a message that contains a form. A form is a set of questions that a user can answer to collect data from users.
    1. How to determine if a message is a form type message:
        ```kotlin
        val BaseMessage.isFormTypeMessage: Boolean
            get() = this.forms.isNotEmpty()
        ```
    2. How to save the answer in the SDK when the user enters input:
        ```kotlin
        editText.addTextChangedListener(
            object : TextWatcher {
                ...
                override fun onTextChanged(s: CharSequence, start: Int, before: Int, count: Int) {
                    formField.temporaryAnswer = Answer(formField.key, s.toString())
                }
            }
        )
       ```
    3. Submits a form
        ```kotlin
        // submits form
        message.submitForm(form) { e ->
            if (e != null) {
                // handle error
            }
        }

        // The submitted form is updated through a message update event.
        SendbirdChat.addChannelHandler(
            "IDENTIFIER",
            object : GroupChannelHandler() {
            ...
                override fun onMessageUpdated(channel: BaseChannel, message: BaseMessage) {
                    message.forms.find { it.formKey == "TARGET_FORM_KEY" }?.isSubmitted // should be true
                    // update message UI to submitted form
                }
            }
        )
       ```
  - Suggested replies: Suggested reply is a set of items that a user can click quickly to send a message. Suggested replies is contained in a last message.
    ```kotlin
    SendbirdChat.addChannelHandler(
        "IDENTIFIER",
        object : GroupChannelHandler() {
            ...
            override fun onChannelChanged(channel: BaseChannel) {
                if (channel is GroupChannel) {
                    val suggestedReplies = channel.lastMessage?.suggestedReplies
                    if (!suggestedReplies.isNullOrEmpty()) {
                        // draw suggested replies for the channel's last message
                    }
                }
            }
        }
    )
    ```
  - Feedback: Feedback is a feature that allows users to provide their satisfaction or dissatisfaction with the bot's responses.
    1. How to draw feedback UI
        ```kotlin
        val feedback = message.myFeedback
        when (message.myFeedbackStatus) {
            FeedbackStatus.NOT_APPLICABLE -> {
                // this message is not applicable for feedback
                // Make thumbs-up/down UI invisible or disable here
                // `feedback` should be null
            }

            FeedbackStatus.NO_FEEDBACK -> {
                // The feedback is not submitted yet but user can submit feedback
                // Make thumbs-up/down UI visible or enable without being selected
                // `feedback` should be null
            }
            FeedbackStatus.SUBMITTED -> {
                // The feedback is submitted
                // Make thumbs-up/down UI visible or enable as selected
                // `feedback` should not be null
            }
        }
        ```
    2. How to submit / update / delete feedback
        ```kotlin
        // submit feedback
        message.submitFeedback(FeedbackRating.Good) { feedback, e ->
            when {
                feedback != null -> {
                    // update feedback UI
                }
                e != null -> {
                    // handle error
                }
            }
        }

        // update feedback
        message.updateFeedback(FeedbackRating.Good, "Very good response") { feedback, e ->
            when {
                feedback != null -> {
                    // update feedback UI
                }
                e != null -> {
                    // handle error
                }
            }
        }

        // delete feedback
        message.deleteFeedback { e ->
            // handle error
        }
        ```
- Introduced `BaseMessage.extras` to enable developers to include their own data in `BaseMessage` and carry it seamlessly.
- Added `logCustom(String, List<BaseMessage>)` in `FeedChannel`.
### Improvements
- Fix the bug where the internal network status flag is incorrect when an app starts from offline mode.
## v4.13.0 (Oct 25, 2023)
### Features
- Added new read-only attribute `messageReviewInfo` in `UserMessage`

    ```kotlin
    class UserMessage {
        // exist only if the message is in review or it has been approved
        val messageReviewInfo: MessageReviewInfo?
    }

    class MessageReviewInfo {
        val status: MessageReviewStatus
        val originalMessageInfo: OriginalMessageInfo? // (exist only if the status is approved)
    }

    enum class MessageReviewStatus {
        IN_REVIEW, APPROVED
    }

    class OriginalMessageInfo {
        val createdAt: Long
        val messageId: Long
    }
    ```
- Added new read-only attribute `notificationMessageStatus` in `BaseMessage`
- Added `markAsRead(List<BaseMessage>, CompletionHandler?)` in `FeedChannel`
- Added `logImpression(List<BaseMessage>)` in `FeedChannel`
    ```kotlin
    class BaseMessage {
        // This value represents the status value for the Notification message. The value `NONE` is returned for messages that are not Notification messages.
        val notificationMessageStatus: NotificationMessageStatus
    }

    enum class NotificationMessageStatus(val value: String) {
        NONE, SENT, READ
    }

### Improvements
- Mitigated an ANR issue by lazy creation of properties within `SendbirdChat.init()`
## v4.12.3 (Oct 06, 2023)
### Improvements
- Reduced delay in `GroupChannelCollection.loadMore()` when there's lots of channels
## v4.12.2 (Sep 25, 2023)
### Features
- Added `GroupChannel.getDeliveryStatus(Boolean): Map<String, DeliveryStatus>` to get delivery status of all members.
- Added `BaseMessage.submitForm(String, Map<String, String>, CompletionHandler?)`, which allows you to submit form messages sent by the bot. Please note that form messages are delivered via BaseMessage.extendedMessages when all settings are properly configured on the server.

### Improvements
- Fixed occasional `NoSuchElementException` when accessing `GroupChannel.members`.

## v4.12.1 (Sep 13, 2023)
### Improvements

- Improved stability.
## v4.12.0 (Sep 04, 2023)
### Features

You can get the categories of a set FeedChannel and the channel's properties from the Dashboard.
- Added `isCategoryFilterEnabled`, `isTemplateLabelEnabled`, and `notificationCategories` in FeedChannel
```kotlin
var isCategoryFilterEnabled: Boolean
var isTemplateLabelEnabled: Boolean
var notificationCategories: List<NotificationCategory>
```

You can obtain the data that you set when you send Notification to the template that you created in the dashboard.
- Added `notificationData` in `BaseMessage`
```kotlin
val notificationData: NotificationData?
```
## v4.11.1 (Aug 29, 2023)
### **Improvements**

- Added `enableAutoResend` in `InitParams.LocalCacheConfig` to control auto-resending feature when local cache is enabled
- Added `isBot` in `Sender`
- Added `file`, `url` getters in `UploadableFileInfo`
- Mitigated an ANR issue and a failure of initialization by reducing access to SharedPreferences in the main thread
## v4.11.0 (Aug 16, 2023)

### Features

- Added 'SendbirdChat.authenticateFeed' for Sendbird Notifications
- Added 'SendbirdChat.refreshNotificationCollections' for Sendbird Notifications

### Improvements

- Added `createdBefore` and `createdAfter` in listing `GroupChannels`.
```kotlin
class GroupChannelListQueryParams {
    var createdBefore: Long? = null
    var createdAfter: Long? = null
}
class GroupChannelListQuery {
    val createdBefore: Long? = params.createdBefore
    val createdAfter: Long? = params.createdAfter
}
class PublicGroupChannelListQueryParams {
    var createdBefore: Long? = null
    var createdAfter: Long? = null
}
class PublicGroupChannelListQuery {
    val createdBefore: Long? = params.createdBefore
    val createdAfter: Long? = params.createdAfter
}
```

## v4.10.0 (Aug 2, 2023)

### **Features**
You can mark push notifications as delivered within the SDK, tracking delivery status.
- Added `SendbirdPushHelper.markPushNotificationAsDelivered`.

```kotlin
SendbirdPushHelper.markPushNotificationAsDelivered(pushData)
```

### Improvements
- Added `GroupChannel.resendMessage(MultipleFilesMessage, FileUploadHandler?, MultipleFilesMessageHandler?): MultipleFilesMessage?` , `GroupChannel.copyMultipleFilesMessage(BaseChannel, MultipleFilesMessage, MultipleFilesMessageHandler?): MultipleFilesMessage?`.
- Fixed a bug where the group channel changelogs did not update the group channel metadata.

## v4.9.5 (Jul 21, 2023)

### Improvements
- Fixed a bug where the changes of the *chat history setting were not reflected properly when the local cache is turned on.  

*(Chat history setting can be found in Dashboard page - Settings - Channels - Chat history)

## v4.9.4 (Jul 12, 2023)

### Improvements

- Fixed a bug that was occurring when ProGuard was enabled. The issue prevented the function MessageCollection.onMessageAdded from being called for pending messages in FileMessage or MultipleFileMessage.

## v4.9.3 (Jul 12, 2023)

### Improvements

- Fixed a bug that MessageCollection.onMessageAdded is not called for a pending message of FileMessage or MultipleFileMessage

## v4.9.2 (Jul 05, 2023)

### Improvements

- Fixed the bug where the notification-related stats disappear when the app is restarted.
## v4.9.1 (Jun 26, 2023)

### Improvements

- Fixed a security flaw related to the connection
- Fixed a crash that occurred when sqlcipher was used alongside proguard.
- Fixed a randomly occurring ConcurrentModificationException.
- Introduced new error codes to streamline error handling:
    - SendbirdError.ERR_INITIALIZATION_CANCELED: Triggered when SDK initialization exceeds 5 seconds to prevent App Not Responding (ANR) incidents.
    - SendbirdError.ERR_DATABASE_ERROR_ENCRYPTION: Related to issues with sqlcipher, such as an undeclared sqlcipher dependency or an incorrect encryption key.

## v4.9.0 (May 31, 2023)

### **Features**
### MultipleFilesMessage
You can send a `MultipleFilesMessage` that contains multiple files in a single message via `GroupChannel.sendMultileFilesMessage()` 
- Added `MultipleFilesMessage`.
- Added `GroupChannel.sendMultipleFilesMessage`, `MultipleFilesMessageCreateParams`, `UploadableFileInfo` and `UploadedFileInfo`.
- Added `MultipleFilesMessageHandler` and `FileUploadhandler`. 
- Added `SendbirdChat.multipleFilesMessageFileCountLimit` that indicates the maximum count of files that can be included in a single message.

```kotlin
val params = MultipleFilesMessageCreateParams(
    listOf(
        UploadableFileInfo(file),
        UploadableFileInfo(fileUrl)
    )
)

channel.sendMultipleFilesMessage(
    params,
    fileUploadHandler = { requestId, index, uploadableFileInfo, e ->
        // handle the upload result of each UploadableFileInfo. 
    },
    multipleFilesMessageHandler = { message, e ->
        // handle the result of sending MultipleFilesMessage.
    }
)
```

## v4.8.3 (May 25, 2023)

### Improvements
- Fixed SendbirdChat.Connect callback not being called when Sendbird.connect and GroupChannel.GetChannel are called simultaneously
- Improved speed of initialization to reduce initialization timeout

## v4.8.2 (May 17, 2023)

### Improvements
- Improved stability

## v4.8.1 (May 12, 2023)

### Improvements
- Fixed a crash from SendbirdChat.init caused by android.net.ConnectivityManager$TooManyRequestsException
- Fixed an issue that ConnectHandler.onConnected is not called sometimes when the app is in offline
- Supports 'includeParentInfo' for the PinnedMessageListQuery

## v4.8.0 (Apr 28, 2023)

### **Features**
### PinnedMessageListQuery
You can now retrieve all pinned messages within a GroupChannel by the `PinnedMessageListQuery`.

- Added `PinnedMessage`
- Added `PinnedMessageListQuery`, `PinnedMessageListQueryParams`
- Added `SendbirdChat.createPinnedMessageListQuery`

```
val params = PinnedMessageListQueryParams(channel.channelType, channel.url)
val query = SendbirdChat.createPinnedMessageListQuery(params)
query.next { pinnedMessages, e ->
    // handle result
}
```

### Improvements
- Fixed possible ANR in `GroupChannelCollection.dispose()`

### Deprecation
pendingPushToken is deprecated. Retrieve most recent token through the push library instead.
- `SendbirdChat.pendingPushToken`
- `SendbirdChat.HMS.pendingPushToken`

## v4.7.0 (Apr 14, 2023)

### **Features**
### (Moderation) Automatically detect when user is unmuted
You can now automatically detect when a muted user is unmuted by leveraging `MessageCollection`.
Clients will now receive `MessageCollectionHandler.onChannelUpdated()` with `GroupChannelContext.CollectionEventSource.EVENT_USER_UNMUTED` when an user is unmuted after their muted duration has expired, on top of explict unmute calls. This now means that you can easily transition user’s experience and allow them to chat even more seamlessly.
Note that this is a MessageCollections only feature! We recommend all of our clients to give it a try if you haven’t : ) 

## v4.6.1 (Mar 31, 2023)

### **Improvements**

- Added OpenChannelCreateParams.isEphemeral
- Fixed an issue where network wouldn't properly reconnect when `connect()` is called again with a different user id
- Fixed potential ANR from `SendbirdChat.init()`

## v4.6.0 (Mar 14, 2023)

### **Features**

### **Set your own Local Caching DB size**

You can now control the size of your local cache. Starting from 64mb, decide how much you want to store (Default: 256mb).
Once the size limit is reached, the SDK will automatically remove messages and channels with pre-specified logic (`clearOrder`) so that you don't have to actively manage it.

- Added DB size related properties in `LocalCacheConfig`
```kotlin
LocalCacheConfig().apply {
    maxSize = 256
    clearOrder = CachedDataClearOrder.MESSAGE_COLLECTION_ACCESSED_AT
}
```
- Added `SendbirdChat.getTotalUnreadMessageCount(GroupChannelTotalUnreadMessageCountParams, UnreadMessageCountHandler?)`
  - Deprecated `SendbirdChat.getTotalUnreadMessageCount(GroupChannelTotalUnreadMessageCountParams, CountHandler?)`
- Added `UserEventHandler.onTotalUnreadMessageCountChanged(UnreadMessageCount)`
  - Deprecated `UserEventHandler.onTotalUnreadMessageCountChanged(Int, Map<String, Int>)`

## v4.5.0 (Mar 03, 2023)

### **Features**
### **Encrypting Local Caching**
Locally saved chats in your user's device can now be encrypted using [SQLCipher](https://www.zetetic.net/sqlcipher/), a popular database encryption library.
As for exact how-to, please refer to below guide and API Reference.

#### Disclaimer
Note that this is an external 3rd party library and is not endorsed by Sendbird. The client must bring their own SQLCipher license and manage their encryption key

#### Brief guide
1. You must declare SQLCipher dependencies to use the encryption feature. Please refer [SQLCipher's documentation](https://www.zetetic.net/sqlcipher/sqlcipher-for-android/) to see how you can declare the SQLCipher dependencies.
2. Create `InitParams` and then set `LocalCacheConfig` and `SqlcipherConfig`. These options are turned off by default, so you don't have to set anything up if you don't intend to use them.
```
InitParams(APP_ID, Context, useCaching = true).apply { 
    localCacheConfig = LocalCacheConfig().apply { 
        sqlCipherConfig = SqlcipherConfig(ENCRYPTION_KEY)
    }
}
```
3. Call SendbirdChat.init with the `InitParams`

#### Specification
- `InitParams.localCacheConfig`
- `LocalCacheConfig.sqlcipherConfig`
- `SqlcipherConfig(password, licenseCode)`

### **Polls in Open Channel**
Polls is now supported in both Open Channels and Group Channels!

#### **Specification**
- Added `onPollUpdated`, `onPollVoted`, and `onPollDeleted` in `OpenChannelHandlerParams`
- Moved following methods from `GroupChannel` to `BaseChannel`:
    - `updatePoll()`
    - `deletePoll()`
    - `closePoll()`
    - `addPollOption()`
    - `updatePollOption()`
    - `deletePollOption()`
    - `votePoll()`
    - `getPollChangeLogsSinceTimestamp()`
    - `getPollChangeLogsSinceToken()`
    - `createPollListQuery()`
    - `createPollVoterListQuery()`

### **Improvements**
- Fixed a bug where `GroupChannelFilter` using nicknames (`nicknameContainsFilter`, `nicknameExactMatchFilter`, and `nicknameExactMatchFilter`) includes current user's nickname when searching from locally cached group channels.
- Fixed `ConcurrentModificationException` from `GroupChannelCollection.channelList`

## v4.4.1 (Feb 24, 2023)

### **Improvements**
- Fixed a bug where `SendbirdChat.markAsDelivered()` fails when it's called on receiving a push notification when the app is in killed state.

## v4.4.0 (Feb 15, 2023)

### **Features**

### Disconnect websocket only

When you call `SendbirdChat.disconnect`, it disconnects the WebSocket and clears local cache. You can think of it as logging out.

In some cases, you need to only disconnect the WebSocket. You can now do it by calling `SendbirdChat.disconnectWebSocket`.
It only disconnects the WebSocket and preserves the local cache.
```kotlin
SendbirdChat.disconnectWebSocket {
    // onDisconnected
}
```
To connect again after disconnecting with `disconnectWebSocket()`,
use [SendbirdChat.connect()](https://sendbird.com/docs/chat/v4/android/application/authenticating-a-user/authentication#2-connect-to-the-sendbird-server-with-a-user-id).
```kotlin
SendbirdChat.connect(userId) { user, e ->
    if (user != null) {
        // onConnected
    } else {
        // Handle error.
    }
}
```

### **Improvements**
- Added `SendbirdChat.isInitialized` which indicates whether the SDK is initialized or not
  - If the SDK is initialized with `InitParams.useCaching` is set to true, this will be true only after the asynchronous `InitResultHandler.onInitSucceed()` is called
- Fixed bug where `Poll.votedPollOptionIds` is not properly updated when a poll option is deleted
- Added default arguments for following functions. You can now call these functions without the `Params` arguments
  - `BaseChannel.getMessageChangeLogsSinceTimestamp`
  - `BaseChannel.getMessageChangeLogsSinceToken`
  - `SendbirdChat.getMyGroupChannelChangeLogsByTimestamp`
  - `SendbirdChat.getMyGroupChannelChangeLogsByToken`

## v4.3.0 (Feb 01, 2023)

### **Features**

Participant class in Open Channel

Participant is a new interface for User who joined Open Channel. It's optimized for scalability and contains much lighter information about the User than a Member in Group Channel. 
Now clients can implement Open Channels easier in SDK with more built-in capabilities. You can compare how Member, Participant, and User are different [here](https://sendbird.com/docs/chat/v4/android/user/overview-user#2-user-types)

- `Participant` holds essential information about the participant like below. They contain their muted status (`is_muted`) on top of basic User information 
```kotlin
class Participant : User {

    val isMuted: Boolean

    fun serialize(): ByteArray

    companion object {
        fun buildFromSerializedData(data: ByteArray?): Participant?
    }
}
```

- `ParticipantListQuery.next(UsersHandler)` now returns `List<Participant>`
  - For backward compatibility, the `UsersHandler` returns `User` list, but it can be casted into `Participant`

## v4.2.2 (Jan 18, 2023)

### **Features**

You can now set longer timeout value (Previously 10s) for session token expiry. (Default: 60s, Maximum: 1800s). This means that Sendbird SDK will wait longer for your new session token, making it easier for you to reconnect to our service. 

- `SendbirdChat.Options.setSessionTokenRefreshTimeout(Int)`

### **Improvements**

- Fixed bug where `BaseChannelHandler.onChannelChanged` and `GroupChannelHandler.onPinnedMessageUpdated` are not being called when the pinned message is updated

## v4.2.1 (Jan 09, 2023)
### **Improvements**
- Fixed possible ANR in `SendbirdChat.init()`

## v4.2.0 (Dec 09, 2022)

### **Features**
### **Pinned Message :pushpin:**
Pinned Message is released. You can now maintain a special set of messages (up to 10 per channel) that you want everyone in the channel to share. It can be anything from announcements, surveys, upcoming events, and any many more. Pin your messages and never miss them!
Stay tuned for updates as we are rolling out more exciting features and see below for exact specifications:point_down:
#### **Specification**
- Pin when sending a message
  - `UserMessageCreateParams.isPinnedMessage: Boolean = false`
  - `FileMessageCreateParams.isPinnedMessage: Boolean = false`
- Pin existing message
  - `GroupChannel.pinMessage(Long, CompletionHandler?)`
- Unpin a message
  - `GroupChannel.unpinMessage(Long, CompletionHandler?)`
- Pinned messages
  - `GroupChannel.lastPinnedMessage: BaseMessage? = null`
  - `GroupChannel.pinnedMessageIds: List<Long> = emptyList()`


#### **We strongly recommend using Collections (Message, Channel) to implement Pinned Messages as it would automatically take care of numerous events out of the box when messages are created, updated, and deleted.**
------
### **Improvements**
- Fixed `ConcurrentModificationException` from `VersioningCache.toString()`
## v4.1.3 (Nov 21, 2022)

### Improvements

- Added message filtering in `pendingMessages` and `failedMessages` of a `MessageCollection` using the `MessageListParams`
- Removed `isAnonymous` flag from Poll related interfaces
  - `Poll.isAnonymous`
  - `PollCreateParams.isAnonymous`
  - `PollUpdateParams.isAnonymous`
- Fixed pending message not being delivered by `MessageCollectionHandler.onMessagesAdded()` when sending a user message on an app built with Proguard on.
- Fixed crash when printing `CustomizableMessage.toString()`
- Fixed `ConcurrentModificationException` from `OpenChannel.toString()`

## v4.1.2 (Nov 18, 2022)

### Improvements

- Fixed MessageCollectionHandler.onMessagesUpdated() not being fired when sending a FILE message on an app built with Proguard on.

## v4.1.1 (Oct 20, 2022)

- Changed constructor of PollData to public.

## v4.1.0 (Oct 14, 2022)

# Features
## Polls
Polls is released :tada: Here’s where we think it will be really powerful.
- Collect feedback and customer satisfaction
- Drive engagement by receiving participants in preferences
- Run surveys and quiz shows
- And many more!
## Scheduled messages
Scheduled messages is released :confetti_ball: Here’s where we think it will be really useful.
- Let your users queue their messages for the future
- Set helpful reminders and notifications to nudge certain actions
- And many more!
## Improvements
- Fixed a bug where mentioned users are not cleared from a message when updating with an empty `BaseMessageUpdateParams.mentionedUsers` or `BaseMessageUpdateParams.mentionedUserIds`
- Fixed a `RejectedExecutionException` when receiving an event in `ConnectionStateManager.onEvent()`
- Fixed a crash when `SendbirdChat.connect()` is called with an invalid API/WS hosts

Please note that both Polls and Scheduled Messages are released as beta features. Thus specific parameters and properties may change to improve client’s overall experience.

Stay tuned for updates as we are rolling out more exciting features and see below for exact specifications :point_down:

--------
## Specification
### Polls
- Create
    - `Poll.create()`
        - `PollCreateParams`
    - `UserMessageCreateParams.pollId`
- Read
    - `Poll.get()`
        - `PollRetrievalParams`
    - `SendbirdChat.createPollListQuery()`
        - `PollListQueryParams`
    - `GroupChannel.createPollListQuery()`
    - `UserMessage.poll`
- Update
    - `GroupChannel.updatePoll()`
        - `PollUpdateParams`
    - `GroupChannel.closePoll()`
- Delete
    - `GroupChannel.deletePoll()`
- Others:
    - `Poll`
    - `GroupChannel.getPollChangeLogsSinceTimestamp()`
    - `GroupChannel.getPollChangeLogsSinceToken()`
    - `PollData`
    - `GroupChannelHandler.onPollUpdated()`
    - `GroupChannelHandler.onPollDeleted()`
### Options
- Create
    - `PollCreateParams.optionTexts`
    - `GroupChannel.addPollOption()`
- Read
    - `PollOption.get()`
        - `PollOptionRetrievalParams`
    - `SendbirdChat.createPollVoterListQuery()`
        - `PollVoterListQueryParams`
    - `GroupChannel.createPollVoterListQuery()`
- Update
    - `GroupChannel.updatePollOption()`
    - `GroupChannel.votePoll()`
- Delete
    - `GroupChannel.deletePollOption()`
- Others:
    - `PollOption`
    - `GroupChannelHandler.onPollVoted()`
    - `PollStatus`
    - `PollVoteEvent`
    - `PollUpdateEvent`
    - `CollectionEventSource.EVENT_POLL_UPDATED`
    - `CollectionEventSource.EVENT_POLL_VOTED`
    - `CollectionEventSource.POLL_CHANGELOG`
---------------
### Scheduled Messages
- Create
    - `GroupChannel.createScheduledUserMessage()`
    - `GroupChannel.createScheduledFileMessage()`
- Read
    - `ScheduledMessageListQuery`
    - `BaseMessage.getScheduledMessage()`
        - `ScheduledMessageRetrievalParams`
- Update
    - `GroupChannel.updateScheduledUserMessage()`
    - `GroupChannel.updateScheduledFileMessage()`
- Delete
    - `GroupChannel.cancelScheduledMessage()`
- Others
    - `ScheduledInfo`
    - `SendingStatus.SCHEDULED`
    - `BaseMessage.scheduledInfo`
    - `SendbirdChat.getTotalScheduledMessageCount()`
        - `TotalScheduledMessageCountParams`

### v4.0.9 (Sep 28, 2022)
- Added `nicknameStartsWithFilter` and `nicknameExactMatchFilter` in `GroupChannelListQueryParams`
- Implemented history of channel membership where clients can now track whether users have joined or left the channel (`MemberState.LEFT` for left members of a `GroupChannel`)
- Improved thread management to reduce total thread count when deleted

### v4.0.8 (Sep 2, 2022)
- Fixed a bug where `GroupChannelListQuery.next()` fails due to user ID not being properly encoded in the url

### v4.0.7 (Aug 31, 2022)
- Added Boolean switch to remove operator status when leaving channels (`GroupChannel.leave(shouldRemoveOperatorStatus: Boolean = false, handler: CompletionHandler)`)
- Added MessageSearchQuery's totalCount and made it public (MessageSearchQuery.totalCount)

### v4.0.6 (Aug 17, 2022)
- Fixed a bug where `onSessionTokenRequired` is not called immediately after session expires

### v4.0.5 (Jul 20, 2022)
- Improved API reference page's readability

### v4.0.4 (Jul 6, 2022)
- Modified `MessageCollection` to handle events for `channel.translateUserMessage()`
  - When a message is translated, it's corresponding event will be delivered by `MessageCollectionHandler.onMessagesUpdated()` with `MessageContext.CollectionEventSource.EVENT_MESSAGE_UPDATED`

### v4.0.3 (Jun 29, 2022)
- Fixed bugs
  - Pending message doesn't serialize propery when `UserMessageCreateParams.mentionedUsers` is set with a `Member` object
  - Canceled messages not being removed from the `MessageCollection`
  - The `requestId` of a pending message differs from the scheduled message (and the actual sent message)

### v4.0.2 (Jun 28, 2022)
- Changed `GroupChannel.createScheduledUserMessage` and `GroupChannel.createScheduledFileMessage` to return corresponding `SendingStatus.PENDING` message object.
- Fixed a bug where when reconnected, an updated message gets removed and added again in `MessageCollection`.

### v4.0.1 (Jun 24, 2022)
- Fixed a bug where both file object and file url in file message gets cleared when serialized/deserialized.

### v4.0.0 (Jun 14, 2022)
> To see detailed changes for below items, please refer to the [migration guide](https://sendbird.com/docs/chat/v4/android/getting-started/migration-guide)

- Codebase has been re-written from Java to Kotlin
- Naming of the main class has been changed from SendBird to SendbirdChat
- Deprecated interfaces from v3 has been removed
- Support for SyncManager has been removed

**Improvements**
- Added `HiddenChannelFilter.ALL` for `GroupChannelListQuery`
- Improved exception messages to provide more detail
- SDK log has been refined, now it provides more useful informations such as API request/response based on the LogLevel
- Added `MyMemberStateFilter`
  - `GroupChannelListQuery.memberStateFilter` &rarr; `GroupChannelListQuery.myMemberStateFilter`
  - `GroupChannelListQueryParams.memberStateFilter` &rarr; `GroupChannelListQueryParams.myMemberStateFilter`
  - `SendbirdChat.getGroupChannelCount(MemberStateFilter?, CountHandler?)` &rarr; `SendbirdChat.getGroupChannelCount(MyMemberStateFilter?, CountHandler?)`
- Changed all names that include `SendBird` to `Sendbird`
- Changed interfaces to be more kotlin style
	- Change getter, setter functions to property access
	  - From Kotlin side, access properties directly
	  - From Java side, access by `getSomething()` and `setSomething()`
	- Prefer List than MutableList
	- Specify nullability for return types and parameters
- Some parameter classes are separated to create/update parameter class
	- i.e. `UserMessageParams` is separated to `UserMessageCreateParams`, `UserMessageUpdateParams` Renamed
- Unifying callback handlers
	- i.e. `com.sendbird.android.BaseChannel.ReportHandler` is replaced by `com.sendbird.android.handler.CompletionHandler` that has same signature
- Namespace of the class has been refined
  - Repackage
	  - i.e. `com.sendbird.android.BaseMessage` &rarr; `com.sendbird.android.message.BaseMessage`
  - Moved nested classes to the top level
    - i.e. `com.sendbird.android.user.query.UserListQuery.UserListQueryResultHandler` &rarr; `com.sendbird.android.handler.UserListQueryResultHandler`
- Remove all setters for `Query` classes and made query properties immutable
  - Added corresponding `Params` classes

### v4.0.0-beta.*
For the changelog between the bete releases, please refer to [this page](https://github.com/sendbird/sendbird-chat-sdk-android/blob/main/CHANGELOG_V4_BETA.md)

### v3 Changelog
Please refer to [this page](https://github.com/sendbird/SendBird-SDK-Android/blob/master/CHANGELOG.md)
