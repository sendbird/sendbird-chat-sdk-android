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
