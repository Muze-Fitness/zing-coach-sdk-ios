# ZingCoach SDK

AI-powered fitness coach SDK for iOS.

## Requirements

- iOS 16.0+
- Swift 5.10+

## Installation

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Muze-Fitness/zing-coach-sdk-ios.git", from: "1.0.0")
]
```

Then add `ZingCoachSDK` to your target's dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: ["ZingCoachSDK"]
)
```

## Authentication

Private Swift Package binary targets require GitHub API authentication.

Add to `~/.netrc`:
```bash
machine api.github.com
login YOUR_GITHUB_USERNAME
password YOUR_GITHUB_TOKEN
```

Token requirements: Classic PAT with `repo` scope.

Set permissions: `chmod 600 ~/.netrc`

## Quick Start

### 1. Initialize the SDK

```swift
import PublicSDK

class CoachService: ObservableObject {
    @Published var sdk: SDK?
    @Published var isInitialized = false

    func initialize(apiKey: String) async {
        let result = await SDK.initialize(with: .init(apiKey: apiKey))

        switch result {
        case .success(let sdk):
            self.sdk = sdk
            self.isInitialized = true
        case .failure(let error):
            print("SDK initialization failed: \(error)")
        }
    }
}
```

### 2. Present SDK Modules

All SDK modules return `UIViewController`. Present them modally or embed in your navigation:

```swift
// Custom Workout Builder
let customWorkoutVC = sdk.makeCustomWorkoutModule()
present(customWorkoutVC, animated: true)

// Training Program
let programVC = sdk.makeProgramModule()
present(programVC, animated: true)

// AI Chat Assistant
let chatVC = sdk.makeAssistantChat()
present(chatVC, animated: true)
```
