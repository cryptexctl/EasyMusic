import SwiftUI

struct Station: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let streamURL: String
    let color: LinearGradient
}