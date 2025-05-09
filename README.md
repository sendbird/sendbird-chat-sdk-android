# [Sendbird](https://sendbird.com) Chat SDK for Android

[![Platform](https://img.shields.io/badge/platform-android-orange.svg)](https://github.com/sendbird/sendbird-chat-sdk-android)
[![Languages](https://img.shields.io/badge/language-kotlin-orange.svg)](https://github.com/sendbird/sendbird-chat-sdk-android)
[![This version of 'sendbird-chat' @ Cloudsmith](https://api-prd.cloudsmith.io/v1/badges/version/sendbird/release/maven/sendbird-chat/latest/a=noarch;xg=com.sendbird.sdk/?render=true&show_latest=true)](https://cloudsmith.io/~sendbird/repos/release/packages/detail/maven/sendbird-chat/latest/a=noarch;xg=com.sendbird.sdk/)
[![Commercial License](https://img.shields.io/badge/license-Commercial-brightgreen.svg)](https://github.com/sendbird/sendbird-chat-sdk-android/blob/main/LICENSE.md)

## Table of contents

1.  [Introduction](#introduction)
1.  [Requirements](#requirements)
1.  [Getting started](#getting-started)
1.  [Sending your first message](#sending-your-first-message)
1.  [Size of Chat SDK](#size-of-chat-sdk)
1.  [Hiring](#we-are-hiring)

<br />

## Introduction

The Sendbird Chat SDK for Android allows you to add real-time chat into your client app with minimal effort. Sendbird offers a feature rich, scalable, and proven chat solution depended on by companies like Reddit, Hinge, PubG and Paytm.
<br />

### How it works

The Chat SDK provides the full functionality to provide a rich chat experience, implementing it begins by adding a user login, listing the available channels, selecting or creating an [open channel](https://sendbird.com/docs/chat/v4/android/guides/open-channel) or [group channel](https://sendbird.com/docs/chat/v4/android/guides/group-channel), and receive messages and other events through [channel event delegates](https://sendbird.com/docs/chat/v4/android/guides/event-delegate) and the ability to send a message. Once this basic functionality is in place, congratulations, you now have a chat app!

Once this is in place, take a look at [all the other features](https://sendbird.com/features/chat-messaging/features) that Sendbird supports and add what works best for your users.
<br />

### Documentation

Find out more about Sendbird Chat for Android on [the documentation](https://sendbird.com/docs/chat/v4/android/getting-started/about-chat-sdk). If you have any comments, questions or feature requests, let us know in the [Sendbird community](https://community.sendbird.com).
<br />

## Requirements

The minimum requirements for the Chat SDK for Android are:

- `Android 5.0 (API level 21) or higher`
- `Java 8 or higher`
- `Android Gradle plugin 3.4.2 or higher`
- `Firebase Cloud Messaging 19.0.1 or higher`

> **Note**: Sendbird server supports Transport Layer Security (TLS) from version 1.0 up to 1.3. For example, in the server regions where TLS 1.3 isn’t available, lower versions, sequentially from 1.2 to 1.0, will be supported for secure data transmission.

<br />

## Getting started

The quickest way to get started is by using one of the sample apps from the [samples repo](https://github.com/sendbird/sendbird-chat-sample-android), create an application in the [Sendbird dashboard](https://dashboard.sendbird.com) and copy the `App ID` to the sample app and you’re ready to go.

<br />

## Step by step

### Step 1: Create a Sendbird application from your dashboard

Before installing Sendbird Chat SDK, you need to create a Sendbird application on the [Sendbird Dashboard](https://dashboard.sendbird.com). You will need the `App ID` of your Sendbird application when initializing the Chat SDK.

> **Note**: Each Sendbird application can be integrated with a single client app. Within the same application, users can communicate with each other across all platforms, whether they are on mobile devices or on the web.

<br />

### Step 2: Install the Chat SDK

Installing the Chat SDK is simple if you're familiar with using external libraries or SDKs. First, add the following code to your **root** `build.gradle` file:

```gradle
allprojects {
    repositories {
        ...
        maven { url "https://repo.sendbird.com/public/maven" }
    }
}
```

> Note: Make sure the above code block isn't added to your module `build.gradle` file.

If using Gradle 6.8 or higher, add the following to your `settings.gradle` file:
```gradle
dependencyResolutionManagement {
    repositories {
        maven { url "https://repo.sendbird.com/public/maven" }
    }
}
```

Then, add the dependency to the project's top-level `build.gradle` file:

```gradle
dependencies {
    ...
    implementation 'com.sendbird.sdk:sendbird-chat:4.25.0'
    ...
}
```

#### - TLS 1.3

TLS 1.3 is enabled by default in Sendbird SDK for Android. To disable it, please include the following configuration to the gradle dependency:

> Note: The SendBird Android SDK depends on the [Conscrypt](https://github.com/google/conscrypt) library in order to support TLS 1.3

```gradle
dependencies {
    implementation ('com.sendbird.sdk:sendbird-chat:4.25.0') {
        exclude group: 'org.conscrypt', module: 'conscrypt-android'
    }
}
```

### Step 3: Grant system permissions to the Chat SDK

The Chat SDK requires system permissions, which allow for communication with Sendbird server and the reading and writing on a user device’s storage To grant system permissions, add the following lines to your `AndroidManifest.xml` file.

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

### (Optional) Configure ProGuard to shrink code and resources

When you build your APK with `minifyEnabled true`, add the following line to the module's `ProGuard` rules file.

```txt
-dontwarn com.sendbird.android.shadow.**
```

<br />

## Sending your first message

Now that the Chat SDK has been imported, we're ready to start sending a message.

### Authentication

In order to use the features of the Chat SDK, a `SendbirdChat` instance must be initiated through user authentication with Sendbird server. This instance communicates and interacts with the server based on an authenticated user account, and then the user’s client app can use the Chat SDK's features.

Here are the steps to sending your first message using Chat SDK:

<br />

### Step 4: Initialize the Chat SDK

Now, initialize the Chat SDK in the app to allow the Chat SDK to respond to changes in the connection status in Android client apps.

To initialize the `SendbirdChat` instance, pass the `APP_ID` of your Sendbird application in the [Sendbird Dashboard](https://dashboard.sendbird.com) as an argument to a parameter in the `SendbirdChat.init()` method. As the `SendbirdChat.init()` can only be a single instance, call it only a single time across your Android client app. Typically, initialization is implemented in the user login screen.

> Note: It is recommended to initialize the Chat SDK in the `onCreate()` method of the [`Application`](https://developer.android.com/reference/android/app/Application) instance.

```kotlin
SendbirdChat.init(InitParams(APP_ID, applicationContext, useCaching = true))
```

### Step 5: Connect to Sendbird server

After initialization by use of the `init()` method, your client app must always be connected to Sendbird server before calling any methods. If you attempt to call a method without connecting, an `ERR_CONNECTION_REQUIRED (800101)` error would return.

Connect a user to Sendbird server either through a unique user ID or in combination with an access token. Sendbird prefers the latter method, as it ensures privacy with the user. The former is useful during the developmental phase or if your service doesn't require additional security.

#### A. Using a unique user ID

Connect a user to Sendbird server using their unique **user ID**. By default, Sendbird server can authenticate a user by a unique user ID. Upon request for a connection, the server queries the database to check for a match. Any untaken user ID is automatically registered as a new user to the Sendbird system, while an existing ID is allowed to log indirectly. The ID must be unique within a Sendbird application, such as a hashed email address or phone number in your service.

This allows you to get up and running without having to go deep into the details of the token registration process, however make sure to enable enforcing tokens before launching as it is a security risk to launch without.

```kotlin
SendbirdChat.connect(USER_ID) { user, e ->
    if (e != null) { // Error.
        return@connect
    }
}
```

#### B. Using a combination of unique user ID and token

Sendbird prefers that you pass the APP ID through the use of a token, as it ensures privacy and security for the users. [Create a user](https://sendbird.com/docs/chat/v3/platform-api/guides/user#2-create-a-user) along with their access token, or [issue an session token](https://sendbird.com/docs/chat/v3/platform-api/user/managing-session-tokens/issue-a-session-token) to pass during connection. A comparison between an access token and session token can be found [here](https://sendbird.com/docs/chat/v3/platform-api/user/managing-session-tokens/issue-a-session-token). Once a token is issued, a user is required to provide the issued token in the `SendbirdChat.connect()` method which is used for logging in.

1. Using the Chat Platform API, create a Sendbird user account with the information submitted when a user signs up your service.
2. Save the user ID along with the issued token to your persistent storage which is securely managed.
3. When the user attempts to log in to the Sendbird application, load the user ID and token from the storage, and then pass them to the `SendbirdChat.connect()` method.
4. Periodically replacing the user's token is recommended to protect the account.

```kotlin
SendbirdChat.connect(USER_ID, AUTH_TOKEN) { user, e ->
    if (e != null) { // Error.
        return@connect
    }
}
```

<br />

### Step 6: Create a new open channel

Create an open channel using the following codes. [Open channels](https://sendbird.com/docs/chat/v4/android/guides/open-channel#2-create-a-channel) are where all users in your Sendbird application can easily participate without an invitation.

```kotlin
OpenChannel.createChannel(OpenChannelCreateParams()) { channel, e ->
    if (e != null) { // Error.
        return@createChannel
    }
}
```

**Note**: You can also create a group channel to send a message. To learn more, see [Create a channel](https://sendbird.com/docs/chat/v4/android/guides/group-channel#2-create-a-channel) in the Group channel page.
<br />

### Step 7: Enter the channel

Enter the open channel to send and receive messages.

```kotlin
OpenChannel.getChannel(CHANNEL_URL) { channel, e ->
    if (e != null) { // Error.
        return@getChannel
    }

    channel?.enter { enterError ->
        if (enterError != null) { // Error.
            return@enter
        }
    }
}
```

<br />

### Step 8: Send a message to the channel

Finally, send a message to the channel. There are [three types](https://sendbird.com/docs/chat/v3/platform-api/guides/messages#-3-resource-representation): a user message, which is a plain text, a file message, which is a binary file, such as an image or PDF, and an admin message, which is a plain text also sent through the [dashboard](https://dashboard.sendbird.com/auth/signin) or [Chat Platform API](https://sendbird.com/docs/chat/v3/platform-api/guides/messages#2-send-a-message).

```kotlin
openChannel.sendUserMessage(MESSAGE) { message, e ->
    if (e != null) { // Error.
        return@sendUserMessage
    }
}
```

<br />

## Size of Chat SDK

The size of the Chat SDK is an important factor to consider when integrating it into your app. The size of the Chat SDK is as follows:

- **SDK size**: 1.4 MB
- **Minified SDK size**: 1.1 MB

## We are hiring

At Sendbird, we are a diverse group of humble, friendly, and hardworking individuals united by a shared purpose to build the next generation of mobile & social technologies, across chat, voice, and video, that are changing the way we work and live. We're always looking for great people to join our team. [Check out our careers page](https://sendbird.com/careers) for more information.
