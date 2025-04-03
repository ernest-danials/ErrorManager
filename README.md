<div align="center">
  <h1><b>ErrorManager</b></h1>
  <p>
    A simple SwiftUI error management tool.
    <br>
    <i>Compatible with iOS 15.0 and later, macOS 12.0 and later</i>
  </p>
</div>

<div align="center">
  <a href="https://swift.org">
    <img src="https://img.shields.io/badge/Swift-5.9%20%7C%206-orange.svg" alt="Swift Version">
  </a>
  <a href="https://www.apple.com/ios/">
    <img src="https://img.shields.io/badge/iOS-15%2B-blue.svg" alt="iOS">
  </a>
  <a href="https://www.apple.com/macos/">
    <img src="https://img.shields.io/badge/macOS-12%2B-blue.svg" alt="macOS">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT">
  </a>
</div>

---

## **Overview**

`ErrorManager` is a error management tool for SwiftUI apps that helps you manage and control error presentation globally. `ErrorManager` offers a readable and user-friendly way to handle errors.

---

## **Installation**

### Swift Package Manager

1. In Xcode, navigate to **File > Add Packages...**
2. Enter the repository URL:  
   `https://github.com/ernest-danials/ErrorManager`
3. Follow the prompts to add the package to your project.

---


## **Usage**

Below are some examples of how you can utilise `ErrorManager`.

### **Setup**
Inject ErrorManager using `@StateObject` and `EnvironmentObject`.
```swift
import SwiftUI

@main
struct YourApp: App {
    @StateObject var errorManager = ErrorManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(errorManager)
        }
    }
}
```

Setup appropriate error presentation using the modifier.
```swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .setUpForErrorPresentation(using: errorManager)
    }
}
```

### **Presenting Error**
You can present an error after the setup like below. The error you are trying to show must conform to `LocalizedError` protocol. `ErrorManager` will automatically present an error using the `LocalizedDescription` (if nil, it will show "Unknown error has occured.").
```swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onAppear {
                    errorManager.showError(ContentViewError.exampleError)
                }
        }
        .setUpForErrorPresentation(using: errorManager)
    }
}

enum ContentViewError: LocalizedError {
    case exampleError
    
    var localizedDescription: String? {
        switch self {
        case .exampleError:
            return "This is an example error."
        }
    }
}
```

## **License**

ErrorManager is available under the MIT license. See the [LICENSE](LICENSE) file for more information.
