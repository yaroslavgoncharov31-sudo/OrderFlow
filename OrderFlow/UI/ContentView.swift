import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentView.ViewModel()

    var body: some View {
        NavigationStack(path: $viewModel.path) {
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
                    Button("Adress details") {
                        viewModel.path.append(Route.addressView)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .addressView:
                    AddressView(order: viewModel.order, path: $viewModel.path)
                case .checkoutView:
                    CheckoutView(order: viewModel.order, path: $viewModel.path)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
