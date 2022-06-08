# Change Log

### v4.0.0-beta.8 (Jun 8, 2022)
- Contains breaking changes since last beta release.
  1. Moved nested classes to the top level.
      - i.e. `com.sendbird.android.user.query.UserListQuery.UserListQueryResultHandler` → `com.sendbird.android.handler.UserListQueryResultHandler`.
  2. Removed setter functions that return the itself.
      - For Kotlin, use property syntax `property = value`.
      - For Java, all `set*()` functions don't return itself.
  3. Removed redundant properties that has an alternative.
      - i.e.)
        - `PreviousMessageListQuery.shouldIncludeMetaArray()` &rarr; `PreviousMessageListQuery.messagePayloadFilter.includeMetaArray`.
        - `GroupChannelCreateParams.addUser`, `GroupChannelCreateParams.addUsers` &rarr; `GroupChannelCreateParams.users`.
  4. Renamed inconsistent getter functions to auto generated getter methods for Java.
      - For Kotlin, use property syntax `class.property`.
      - For Java, it's auto generated to `get*()`.
  5. Replace builder classes with class constructors
  6. Removed all `Enum.from(value:String?)` functions.
  7. Static function changed to non-static.
      - `OpenChannelCreateParams.clone()`
  8. Rename `SendbirdChat.Options.useMemberAsMessageSender` to `SendbirdChat.Options.useMemberInfoInMessage`.
      - `useMemberInfoInMessage` now applies to both `BaseMessage.sender` and `BaseMessage.mentionedUsers`.
  9. Remove all setters for `Query` classes and made query properties immutable.
      - Added corresponding `Params` classes.
  10. Removed + Renamed methods.
      - Removed
        - `GroupChannel.invite(User, CompletionHandler?)`.
        - `GroupChannel.invite(String, CompletionHandler?)`.
        - `GroupChannel.invite(List<User>, CompletionHandler?)`.
      - Renamed
        - `GroupChannel.inviteWithUserIds(List<String>, CompletionHandler?)` &rarr; `GroupChannel.invite(List<String>, CompletionHandler?)`.
        - `com.sendbird.android.handler.MyGroupChannelChangeLogsHandler` &rarr; `com.sendbird.android.handler.GroupChannelChangeLogsHandler`.

### v4.0.0-beta.7 (May 31, 2022)
- Added `BaseMessage.scheduleInfo` in `serialize()` and `deserialize()`.

### v4.0.0-beta.6 (May 24, 2022)
- Refactor SDK's logs. 
- Log level for SDK can now be set in `SendbirdChat.init` with `InitParams.logLevel`. The current default log level is `Log.WARN`.

### v4.0.0-beta.5 (May 17, 2022)
- Added `GroupChannel.sendScheduledMessageNow(Long, CompletionHandler?)`
- Fixed bug where typing indicator does not disappear after the internet has been lost.

### v4.0.0-beta.4 (May 10, 2022)
- Fixed a bug that failed to get a channel that has invalid metadata.

### v4.0.0-beta.3 (May 3, 2022)
- Added `HiddenChannelFilter.ALL` for GroupChannelListQuery
- Fixed bug where nicknameContainsFilter is filtered incorrectly in regards to case sensitivity

### v4.0.0.beta.2 (Apr 28, 2022)
- Added Scheduled Message Feature.
  - Added `GroupChannel.createScheduledUserMessage()`.
  - Added `GroupChannel.createScheduledFileMessage()`.
  - Added `GroupChannel.updateScheduledUserMessage()`.
  - Added `GroupChannel.updateScheduledFileMessage()`.
  - Added `GroupChannel.cancelScheduledMessage()`.
  - Added `ScheduledMessageListQuery`.
  - Added `Basemessage.scheduledInfo` which holds scheduled informations of a scheduled messages.
    - Added `ScheduledInfo`.
    - Added `SendingStatus.SCHEDULED`.
  - Added `BaseMessage.getScheduledMessage()`.
    - Added `ScheduledMessageRetrievalParams`.
  - Added `SendbirdChat.getTotalScheduledMessageCount()`.
    - Added `TotalScheduledMessageCountParams`.
- Improved exception messages to provide more detail.

### v4.0.0-beta.1 (Apr 19, 2022)
- Fix a bug that doesn't try reconnect immediately when the network has recovered.
- Channel's metadata related events not being delivered to `MessageCollectionHandler.onChannelUpdated()`.
