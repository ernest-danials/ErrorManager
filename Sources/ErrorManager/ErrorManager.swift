//
//  ErrorManager.swift
//  ErrorManager
//
//  Created by Myung Joon Kang on 2025-04-03.
//


import Foundation

public final class ErrorManager: ObservableObject {
    public init() {}
    
    /// The currently shown error.
    @Published public var currentError: LocalizedError? = nil
    /// Whether ErrorManager is currently showing error.
    @Published public var isShowingError: Bool = false
    
    /// Shows an error to the user.
    ///
    /// This function supports any error that conforms to the `LocalizedError` protocol.
    /// It is recommended to explicitly convert a thrown error you wish to present to the expected error type; for instance, one of the common practices is:
    /// ```swift
    /// self.errorManager.showError(error as? CustomError ?? .unknownError)
    /// ```
    /// Having a default error case (for example, .unknownError in this case) is advisable.
    ///
    /// - Parameter error: the error to show.
    /// - Parameter shouldOverrideCurrentError: whether to override the current error. `true` by default.
    ///
    /// - Note: This function will override the current error by default. You can disable this by editing the corresponding parameter.
    /// - Important: Make sure to support appropriate error presentation. This function triggers an error, but it does not handle the actual presentation.
    @MainActor public func showError<E>(_ error: E, shouldOverrideCurrentError: Bool = true) where E: LocalizedError {
        if shouldOverrideCurrentError && self.currentError != nil && self.isShowingError {
            // Currently showing error and should override it.
            self.isShowingError = false
            self.currentError = error
            // This delay is to ensure proper overriding if an error is alreay present.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isShowingError = true
            }
        } else if !shouldOverrideCurrentError && self.currentError != nil && self.isShowingError {
            // Currently showing error but should not override it. Exiting function with no action.
            return
        } else if self.currentError == nil && !self.isShowingError {
            // Currently not showing error, regardless of shouldOverrideCurrentError value. Showing the error.
            currentError = error
            isShowingError = true
        } else {
            // Edge case (unknown current state; this may due to mismatch of the shownError value and the isShowingError value). Showing the error just in case.
            currentError = error
            isShowingError = true
            print("Unknown current state detected in ErrorManager.")
        }
    }
    
    /// Hides the currently shown error.
    ///
    /// - Note: This function will return early if `ErrorManager` is not currently showing error.
    @MainActor public func hideError() {
        guard self.currentError != nil && self.isShowingError else { return }
            
        self.isShowingError = false
        self.currentError = nil
    }
}
