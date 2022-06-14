#!/bin/sh

javaFiles=$(find . -name "*.java")
kotlinFiles=$(find . -name "*.kt")
allFiles=$(find . -name "*.java" -o -name "*.kt")

# Move `BaseChannel, GroupChannel, OpenChannel and ReadStatus` to com.sendbird.android.channel.* package.
sed -E -i "" "s/(import com.sendbird.android).(BaseChannel|GroupChannel|OpenChannel|ReadStatus)(;?$)/\1.channel.\2\3/g" $allFiles

# Move `GroupChannelListQuery, PublicGroupChannelListQuery and OpenChannelListQuery` to com.sendbird.android.channel.query.* package.
sed -E -i "" 's/(import com.sendbird.android).(GroupChannelListQuery|PublicGroupChannelListQuery|OpenChannelListQuery)(;?$)/\1.channel.query.\2\3/g' $allFiles

# Move `BaseCollection, CollectionLifecycle, GroupChannelCollection and MessageCollection` to com.sendbird.android.collection.* package.
sed -E -i "" 's/(import com.sendbird.android).(BaseCollection|CollectionLifecycle|GroupChannelCollection|MessageCollection)(;?$)/\1.collection.\2\3/g' $allFiles

# Move `GroupChannelContext, MessageContext, CollectionEventSource, Traceable and MessageCollectionInitPolicy` to com.sendbird.android.collection.* package.
sed -E -i "" 's/(import com.sendbird.android).handlers.(GroupChannelContext|MessageContext|CollectionEventSource|Traceable|MessageCollectionInitPolicy)(;?$)/\1.collection.\2\3/g' $allFiles

# Move `MessagePayloadFilter` to com.sendbird.android.params.common.* package.
sed -E -i "" 's/(import com.sendbird.android).(MessagePayloadFilter)(;?$)/\1.params.common.\2\3/g' $allFiles

# Rename `SendBird` to `Sendbird` and move `SendbirdError and SendbirdException` to com.sendbird.android.channel.query.* package`.
sed -E -i "" 's/(import com.sendbird.android).SendBird(Error|Exception)(;?$)/\1.exception.Sendbird\2\3/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()SendBird(Error|Exception)/\1Sendbird\2/g' $allFiles

# Move `AdminMessage, AppleCriticalAlertOptions, BaseMessage, Emoji, EmojiCategory, EmojiContainer, FileMessage, MentionType, MessageMetaArray,
# OGImage, OGMetaData, PushNotificationDeliveryOption, Reaction, ReactionEvent, ThreadInfo, ThreadInfoUpdateEvent, Plugin and UserMessage` to com.sendbird.android.message.* package.
sed -E -i "" 's/(import com.sendbird.android).(AdminMessage|AppleCriticalAlertOptions|BaseMessage|Emoji|EmojiCategory|EmojiContainer|FileMessage|MentionType|MessageMetaArray|OGImage|OGMetaData|PushNotificationDeliveryOption|Reaction|ReactionEvent|ThreadInfo|ThreadInfoUpdateEvent|Plugin|UserMessage)(;?$)/\1.message.\2\3/g' $allFiles

# Rename `ReplyTypeFilter` to `ReplyType` and repackaged
sed -E -i "" 's/(import com.sendbird.android).ReplyTypeFilter(;?$)/\1.message.ReplyType/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()ReplyTypeFilter/\1ReplyType/g' $allFiles

# Move `MessageSearchQuery, PreviousMessageListQuery` to com.sendbird.android.message.query.* package.
sed -E -i "" 's/(import com.sendbird.android).(MessageSearchQuery|PreviousMessageListQuery)(;?$)/\1.message.query.\2\3/g' $allFiles

# Rename `SendBird` to `Sendbird` and Move `AbstractPushHandler, OnPushTokenReceiveListener, SendBirdFirebaseInstanceIDService, SendBirdFirebaseMessagingService,
# SendBirdHmsMessagingService, SendBirdHmsPushHandler, SendBirdPushHandler and SendBirdPushHelper` to com.sendbird.android.push.* package.
sed -E -i "" 's/(import com.sendbird.android).(AbstractPushHandler|OnPushTokenReceiveListener|SendBirdFirebaseInstanceIDService|SendBirdFirebaseMessagingService|SendBirdHmsMessagingService|SendBirdHmsPushHandler|SendBirdPushHandler|SendBirdPushHelper)(;?$)/\1.push.\2\3/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\(|.)SendBird(FirebaseInstanceIDService|FirebaseMessagingService|HmsMessagingService|HmsPushHandler|HmsPushHandler|PushHandler|PushHelper)/\1Sendbird\2/g' $allFiles

# Move `Member, RestrictionType, RestrictedUser, RestrictionInfo, Sender and User` to com.sendbird.android.user.* package.
sed -E -i "" 's/(import com.sendbird.android).(Member|RestrictionType|RestrictedUser|RestrictionInfo|Sender|User)(;?$)/\1.user.\2\3/g' $allFiles

# Move `ApplicationUserListQuery, BannedUserListQuery, BlockedUserListQuery, FriendListQuery, GroupChannelMemberListQuery,
# MutedUserListQuery, OperatorListQuery, ParticipantListQuery, UserListQuery` to com.sendbird.android.user.query.* package.
sed -E -i "" 's/(import com.sendbird.android).(ApplicationUserListQuery|BannedUserListQuery|BlockedUserListQuery|FriendListQuery|GroupChannelMemberListQuery|MutedUserListQuery|OperatorListQuery|ParticipantListQuery|UserListQuery)(;?$)/\1.user.query.\2\3/g' $allFiles

# Move `BaseMessageListParams, GroupChannelChangeLogsParams, GroupChannelTotalUnreadChannelCountParams, GroupChannelTotalUnreadMessageCountParams, MessageChangeLogsParams, MessageListParams, MessageRetrievalParams and ThreadMessageListParams` to com.sendbird.android.params.* package.
sed -E -i "" 's/(import com.sendbird.android).(BaseMessageListParams|GroupChannelChangeLogsParams|GroupChannelTotalUnreadChannelCountParams|GroupChannelTotalUnreadMessageCountParams|MessageChangeLogsParams|MessageListParams|MessageRetrievalParams|ThreadMessageListParams)(;?$)/\1.params.\2\3/g' $allFiles

# Inner class to top level
sed -E -i "" 's/(import com.sendbird.android).Member.Role(;?$)/\1.channel.Role\2/g' $allFiles
sed -E -i "" 's/(import com.sendbird.android).SendBird.(ThreadOption|ConnectionState)(;?$)/\1.\2\3/g' $allFiles
sed -E -i "" 's/(import com.sendbird.android).GroupChannel.(UnreadItemKey)(;?$)/\1.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()Member.Role/\1Role/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()SendBird.(ThreadOption|ConnectionState)/\1\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()GroupChannel.UnreadItemKey/\1UnreadItemKey/g' $allFiles

# Handlers
## SendBird.GetXXX -> handler.XXX
sed -E -i "" 's/(import com.sendbird.android).SendBird.Get(SnoozePeriodHandler|PushTriggerOptionHandler|PushTokensHandler|PushTemplateHandler|PushSoundHandler|MyGroupChannelChangeLogsHandler|FriendChangeLogsByTokenHandler|AllEmojiHandler|EmojiCategoryHandler|EmojiHandler|MyGroupChannelChangeLogsHandler)(;?$)/\1.handler.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()Get(SnoozePeriodHandler|PushTriggerOptionHandler|PushTokensHandler|PushTemplateHandler|PushSoundHandler|MyGroupChannelChangeLogsHandler|FriendChangeLogsByTokenHandler|AllEmojiHandler|EmojiCategoryHandler|EmojiHandler|MyGroupChannelChangeLogsHandler)/\1\2/g' $allFiles

## BaseMessageHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseChannel.MessageMetaArrayHandler|BaseMessage.GetMessageHandler|BaseChannel.MessageMetaArrayHandler)(;?$)/\1.handler.BaseMessageHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseChannel.MessageMetaArrayHandler|BaseMessage.GetMessageHandler)/\1BaseMessageHandler/g' $allFiles

## BaseMessagesHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseChannel.GetMessagesHandler|MessageSearchQuery.MessageSearchQueryResultHandler|PreviousMessageListQuery.MessageListQueryResult)(;?$)/\1.handler.BaseMessagesHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseChannel.GetMessagesHandler|MessageSearchQuery.MessageSearchQueryResultHandler|PreviousMessageListQuery.MessageListQueryResult)/\1BaseMessagesHandler/g' $allFiles

## MetaCounterHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseChannel.MetaCounterHandler)(;?$)/\1.handler.MetaCounterHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseChannel.MetaCounterHandler)/\1MetaCounterHandler/g' $allFiles

## MetaDataHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseChannel.MetaDataHandler|User.MetaDataHandler)(;?$)/\1.handler.MetaDataHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseChannel.MetaDataHandler|User.MetaDataHandler)/\1MetaDataHandler/g' $allFiles

## FileMessageHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseChannel.CopyFileMessageHandler|BaseChannel.ResendFileMessageHandler|BaseChannel.SendFileMessageHandler|BaseChannel.UpdateFileMessageHandler)(;?$)/\1.handler.FileMessageHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseChannel.CopyFileMessageHandler|BaseChannel.ResendFileMessageHandler|BaseChannel.SendFileMessageHandler|BaseChannel.UpdateFileMessageHandler)/\1FileMessageHandler/g' $allFiles

## UserMessageHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseChannel.CopyUserMessageHandler|BaseChannel.ResendUserMessageHandler|BaseChannel.SendUserMessageHandler|BaseChannel.TranslateUserMessageHandler|BaseChannel.UpdateUserMessageHandler)(;?$)/\1.handler.UserMessageHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseChannel.CopyUserMessageHandler|BaseChannel.ResendUserMessageHandler|BaseChannel.SendUserMessageHandler|BaseChannel.TranslateUserMessageHandler|BaseChannel.UpdateUserMessageHandler)/\1UserMessageHandler/g' $allFiles

## CompletionHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseChannel.DeleteMessageHandler|BaseChannel.DeleteMetaCounterHandler|BaseChannel.DeleteMetaDataHandler|BaseChannel.ReportHandler|BaseChannel.ReportMessageHandler|BaseChannel.ReportUserHandler|GroupChannel.GroupChannelAcceptInvitationHandler|GroupChannel.GroupChannelBanHandler|GroupChannel.GroupChannelDeclineInvitationHandler|GroupChannel.GroupChannelDeleteHandler|GroupChannel.GroupChannelFreezeHandler|GroupChannel.GroupChannelHideHandler|GroupChannel.GroupChannelInviteHandler|GroupChannel.GroupChannelJoinHandler|GroupChannel.GroupChannelLeaveHandler|GroupChannel.GroupChannelMuteHandler|GroupChannel.GroupChannelRefreshHandler|GroupChannel.GroupChannelResetMyHistoryHandler|GroupChannel.GroupChannelSetMyCountPreferenceHandler|GroupChannel.GroupChannelSetMyPushTriggerOptionHandler|GroupChannel.GroupChannelSetPushPreferenceHandler|GroupChannel.GroupChannelUnbanHandler|GroupChannel.GroupChannelUnfreezeHandler|GroupChannel.GroupChannelUnhideHandler|GroupChannel.GroupChannelUnmuteHandler|OpenChannel.OpenChannelBanHandler|OpenChannel.OpenChannelDeleteHandler|OpenChannel.OpenChannelEnterHandler|OpenChannel.OpenChannelExitHandler|OpenChannel.OpenChannelMuteHandler|OpenChannel.OpenChannelRefreshHandler|OpenChannel.OpenChannelUnbanHandler|OpenChannel.OpenChannelUnmuteHandler|SendBird.DeleteFriendDiscoveriesHandler|SendBird.DeleteFriendDiscoveryHandler|SendBird.DeleteFriendHandler|SendBird.DeleteFriendsHandler|SendBird.MarkAsReadHandler|SendBird.SetChannelInvitationPreferenceHandler|SendBird.SetDoNotDisturbHandler|SendBird.SetPushSoundHandler|SendBird.SetPushTemplateHandler|SendBird.SetPushTriggerOptionHandler|SendBird.SetSnoozePeriodHandler|SendBird.UnregisterPushTokenHandler|SendBird.UploadFriendDiscoveriesHandler|SendBird.UserInfoUpdateHandler|SendBird.UserUnblockHandler|User.DeleteMetaDataHandler|handlers.AddOperatorsHandler|handlers.AllowFriendDiscoveryHandler)(;?$)/\1.handler.CompletionHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseChannel.DeleteMessageHandler|BaseChannel.DeleteMetaCounterHandler|BaseChannel.DeleteMetaDataHandler|BaseChannel.ReportHandler|BaseChannel.ReportMessageHandler|BaseChannel.ReportUserHandler|GroupChannel.GroupChannelAcceptInvitationHandler|GroupChannel.GroupChannelBanHandler|GroupChannel.GroupChannelDeclineInvitationHandler|GroupChannel.GroupChannelDeleteHandler|GroupChannel.GroupChannelFreezeHandler|GroupChannel.GroupChannelHideHandler|GroupChannel.GroupChannelInviteHandler|GroupChannel.GroupChannelJoinHandler|GroupChannel.GroupChannelLeaveHandler|GroupChannel.GroupChannelMuteHandler|GroupChannel.GroupChannelRefreshHandler|GroupChannel.GroupChannelResetMyHistoryHandler|GroupChannel.GroupChannelSetMyCountPreferenceHandler|GroupChannel.GroupChannelSetMyPushTriggerOptionHandler|GroupChannel.GroupChannelSetPushPreferenceHandler|GroupChannel.GroupChannelUnbanHandler|GroupChannel.GroupChannelUnfreezeHandler|GroupChannel.GroupChannelUnhideHandler|GroupChannel.GroupChannelUnmuteHandler|OpenChannel.OpenChannelBanHandler|OpenChannel.OpenChannelDeleteHandler|OpenChannel.OpenChannelEnterHandler|OpenChannel.OpenChannelExitHandler|OpenChannel.OpenChannelMuteHandler|OpenChannel.OpenChannelRefreshHandler|OpenChannel.OpenChannelUnbanHandler|OpenChannel.OpenChannelUnmuteHandler|SendBird.DeleteFriendDiscoveriesHandler|SendBird.DeleteFriendDiscoveryHandler|SendBird.DeleteFriendHandler|SendBird.DeleteFriendsHandler|SendBird.MarkAsReadHandler|SendBird.SetChannelInvitationPreferenceHandler|SendBird.SetDoNotDisturbHandler|SendBird.SetPushSoundHandler|SendBird.SetPushTemplateHandler|SendBird.SetPushTriggerOptionHandler|SendBird.SetSnoozePeriodHandler|SendBird.UnregisterPushTokenHandler|SendBird.UploadFriendDiscoveriesHandler|SendBird.UserInfoUpdateHandler|SendBird.UserUnblockHandler|User.DeleteMetaDataHandler|handlers.AddOperatorsHandler|handlers.AllowFriendDiscoveryHandler)/\1CompletionHandler/g' $allFiles

## FileMessageWithProgressHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseChannel.ResendFileMessageWithProgressHandler|BaseChannel.SendFileMessageWithProgressHandler)(;?$)/\1.handler.FileMessageWithProgressHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseChannel.ResendFileMessageWithProgressHandler|BaseChannel.SendFileMessageWithProgressHandler)/\1FileMessageWithProgressHandler/g' $allFiles

## FileMessagesHandler
sed -E -i "" 's/(import com.sendbird.android).BaseChannel.SendFileMessagesHandler(;?$)/\1.handler.FileMessagesHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()BaseChannel.SendFileMessagesHandler/\1FileMessagesHandler/g' $allFiles

## FileMessagesWithProgressHandler
sed -E -i "" 's/(import com.sendbird.android).BaseChannel.SendFileMessagesWithProgressHandler(;?$)/\1.handler.FileMessagesWithProgressHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()BaseChannel.SendFileMessagesWithProgressHandler/\1FileMessagesWithProgressHandler/g' $allFiles

## CountHandler
sed -E -i "" 's/(import com.sendbird.android).(GroupChannel.GroupChannelTotalUnreadChannelCountHandler|GroupChannel.GroupChannelTotalUnreadMessageCountHandler|GroupChannel.GroupChannelChannelCountHandler)(;?$)/\1.handler.CountHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(GroupChannel.GroupChannelTotalUnreadChannelCountHandler|GroupChannel.GroupChannelTotalUnreadMessageCountHandler|GroupChannel.GroupChannelChannelCountHandler)/\1CountHandler/g' $allFiles

## GroupChannelCallbackHandler
sed -E -i "" 's/(import com.sendbird.android).(GroupChannel.GroupChannelCreateHandler|GroupChannel.GroupChannelGetHandler|GroupChannel.GroupChannelUpdateHandler)(;?$)/\1.handler.GroupChannelCallbackHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(GroupChannel.GroupChannelCreateHandler|GroupChannel.GroupChannelGetHandler|GroupChannel.GroupChannelUpdateHandler)/\1GroupChannelCallbackHandler/g' $allFiles

## OpenChannelCallbackHandler
sed -E -i "" 's/(import com.sendbird.android).(OpenChannel.OpenChannelCreateHandler|OpenChannel.OpenChannelGetHandler|OpenChannel.OpenChannelUpdateHandler)(;?$)/\1.handler.OpenChannelCallbackHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(OpenChannel.OpenChannelCreateHandler|OpenChannel.OpenChannelGetHandler|OpenChannel.OpenChannelUpdateHandler)/\1OpenChannelCallbackHandler/g' $allFiles

## UsersHandler
sed -E -i "" 's/(import com.sendbird.android).(OperatorListQuery.OperatorListQueryResultHandler|SendBird.AddFriendsHandler)(;?$)/\1.handler.UsersHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(OperatorListQuery.OperatorListQueryResultHandler|SendBird.AddFriendsHandler)/\1UsersHandler/g' $allFiles

## UserHandler
sed -E -i "" 's/(import com.sendbird.android).(SendBird.UserBlockHandler)(;?$)/\1.handler.UserHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(SendBird.UserBlockHandler)/\1UserHandler/g' $allFiles

## ReactionHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseChannel.ReactionHandler)(;?$)/\1.handler.ReactionHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseChannel.ReactionHandler)/\1ReactionHandler/g' $allFiles

## GetThreadedMessagesHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseMessage.GetThreadedMessagesHandler)(;?$)/\1.handler.ThreadedMessagesHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseMessage.GetThreadedMessagesHandler)/\1ThreadedMessagesHandler/g' $allFiles

## GetChannelInvitationPreferenceHandler
sed -E -i "" 's/(import com.sendbird.android).(SendBird.GetChannelInvitationPreferenceHandler)(;?$)/\1.handler.ChannelInvitationPreferenceHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(SendBird.GetChannelInvitationPreferenceHandler)/\1ChannelInvitationPreferenceHandler/g' $allFiles

## DoNotDisturbHandler
sed -E -i "" 's/(import com.sendbird.android).(SendBird.GetDoNotDisturbHandler)(;?$)/\1.handler.DoNotDisturbHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(SendBird.GetDoNotDisturbHandler)/\1DoNotDisturbHandler/g' $allFiles

## DoNotDisturbHandler
sed -E -i "" 's/(import com.sendbird.android).(SendBird.RegisterPushTokenWithStatusHandler)(;?$)/\1.handler.PushTokenWithStatusHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(SendBird.RegisterPushTokenWithStatusHandler)/\1PushTokenWithStatusHandler/g' $allFiles

## DoNotDisturbHandler
sed -E -i "" 's/(import com.sendbird.android).(BaseChannel.GetMyMutedInfoHandler)(;?$)/\1.handler.MyMutedInfoHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(BaseChannel.GetMyMutedInfoHandler)/\1MyMutedInfoHandler/g' $allFiles

## Move GroupChannel inner class
sed -E -i "" 's/(import com.sendbird.android).GroupChannel.(GroupChannelCreateDistinctChannelIfNotExistHandler|GroupChannelGetMyPushTriggerOptionHandler)(;?$)/\1.handler.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()GroupChannel.(GroupChannelCreateDistinctChannelIfNotExistHandler|GroupChannelGetMyPushTriggerOptionHandler)/\1\2/g' $allFiles

## Move SendBird inner class
sed -E -i "" 's/(import com.sendbird.android).SendBird.(ConnectHandler|ConnectionHandler|DisconnectHandler|UserEventHandler)(;?$)/\1.handler.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()SendBird.(ConnectHandler|ConnectionHandler|DisconnectHandler|UserEventHandler)/\1\2/g' $allFiles

## handlers to handler
sed -E -i "" 's/(import com.sendbird.android).handlers.(GetAllowFriendDiscoveryHandler|MessageChangeLogsHandler|InitResultHandler|MessageCollectionHandler|MessageCollectionInitHandler|ChannelChangeLogsHandler|RemoveFailedMessagesHandler|CompletionHandler|GroupChannelCollectionHandler)(;?$)/\1.handler.\2\3/g' $allFiles

# Push
sed -E -i "" 's/(import com.sendbird.android).SendBird.(PushTokenType|PushTokenRegistrationStatus)(;?$)/\1.push.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()SendBird.(PushTokenType|PushTokenRegistrationStatus)/\1\2/g' $allFiles

# Move BaseChannel inner class
sed -E -i "" 's/(import com.sendbird.android).BaseChannel.(ReportCategory|MessageTypeFilter)(;?$)/\1.channel.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()BaseChannel.(ReportCategory|MessageTypeFilter)/\1\2/g' $allFiles

# Move GroupChannel inner class
sed -E -i "" 's/(import com.sendbird.android).BaseChannel.(HiddenState|CountPreference|ChannelType)(;?$)/\1.channel.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()BaseChannel.(HiddenState|CountPreference|ChannelType)/\1\2/g' $allFiles

# Move BaseMessage inner class
sed -E -i "" 's/(import com.sendbird.android).BaseMessage.(SendingStatus)(;?$)/\1.message.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()BaseChannel.(SendingStatus)/\1\2/g' $allFiles

# Move FileMessage inner class
sed -E -i "" 's/(import com.sendbird.android).FileMessage.(Thumbnail|ThumbnailSize)(;?$)/\1.message.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()FileMessage.(Thumbnail|ThumbnailSize)/\1\2/g' $allFiles

# Move Member inner class
sed -E -i "" 's/(import com.sendbird.android).Member.(MutedState|MemberState)(;?$)/\1.user.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()Member.(MutedState|MemberState)/\1\2/g' $allFiles

# Move ReactionEvent inner class
sed -E -i "" 's/(import com.sendbird.android).ReactionEvent.(ReactionEventAction)(;?$)/\1.message.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()ReactionEvent.(ReactionEventAction)/\1\2/g' $allFiles

# Move SendBirdPushHelper inner class
sed -E -i "" 's/(import com.sendbird.android).SendBirdPushHelper.OnPushRequestCompleteListener(;?$)/\1.handler.PushRequestCompleteHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()SendBirdPushHelper.OnPushRequestCompleteListener/\1PushRequestCompleteHandler/g' $allFiles

# Move GroupChannelMemberListQuery inner class
sed -E -i "" 's/(import com.sendbird.android).GroupChannelMemberListQuery.(OperatorFilter|MutedMemberFilter|MemberStateFilter)(;?$)/\1.user.query.\2/g' $allFiles
sed -E -i "" 's/(import com.sendbird.android).GroupChannelMemberListQuery.GroupChannelMemberListQueryResultHandler(;?$)/\1.handler.MembersHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()GroupChannelMemberListQuery.(OperatorFilter|MutedMemberFilter|MemberStateFilter)/\1\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()GroupChannelMemberListQuery.GroupChannelMemberListQueryResultHandler/\1MembersHandler/g' $allFiles

# Move GroupChannelListQuery inner class
sed -E -i "" 's/(import com.sendbird.android).(GroupChannelListQuery.SuperChannelFilter|PublicGroupChannelListQuery.SuperChannelFilter)(;?$)/\1.channel.SuperChannelFilter/g' $allFiles
sed -E -i "" 's/(import com.sendbird.android).GroupChannelListQuery.(MembershipFilter|SearchField|QueryType|PublicChannelFilter|UnreadChannelFilter|HiddenChannelFilter)(;?$)/\1.channel.query.\2/g' $allFiles
sed -E -i "" 's/(import com.sendbird.android).PublicGroupChannelListQuery.(MembershipFilter)(;?$)/\1.channel.query.\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()GroupChannelListQuery.(SuperChannelFilter|MembershipFilter|SearchField|QueryType|PublicChannelFilter|UnreadChannelFilter|HiddenChannelFilter)/\1\2/g' $allFiles
sed -E -i "" 's/(import com.sendbird.android).GroupChannelListQuery.MemberStateFilter(;?$)/\1.channel.query.MyMemberStateFilter/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()GroupChannelListQuery.MemberStateFilter/\1MyMemberStateFilter/g' $allFiles

sed -E -i "" 's/(import com.sendbird.android).handlers.(OnChannelLoadResultHandler)(;?$)/\1.handler.GroupChannelsCallbackHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()OnChannelLoadResultHandler/\1GroupChannelsCallbackHandler/g' $allFiles

sed -E -i "" 's/(import com.sendbird.android).(GroupChannelListQuery.GroupChannelListQueryResultHandler|PublicGroupChannelListQuery.PublicGroupChannelListQueryResultHandler)(;?$)/\1.handler.GroupChannelsCallbackHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()GroupChannelListQuery.GroupChannelListQueryResultHandler/\1GroupChannelsCallbackHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()PublicGroupChannelListQuery.PublicGroupChannelListQueryResultHandler/\1GroupChannelsCallbackHandler/g' $allFiles

sed -E -i "" 's/(import com.sendbird.android).(OpenChannelListQuery.OpenChannelListQueryResultHandler)(;?$)/\1.handler.OpenChannelsCallbackHandler/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()OpenChannelListQuery.OpenChannelListQueryResultHandler/\1OpenChannelsCallbackHandler/g' $allFiles

sed -E -i "" 's/(import com.sendbird.android).(GroupChannelListQuery.Order|PublicGroupChannelListQuery.Order)(;?$)/\1.channel.query.GroupChannelListQueryOrder/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()(GroupChannelListQuery.Order|PublicGroupChannelListQuery.Order)/\1GroupChannelListQueryOrder/g' $allFiles

# Rename GroupChannelMemberListQuery to MemberListQuery
sed -E -i "" 's/([[:space:]]|:|=|\()GroupChannelMemberListQuery/\1MemberListQuery/g' $allFiles

# Renamed functions
sed -E -i "" 's/\.updateCurrentUserInfoWithProfileImage\(/\.updateCurrentUserInfo\(/g' $allFiles
sed -E -i "" 's/\.registerPushTokenForCurrentUser\(/\.registerPushToken\(/g' $allFiles
sed -E -i "" 's/\.unregisterPushTokenForCurrentUser\(/\.unregisterPushToken\(/g' $allFiles
sed -E -i "" 's/\.unregisterPushTokenAllForCurrentUser\(/\.unregisterPushTokenAll\(/g' $allFiles
sed -E -i "" 's/\.getMyGroupChannelChangeLogsByTokenWithParams\(/\.getMyGroupChannelChangeLogsByToken\(/g' $allFiles
sed -E -i "" 's/\.getMyGroupChannelChangeLogsByTimestampWithParams\(/\.getMyGroupChannelChangeLogsByTimestamp\(/g' $allFiles
sed -E -i "" 's/\.inviteWithUserId\(/\.invite\(/g' $allFiles
sed -E -i "" 's/\.banUserWithUserId\(/\.banUser\(/g' $allFiles
sed -E -i "" 's/\.unbanUserWithUserId\(/\.unbanUser\(/g' $allFiles
sed -E -i "" 's/\.muteUserWithUserId\(/\.muteUser\(/g' $allFiles
sed -E -i "" 's/\.unmuteUserWithUserId\(/\.unmuteUser\(/g' $allFiles
sed -E -i "" 's/\.isOperatorWithUserId\(/\.isOperator\(/g' $allFiles
sed -E -i "" 's/\.markAsReadWithChannelUrls\(/\.markAsRead\(/g' $allFiles
sed -E -i "" 's/\.blockUserWithUserId\(/\.blockUser\(/g' $allFiles
sed -E -i "" 's/\.unblockUserWithUserId\(/\.unblockUser\(/g' $allFiles

# SendBird
sed -E -i "" 's/(import com.sendbird.android).SendBird(;?$)/\1.SendbirdChat\2/g' $allFiles
sed -E -i "" 's/([[:space:]]|:|=|\()SendBird\./\1SendbirdChat./g' $allFiles
