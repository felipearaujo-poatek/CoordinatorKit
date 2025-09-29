## **CoordinatorKit**

A lightweight, **type-safe Coordinator** for SwiftUI that centralizes navigation logic using **NavigationStack** (pages/push), **Sheets**, and **Full-Screen Covers**.  
No `AnyView`, no global singletons — each route knows how to build its own view.

> ⚠️ You **must** define your own types:
> - `Screen: CoordinatorScreen`
> - `Sheet: CoordinatorSheet`
> - `FullScreenCover: CoordinatorFull`

---

## ✨ Features

- **Type-safe** routes: each `Screen`, `Sheet`, and `Full` returns `some View` via `build()`.
- **Centralized navigation** with a generic `AppCoordinator`.
- **Simple API** for `push`, `pop`, `popToRoot`, `presentSheet`, `presentFullScreenCover`.
- Works great with **environment injection** and **modular feature flows**.

---

## 📦 Installation

**Xcode** → File ▸ Add Package Dependencies…  
Paste your repo URL (e.g., `https://github.com/felipearaujo-poatek/CoordinatorKit`) and select **Branch -> main**.

Or in your app’s `Package.swift`:
```swift
.package(url: "https://github.com/felipearaujo-poatek/CoordinatorKit", from: "1.0.0")
```

**Platforms**: iOS 17+  
**Swift**: 5.9+

---

## 🧠 Core Concepts

This package provides:
- `CoordinatorScreen`: protocol for push-style pages (`NavigationStack`).
- `CoordinatorSheet`: protocol for sheets (`.sheet(item:)`).
- `CoordinatorFull`: protocol for full-screen covers (`.fullScreenCover(item:)`).
- `AppCoordinator<Screen, Sheet, Full>`: generic, observable coordinator that holds the navigation state.

You define the enums for your app and implement `build()` in each case.

---

## 🚀 Quick Start

### 1) Define your types

```swift
import CoordinatorKit
import SwiftUI

// Pages (push/pop)
enum MyScreen: CoordinatorScreen {
    case home
    case detail(text: String)

    func build() -> some View {
        switch self {
        case .home:
            HomeView()
        case .detail(let text):
            DetailView(text: text)
        }
    }
}

// Sheet (modal)
enum MySheet: CoordinatorSheet {
    case profile(username: String)

    var id: String {
        switch self {
        case .profile(let username): return "sheet.profile.\(username)"
        }
    }

    func build() -> some View {
        switch self {
        case .profile(let username):
            ProfileView(username: username)
        }
    }
}

// Full-screen cover
enum MyFull: CoordinatorFull {
    case onboarding

    var id: String { "full.onboarding" }

    func build() -> some View {
        switch self {
        case .onboarding:
            OnboardingView()
        }
    }
}
```

### 2) Create your Coordinator

```swift
final class MyCoordinator: AppCoordinator<MyScreen, MySheet, MyFull> {}
```

### 3) Integrate in your root view

```swift
struct ContentView: View {
    @StateObject var coordinator = MyCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            MyScreen.home.build()
                .navigationDestination(for: MyScreen.self) { screen in
                    screen.build()
                }
        }
        .sheet(item: $coordinator.sheet) { sheet in
            sheet.build()
        }
        .fullScreenCover(item: $coordinator.fullScreenCover) { full in
            full.build()
        }
        .environmentObject(coordinator)
    }
}
```

### 4) Navigate inside your views

```swift
struct HomeView: View {
    @EnvironmentObject var coordinator: MyCoordinator

    var body: some View {
        VStack(spacing: 16) {
            Button("Go to Detail") {
                coordinator.push(.detail(text: "Hello from Home"))
            }
            Button("Show Profile Sheet") {
                coordinator.presentSheet(.profile(username: "felipe"))
            }
            Button("Show Onboarding") {
                coordinator.presentFullScreenCover(.onboarding)
            }
        }
        .padding()
        .navigationTitle("Home")
    }
}
```

---

## 🧩 Passing Parameters

Put parameters directly in your enum cases and forward them in `build()`:

```swift
enum ProductScreen: CoordinatorScreen {
    case details(id: UUID)

    func build() -> some View {
        switch self {
        case .details(let id):
            ProductDetailsView(productID: id)
        }
    }
}
```

Same idea for `CoordinatorSheet` and `CoordinatorFull`.


---

## 📄 API Overview

```swift
public protocol CoordinatorScreen: Hashable {
    associatedtype ScreenView: View
    @ViewBuilder func build() -> ScreenView
}

public protocol CoordinatorSheet: Identifiable, Hashable {
    associatedtype SheetView: View
    @ViewBuilder func build() -> SheetView
}

public protocol CoordinatorFull: Identifiable, Hashable {
    associatedtype FullScreenView: View
    @ViewBuilder func build() -> FullScreenView
}

@Observable
open class AppCoordinator<Screen: CoordinatorScreen, Sheet: CoordinatorSheet, Full: CoordinatorFull>{
    public var path: NavigationPath
    public var sheet: Sheet?
    public var fullScreenCover: Full?

    public init()

    // Pages
    open func push(_ screen: Screen)
    open func pop()
    open func popToRoot()

    // Modals
    open func presentSheet(_ sheet: Sheet)
    open func dismissSheet()
    open func presentFullScreenCover(_ full: Full)
    open func dismissFullScreenCover()
}
```

---

## 📜 License

This project is licensed under the **MIT License**.  
See the [`LICENSE`](./LICENSE) file for details.
