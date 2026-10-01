import Foundation
import SwiftUI

extension ContentView {
    @Observable
    final class ViewModel {
        var order = Order()
        var deliveryDetails = DeliveryDetails()
        let store: DeliveryDetailsStore

        init(store: DeliveryDetailsStore) {
            self.store = store
            if let saved = try? store.load() {
                deliveryDetails = saved
            }
        }

        func reset() {
            order = Order()
            deliveryDetails = DeliveryDetails()
        }
    }
}
