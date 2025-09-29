//
//  File.swift
//  CordinatorKit
//
//  Created by Felipe Rezende on 29/09/25.
//

import Foundation
import SwiftUI

///A protocol that represents a navigable screen in your app
///
///You **must** create your own Screen type
///that conforms to this protocol and implements 'build() -> View'
///
/// Example:
/// ```swift
/// enum Screen: CoordinatorScreen {
///     case profile
///     case detail(text: String) // Add parameters if needed
///
///     func build() -> some View {
///         switch self {
///         case .profile: ProfileView()
///         case .detail(let text): DetailView(text: text)
///         }
///     }
/// }
/// ```
public protocol CoordinatorScreen: Hashable {
    associatedtype ScreenView: View
    
    ///Builds the corresponding 'View' for this screen
    @ViewBuilder func build() -> ScreenView
}
