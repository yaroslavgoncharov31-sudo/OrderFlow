import SwiftUI

struct ContentView: View {
    var placeOrderUseCase: PlaceOrderUseCase
    var deliveryDetailsStore: DeliveryDetailsStore
    @State private var viewModel: ContentView.ViewModel
    @Environment(\.coordinator) var coordinator


    init(placeOrderUseCase: PlaceOrderUseCase, deliveryDetailsStore: DeliveryDetailsStore) {
        self.placeOrderUseCase = placeOrderUseCase
        self.deliveryDetailsStore = deliveryDetailsStore
        self._viewModel = State(initialValue: ViewModel(store: deliveryDetailsStore))
    }
    var body: some View {
        @Bindable var coordinator = coordinator
        NavigationStack(path: $coordinator.path) {
            Form {
                Section {
                    Picker("Select your cake type", selection: $viewModel.order.type) {
                        ForEach(CupcakeType.allCases, id: \.self) { flavour in
                            Text(flavour.rawValue)
                                .tag(flavour)
                        }
                    }
                    Stepper("Number of cakes: \(viewModel.order.quantity)", value: $viewModel.order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $viewModel.order.specialRequestEnabled.animation())

                    if viewModel.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn:  $viewModel.order.extraFrosting.animation())

                        Toggle("Add extra sprinkles", isOn:  $viewModel.order.addSprinkles.animation())
                    }
                }
                Section {
                    Button("Address details") {
                        coordinator.showAddress()
                    }
                }
            }
            .navigationTitle("OrderFlow")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .addressView:
                    AddressView(deliveryDetails: $viewModel.deliveryDetails, store: deliveryDetailsStore)
                case .checkoutView:
                    CheckoutView(
                        order: viewModel.order,
                        deliveryDetails: viewModel.deliveryDetails,
                        placeOrderUseCase: placeOrderUseCase,
                        onOrderPlaced: { viewModel.reset() }
                    )
                }
            }
        }
    }
}

#if DEBUG
struct PreviewOrderRepository: OrderRepository {
    func placeOrder(order: Order, deliveryDetails: DeliveryDetails) async throws -> Order {
        order
    }
}
#endif
#Preview {
    let repo = PreviewOrderRepository()
    let useCase = PlaceOrderUseCase(repository: repo)
    let store = FileDeliveryDetailsStore()
    ContentView(placeOrderUseCase: useCase, deliveryDetailsStore: store)
}
