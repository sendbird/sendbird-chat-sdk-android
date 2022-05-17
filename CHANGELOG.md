# Change Log

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
