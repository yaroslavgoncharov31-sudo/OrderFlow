import Foundation
import SwiftUI

extension ContentView {
    @Observable
    final class ViewModel {
        var order = Order()
        var path = NavigationPath()
    }
}
