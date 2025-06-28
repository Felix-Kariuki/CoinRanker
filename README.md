
# CoinRanker 

Take Home assessment

An iOS application that fetches data from the [CoinRanking](https://developers.coinranking.com/api/documentation) API and displays a list of the top 100
cryptocurrency coins paginated, showing 20 characters per page.
Written using SwiftUI and UIKit.


# 📷 Screenshots
#### Features

| Coin List (Light) | Coin List (Dark) | Filter (Light) |
|:------------------:|:------------------:|:------------------:|
| <img src="./Screenshots/coin_list_light.png" width="300"> | <img src="./Screenshots/coin_list_dark.png" width="300"> | <img src="./Screenshots/filter_light.png" width="300"> |

| Filter (Dark) | List (Light) | List (Dark) |
|:------------------:|:------------------:|:------------------:|
| <img src="./Screenshots/filter_dark.png" width="300"> | <img src="./Screenshots/list_light.png" width="300"> | <img src="./Screenshots/list_dark.png" width="300"> |

| Details (Light) | Details (Dark) | Favorites (Light) | Favorites (Dark) |
|:------------------:|:------------------:|:------------------:|:------------------:|
| <img src="./Screenshots/details_light.png" width="200"> | <img src="./Screenshots/details_dark.png" width="200"> | <img src="./Screenshots/fav_light.png" width="240"> | <img src="./Screenshots/fav_dark.png" width="240"> |



#### Testing

- Unit tests for Networking service
- UI Integration Tests 

| Tests |
|:----------------:|
| <img src="./Screenshots/test_case.png" width="300"> |




## 📊 Features

### 📅 Screen 1: Top 100 Coins List

- Display of the **top 100 coins** with pagination (20 coins at a time)
- Each list item includes:
  - Coin **icon**
  - Coin **name**
  - Current **price**
  - 24-hour performance
- **Filter Options**:
  - Sort by **highest price**
  - Sort by **best 24-hour performance**
- Swipe left to **favorite** or **unfavorite** a coin

### 📈 Screen 2: Coin Details View

- Coin **name**
- **Interactive performance chart** with chart filters
- **price**,
- Additional statistics

### ⭐️ Screen 3: Favorites Screen

- View all **favorited coins** 
- Tap to access full **coin details**
- Swipe to **unfavorite** directly from the list

### Implementation 
**UIKit**- Coins Table Header View

**SwiftUI** -  Coin Item && Coin Details View (Chart)

## 🚀 Getting Started

Clone project and in the `Info.plist`, add the Api key

```
<key>COIN_API_KEY</key>
<string>Api key here</string>
```
You can generate a free API_KEY [Here](https://developers.coinranking.com/api/documentation) if you don't have one

You're are good to go 🥳 Build to run

## TechStack 🛠️
- [Swift](https://developer.apple.com/swift/) - Swift is a powerful and intuitive programming language for all Apple platforms. It’s easy to get started using Swift, with a concise yet expressive syntax and modern features you’ll love. Swift code is safe by design and produces software that runs lightning-fast.
- [SwiftUI](https://developer.apple.com/documentation/swiftui/) - SwiftUI provides views, controls, and layout structures for declaring your app’s user interface. The framework provides event handlers for delivering taps, gestures, and other types of input to your app, and tools to manage the flow of data from your app’s models down to the views and controls that users see and interact with
- [URLSession](https://developer.apple.com/documentation/foundation/urlsession) - Powerful Netwoking tool
- [SwiftCharts](https://developer.apple.com/documentation/charts) - Swift Charts is a powerful and concise SwiftUI framework you can use to transform your data into informative visualizations. 
- [UIKit](https://developer.apple.com/documentation/uikit) - UIKit provides a variety of features for building apps, including components you can use to construct the core infrastructure of your iOS, iPadOS, or tvOS apps. The framework provides the window and view architecture for implementing your UI, the event-handling infrastructure for delivering Multi-Touch and other types of input to your app, and the main run loop for managing interactions between the user, the system, and your app.
- [Combine](https://developer.apple.com/documentation/combine) - The Combine framework provides a declarative Swift API for processing values over time. These values can represent many kinds of asynchronous events
- [SwiftData](https://developer.apple.com/documentation/combine) - SwiftData offers an expressive and lightweight API for modeling and persisting your app's data using pure Swift code



## 👨🏾‍💻 Author

- [Felix-Karuki](https://www.github.com/Felix-Kariuki)

## 📧 Reach Out 

  * [Twitter](https://twitter.com/felixkariuki_)

  * [LinkedIn](https://www.linkedin.com/in/felix-kariuki/)
