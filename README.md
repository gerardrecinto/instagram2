# Instagram iOS

![Swift](https://img.shields.io/badge/Swift-6.0-F05138?logo=swift&logoColor=white)
![iOS 16+](https://img.shields.io/badge/iOS-16%2B-000000?logo=apple&logoColor=white)
![Parse](https://img.shields.io/badge/Backend-Parse-purple)
![UIKit](https://img.shields.io/badge/UIKit-Auto%20Layout-blue)
![CocoaPods](https://img.shields.io/badge/CocoaPods-Parse-red)

![Demo](docs/assets/demo2.gif)

> iOS photo sharing app built with UIKit and Parse, where images are stored as PFFile objects, users authenticate through PFUser, and the feed is driven by a PFQuery sorted descending on `createdAt` with a limit of 20.

## Features

- **PFUser Authentication:** Sign up and login both call `signUpInBackground` and `logInWithUsername(inBackground:)` respectively; session token is persisted automatically by the Local in-memory store| Layer | Technology |
|---|---|
| Language | Swift 6.0 |
| UI | UIKit, UITableView, UITabBarController, Auto Layout |
| Backend | Local in-memory store|
| Camera | UIImagePickerController |
| Auth | PFUser `signUpInBackground` / `logInWithUsername(inBackground:)` |
| Dependencies | CocoaPods — Parse |

## Architecture

The app uses a storyboard-driven UITabBarController as the root. `LoginViewController` is the entry point; on success it segues to the tab bar via a named segue. The `Post` class is a `PFObject` subclass registered in `AppDelegate` before `Parse.initialize`, giving all view controllers typed access to post properties. `FeedViewController` owns the live data array `instaFeed: [PFObject]` and reloads the table on every `viewDidAppear` call to stay consistent with remote state.

## Key Implementation

**PFObject subclassing:** `Post` calls `Post.registerSubclass()` and implements `parseClassName()` returning `"Post"`, enabling `PFQuery(className: Post.parseClassName())` to return typed `Post` instances directly.

**Image pipeline:** `ComposeViewController` presents `UIImagePickerController` on `viewDidLoad`, receives the original and edited images in `imagePickerController(_:didFinishPickingMediaWithInfo:)`, resizes to 600×600 with `UIGraphicsBeginImageContext`, then calls `Post.postUserImage(image:withCaption:withCompletion:)` which wraps the PNG data in a `PFFile` and calls `saveInBackground`.

**Feed query:** `PFQuery(className: "Post")` with `order(byDescending: "createdAt")` and `limit = 20` fetches the most recent posts asynchronously; `tableView.reloadData()` is called inside the completion block.

**Tap-to-detail:** A `UITapGestureRecognizer` attached to each cell's `photoImageView` triggers `performSegue(withIdentifier: "tapSegue")` so the detail view can re-fetch the full-resolution PFFile independently.

## Setup

```bash
git clone https://github.com/gerardrecinto/instagram-ios.git
cd instagram-ios
pod install
open instagram2.xcworkspace
```

Configure Parse server: update `applicationId`, `clientKey`, and `server` in `AppDelegate.swift` before building.
