//
//  File.swift
//  CordinatorKit
//
//  Created by Felipe Rezende on 29/09/25.
//

import Foundation
import SwiftUI

///A protocol that represents a modal view in your app
///
///You **must** create your own FullScreenCover type
///that conforms to this protocol and implements 'build() -> View'
///
/// Example:
/// ```swift
///enum FullScreenCover: CoordinatorFull {
///    case profile(username: String)
///    case onboarding
///
///    var id: String {
///        switch self {
///        case .profile(let username): return "sheet.profile.\(username)"
///        case .onboarding: return "full.onboarding"
///        }
///    }
///
///    func build() -> some View {
///        switch self {
///        case .profile(let username):
///            ProfileView(username: username)
///        }
///    }
///}
/// ```
public protocol CoordinatorFull: Hashable, Identifiable {
    associatedtype FullScreenView: View
    
    ///Builds the corresponding 'View' for this screen
    @ViewBuilder func build() -> FullScreenView
}
