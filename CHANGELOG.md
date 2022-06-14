# Change Log

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
