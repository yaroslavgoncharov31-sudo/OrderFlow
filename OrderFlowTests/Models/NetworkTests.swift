internal import Testing
@testable import OrderFlow

@MainActor
struct NetworkTests {

    let mockOrder = Order()

    @Test func placeOrder_success_setConfirmation() async throws {
        let viewModel = CheckoutView.ViewModel(order: Order(), orderPlacer: MockNetworkManager(behavior: .success(mockOrder)))
        await viewModel.placeOrder()

        #expect(viewModel.orderWasPlaced == true)
    }

    @Test func placeOrder_serverError_setsFailureMessage() async throws {
        let viewModel = CheckoutView.ViewModel(order: Order(), orderPlacer: MockNetworkManager(behavior: .failure(NetworkingErrors.serverError(statusCode: 500))))
        await viewModel.placeOrder()

        #expect(viewModel.orderWasPlaced == false)
    }

}
