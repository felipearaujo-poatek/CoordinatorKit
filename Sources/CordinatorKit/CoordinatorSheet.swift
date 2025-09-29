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
///You **must** create your own Sheet type
///that conforms to this protocol and implements 'build() -> View'
///
/// Example:
/// ```swift
///enum Sheet: CoordinatorSheet {
///    case profile(username: String)
///
///    var id: String {
///        switch self {
///        case .profile(let username): return "sheet.profile.\(username)"
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
public protocol CoordinatorSheet: Hashable, Identifiable {
    associatedtype SheetView: View
    
    ///Builds the corresponding 'View' for this screen
    @ViewBuilder func build() -> SheetView
}
