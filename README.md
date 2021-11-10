# TwitterSentiment

[![Build Status](https://app.bitrise.io/app/1acd1fc4d0fe46dc/status.svg?token=utCTDlvxwMbPO3Yb3oOTaA&branch=main)](https://app.bitrise.io/app/1acd1fc4d0fe46dc)
[![codecov](https://codecov.io/gh/ciceroduarte/TwitterSentimentAnalysis/branch/main/graph/badge.svg?token=Tjwx4An7KE)](https://codecov.io/gh/ciceroduarte/TwitterSentimentAnalysis)

## Requirements

- Xcode 13.1+
- [CocoaPods](http://cocoapods.org/)

## Libraries

- [Kingfisher](https://github.com/onevcat/Kingfisher) for downloading and caching images
- [SwiftLint](https://github.com/realm/SwiftLint) for code static analysis

## Usage

- Create an app at [Twitter Developers Portal](http://developer.marvel.com)
- Create an API key for [Google Natural Language](https://cloud.google.com/natural-language/)
- Update `AppSettings.swift` with your keys

```swift
struct AppSettings {
    static let twitterKey = ""
    static let googleKey = ""
```

- Run `pod install` from the `TwitterSentimentAnalysis` directory
