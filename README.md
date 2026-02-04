# ZingCoach SDK

Native iOS SDK that integrates the Zing Fitness experience.

## Requirements

| Requirement | Value / Notes |
|-------------|---------------|
| iOS version | 16.0+ |
| Swift Package Manager | 5.10+ |

### 1. Setup

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Muze-Fitness/zing-coach-sdk-ios.git", from: "1.0.1")
]
```

Then add `ZingCoachSDK` to your target's dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: ["ZingCoachSDK"]
)
```

### 2. Initialization

The SDK instance owns internal state and resources. Releasing it deallocates internal state and interrupts background sync.

```swift
let result = await ZingSDK.initialize(
    with: .init(
        authentication: .serverSide(provider: self),
        errorHandler: self
    )
)

switch result {
case .success(let sdk):
    zingSDK = sdk  // Retain at app-level scope
case .failure(let error):
    print("Initialization failed: \(error)")
}
```

### 3. Authentication

#### Server-Side Authentication

Use this mode when your backend manages user authentication and issues JWT tokens.

**Token Requirements:**
- Valid JWT format
- Must contain `sub` claim with the partner user ID
- Recommended token lifetime: 15 minutes

```swift
let result = await ZingSDK.initialize(
    with: .init(
        authentication: .serverSide(provider: self),
        errorHandler: self
    )
)

switch result {
case .success(let sdk):
    self.sdk = sdk
    sdk.login()
case .failure(let error):
    print("Initialization failed: \(error)")
}

// Example implementation of the AuthProvider protocol
extension YourAuthProvider: ZingSDK.AuthProvider {
    func didRequestAuthToken() async -> Result<String, Error> {
        // Fetch JWT token from your authentication server
        // The token must contain a "sub" claim with the user ID
        let token = try await yourAuthService.getToken()
        return .success(token)
    }
}

// Example implementation of the ErrorHandler protocol
extension YourErrorHandler: ZingSDK.ErrorHandler {
    func didReceiveError(_ error: ZingSDK.Error) {
        print("SDK error: \(error)")
    }
}
```

```swift
extension ZingSDK {
    enum Error: Swift.Error {
        case authError(AuthError)
        case loginError(LoginError)
    }

    enum AuthError: Swift.Error {
        /// The partner user ID in the new token does not match the previously authenticated user.
        /// This prevents unintended user switching during token refresh.
        case partnerIDMismatch
        /// The token is invalid: either malformed JWT structure or missing required "sub" claim.
        case badToken
        /// The external authentication provider returned an error (e.g., network failure, invalid credentials).
        case externalError(Swift.Error)
    }

    enum LoginError: Swift.Error {
        /// Login was attempted while a user is already authenticated.
        case alreadyLoggedIn
        /// Login was attempted while another login operation is in progress.
        case loginAlreadyInProgress
        /// Logout was attempted when no user is currently logged in.
        case notLoggedIn
        /// Token retrieval failed during the login process.
        /// The underlying cause may be a badToken, partnerIDMismatch, or externalError.
        case failedToGetToken
        /// Profile synchronization failed after successful token retrieval.
        /// This typically indicates a network error when fetching user profile data.
        case failedToGetProfile
    }
}
```

#### Guest Authentication

Use this mode for testing or when backend integration is not available:

```swift
let result = await ZingSDK.initialize(
    with: .init(
        authentication: .guest(apiKey: "your-api-key"),
        errorHandler: errorHandler
    )
)
```

#### Login

After successful SDK initialization, call `login()` to authenticate the user and start a session:

```swift
sdk.login()
```

The SDK will request a token from your `AuthProvider` and establish the user session. Login errors are delivered through your `ErrorHandler`.

#### Logout

Call `logout()` when your user signs out of your app:

```swift
sdk.logout()
```

This clears the user session and stops background sync. You can call `login()` again to start a new session.

### 4. Present SDK Modules

All SDK modules return `UIViewController`. Present them modally or embed in your navigation:

```swift
// Custom Workout Builder
let customWorkoutVC = sdk.makeCustomWorkoutModule()
present(customWorkoutVC, animated: true)

// Training Program
let programVC = sdk.makeProgramModule()
present(programVC, animated: true)

// Workout Preview/Player
// Use a ZingSDK.Workout instance obtained from CustomWorkoutDelegate
let previewVC = sdk.makeWorkoutPreview(for: workout)
present(previewVC, animated: true)

// AI Assistant Chat
let assistantVC = sdk.makeAssistantChat()
present(assistantVC, animated: true)
```

### 5. Handle Custom Workout Creation (Optional)

```swift
class WorkoutDelegate: ZingSDK.CustomWorkoutDelegate {
    func didCreateWorkout(_ workout: ZingSDK.Workout) {
        print("User created workout: \(workout.id)")
    }
}

let delegate = WorkoutDelegate()
let customWorkoutVC = sdk.makeCustomWorkoutModule(delegate)
```
