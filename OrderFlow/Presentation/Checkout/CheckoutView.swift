import SwiftUI

struct CheckoutView: View {
    var order: Order
    var deliveryDetails: DeliveryDetails
    var onOrderPlaced: () -> Void
    @State private var viewModel: ViewModel

    @Environment(\.coordinator) private var coordinator

    init(order: Order, deliveryDetails: DeliveryDetails, placeOrderUseCase: PlaceOrderUseCase, onOrderPlaced: @escaping () -> Void) {
        self.order = order
        self.deliveryDetails = deliveryDetails
        self._viewModel = State(initialValue: ViewModel(order: order, placeOrderUseCase: placeOrderUseCase, deliveryDetails: deliveryDetails))
        self.onOrderPlaced = onOrderPlaced
    }

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total cost is: \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                if viewModel.orderState == .placing {
                    ProgressView()
                } else {
                    Button("Place order") {
                        Task {
                            await viewModel.placeOrder()
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Order status", isPresented: $viewModel.showingConfirmation) {
            Button("OK") {
                if case .placed = viewModel.orderState {
                    coordinator.popToRoot()
                    onOrderPlaced()
                }
                viewModel.orderState = .idle
            }
        } message: {
            Text(viewModel.resultMessage)
        }
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    let repo = PreviewOrderRepository()
    let useCase = PlaceOrderUseCase(repository: repo)
    let order = Order()
    let details = DeliveryDetails()
    CheckoutView(order: order, deliveryDetails: details, placeOrderUseCase: useCase, onOrderPlaced: {} )
}
