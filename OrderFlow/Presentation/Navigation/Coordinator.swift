import Foundation
import SwiftUI

private struct AppCoordinatorKey: EnvironmentKey {
    static let defaultValue = AppCoordinator()
}

extension EnvironmentValues {
    var coordinator: AppCoordinator {
        get { self[AppCoordinatorKey.self] }
        set { self[AppCoordinatorKey.self] = newValue }
    }
}

@Observable
final class AppCoordinator {
    var path = NavigationPath()

    func showAddress() {
        path.append(Route.addressView)
    }

    func showCheckout() {
        path.append(Route.checkoutView)
    }

    func popToRoot() {
        path = NavigationPath()
    }
}
