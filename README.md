# Instagram iOS

![Swift](https://img.shields.io/badge/Swift-3%2B-F05138?logo=swift&logoColor=white)
![iOS 9+](https://img.shields.io/badge/iOS-9%2B-000000?logo=apple&logoColor=white)
![Parse](https://img.shields.io/badge/Backend-Parse-purple)
![UIKit](https://img.shields.io/badge/UIKit-Auto%20Layout-blue)
![CocoaPods](https://img.shields.io/badge/CocoaPods-Parse-red)

![Demo](docs/assets/demo2.gif)

> iOS photo sharing app built with UIKit and Parse, where images are stored as PFFile objects, users authenticate through PFUser, and the feed is driven by a PFQuery sorted descending on `createdAt` with a limit of 20.

## Features

- **PFUser Authentication:** Sign up and login both call `signUpInBackground` and `logInWithUsername(inBackground:)` respectively; session token is persisted automatically by the Parse SDK across launches.
- **PFObject Subclassing:** `Post` conforms to `PFSubclassing` with `@NSManaged` properties for `media` (PFFile), `author` (PFUser pointer), `caption` (String), `likesCount` (Int), and `timestamp` (Date) — typed access without string key lookups.
- **PFFile Image Upload:** `UIImagePickerController` captures camera or photo library input; the selected `UIImage` is converted to PNG data via `UIImagePNGRepresentation` and wrapped in a `PFFile` before `saveInBackground` is called on the Post object.
- **Image Resizing Before Upload:** `ComposeViewController` scales the captured image to 600×600 using `UIGraphicsBeginImageContext` and `scaleAspectFill` before uploading, keeping Parse file storage predictable.
- **Feed via UITableView:** `FeedViewController` conforms to `UITableViewDataSource` and `UITableViewDelegate`; `viewDidAppear` fires the Parse query on each visit so the feed reflects any new posts immediately.
- **Async Image Loading:** Each `InstaPostCell` calls `photo.getDataInBackground` on the `PFFile`; the cell's `UIImageView` is updated on the main queue when data returns.
- **Post Detail View:** Tapping a cell presents `PostDetailViewController`, which reads the `PFFile` again via `getDataInBackground` and displays the caption and `timestamp` Date formatted with `description(with:)`.
- **Tab Bar Navigation:** A `UITabBarController` links the feed, compose, profile, and settings screens; after a successful upload `ComposeViewController` sets `tabBarController?.selectedIndex = 0` to return to the feed.

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift 3 |
| UI | UIKit, UITableView, UITabBarController, Auto Layout |
| Backend | Parse SDK (PFObject, PFUser, PFFile, PFQuery) |
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
