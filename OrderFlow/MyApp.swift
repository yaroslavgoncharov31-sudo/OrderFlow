import SwiftUI

@main struct MyApp: App {
    let placeOrderUseCase: PlaceOrderUseCase
    let coordinator = AppCoordinator()
    let deliveryDetailsStore: DeliveryDetailsStore

    init() {
        let repository = OrderRepositoryImpl()
        placeOrderUseCase = PlaceOrderUseCase(repository: repository)
        deliveryDetailsStore = FileDeliveryDetailsStore()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(placeOrderUseCase: placeOrderUseCase, deliveryDetailsStore: deliveryDetailsStore)
                .environment(\.coordinator, coordinator)
        }
    }
}
