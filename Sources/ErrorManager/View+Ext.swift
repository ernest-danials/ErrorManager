//
//  View+Ext.swift
//  ErrorManager
//
//  Created by Myung Joon Kang on 2025-04-03.
//

import SwiftUI

public extension View {
    /// Sets up a SwiftUI alert to automatically present errors managed by the given `ErrorManager`.
    ///
    /// This function returns a modified view that displays an alert when `manager.isShowingError` is true.
    /// The alert shows the `localizedDescription` of `manager.currentError`, and resets the error state when dismissed.
    ///
    /// - Parameter manager: An instance of `ErrorManager` that controls when and which error is shown.
    /// - Returns: A view that includes automatic error alert presentation.
    func setUpForErrorPresentation(using manager: ErrorManager) -> some View {
        self
            .alert("Error", isPresented: Binding(
                get: { manager.isShowingError },
                set: { newValue in
                    if !newValue { manager.hideError() }
                })
            ) {
                Button("OK", role: .cancel) {
                    manager.hideError()
                }
            } message: {
                Text(manager.currentError?.localizedDescription ?? "Unknown error has occurred.")
            }
    }
}
