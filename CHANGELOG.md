# Changelog

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
