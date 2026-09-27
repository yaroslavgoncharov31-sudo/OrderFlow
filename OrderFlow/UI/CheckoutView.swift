import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var showingConfirmation = false
    @State private var isPlacingOrder = false
    @State private var viewModel: ViewModel

    @Binding var path: NavigationPath

    init(order: Order, path: Binding<NavigationPath>, orderPlacer: OrderPlacing = NetworkManager()) {
        self.order = order
        self._path = path
        self._viewModel = State(initialValue: ViewModel(order: order, orderPlacer: orderPlacer))
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
                if isPlacingOrder {
                    ProgressView()
                } else {
                    Button("Place order") {
                        isPlacingOrder = true
                        Task {
                            await placeOrder()
                        }
                    }
                    .disabled(isPlacingOrder)
                    .padding()
                }
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Order status", isPresented: $showingConfirmation) {
            Button("OK") {
                if viewModel.orderWasPlaced {
                    path = NavigationPath()
                    order.reset()
                }
            }
        } message: {
            Text(viewModel.confirmationMessage)
        }
    }
    private func placeOrder() async {
        isPlacingOrder = true
        defer { isPlacingOrder = false }

        do {
            let finalOrder = try await viewModel.orderPlacer.placeOrder(order: order)
            viewModel.confirmationMessage = "Your order for \(finalOrder.quantity)x \(finalOrder.type.rawValue) cupcakes is on its way!"
            viewModel.orderWasPlaced = true
        } catch {
            viewModel.confirmationMessage = error.localizedDescription
            viewModel.orderWasPlaced = false
        }
        showingConfirmation = true
    }
}

#if DEBUG
struct PreviewOrderPlacing: OrderPlacing {
    var shouldFail = false
    func placeOrder(order: Order) async throws -> Order {
        if shouldFail {
            throw NetworkingErrors.serverError(statusCode: 500)
        }
        return order
    }
}
#endif

#Preview("Success") {
    @Previewable @State var path = NavigationPath()
    CheckoutView(order: Order(), path: $path, orderPlacer: PreviewOrderPlacing(shouldFail: false))
}

#Preview("Failure") {
    @Previewable @State var path = NavigationPath()
    CheckoutView(order: Order(), path: $path, orderPlacer: PreviewOrderPlacing(shouldFail: true))
}
