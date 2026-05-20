# Instagram Clone

An iOS photo sharing app built with Swift and UIKit, using Parse as the backend.

## Features

- User sign up and login with session persistence via Parse authentication
- Camera integration for taking photos and posting with captions
- Home feed showing the 20 most recent posts with pull-to-refresh
- Post detail view with timestamp and caption
- Tab bar navigation between all posts and personal posts
- Settings screen with logout

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift |
| UI | UIKit, Auto Layout |
| Backend | Parse |
| Networking | AFNetworking |
| Dependencies | CocoaPods |

## Setup

```bash
git clone https://github.com/gerardrecinto/instagram2.git
cd instagram2
pod install
open instagram2.xcworkspace
```

Configure your Parse application ID and client key in `AppDelegate.swift` before building.

## Demo

![Demo](https://imgur.com/sMOCL05.gif)
