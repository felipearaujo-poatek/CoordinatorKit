//
//  File.swift
//  CordinatorKit
//
//  Created by Felipe Rezende on 29/09/25.
//

import Foundation
import SwiftUI

///A generic Coordinator for SwiftUI that manages:
/// - Navigation via 'NavigationStack' (push/pop)
/// - Presentation/Dismiss of Sheets
/// - Presentation/Dismiss of full-screen covers
///
/// > **Important** You must define your own types:
/// 'Screen: CoordinatorScreen', 'Sheet: CoordinatorSheet', 'FullScreenCover: CoordinatorFull'.
@Observable
open class Coordinator<
    Screen: CoordinatorScreen,
    Sheet: CoordinatorSheet,
    FullScreenCover: CoordinatorFull
> {
    // MARK: - Navigation
    
    /// Navigation stack path (Screens).
    public var path = NavigationPath()
    
    // MARK: - Modals
    
    /// Currently active sheet (if any)
    public var sheet: Sheet?
    
    /// Currently active full-screen cover (if any)
    public var fullScreenCover: FullScreenCover?
    
    public init() {}
    
    // MARK: - Navigation
    
    /// Pushes a new screen onto the navigation stack.
    open func push(_ screen: Screen) { path.append(screen) }
    
    /// Removes the last screen from the stack (pop).
    open func pop() { if !path.isEmpty { path.removeLast() } }
    
    /// Clears the navigation stack and goes back to root.
    open func popToRoot() { path.removeLast(path.count) }
    
    // MARK: - Sheets
    
    /// Presents a sheet.
    open func presentSheet(_ sheet: Sheet) { self.sheet = sheet }
    
    /// Dismisses the current sheet.
    open func dismissSheet() { sheet = nil }
    
    // MARK: - Full-Screen Covers
    
    /// Presents a full-screen cover.
    open func presentFullScreenCover(_ full: FullScreenCover) {
        self.fullScreenCover = full
    }
    
    /// Dismisses the current full-screen cover.
    open func dismissFullScreenCover() { fullScreenCover = nil }
}
