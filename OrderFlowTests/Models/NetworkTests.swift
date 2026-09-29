internal import Testing
@testable import OrderFlow

@MainActor
struct NetworkTests {

    let mockOrder = Order()

    @Test func placeOrder_success_setConfirmation() async throws {
        let viewModel = CheckoutView.ViewModel(order: Order(), orderPlacer: MockNetworkManager(behavior: .success(mockOrder)))
        await viewModel.placeOrder()

        #expect(viewModel.orderState == .placed(message: "Your order for 3x Chocolate cupcakes is on its way!"))
        #expect(viewModel.showingConfirmation == true)
    }

    @Test func placeOrder_serverError_setsFailureMessage() async throws {
        let viewModel = CheckoutView.ViewModel(order: Order(), orderPlacer: MockNetworkManager(behavior: .failure(NetworkingErrors.serverError(statusCode: 500))))
        await viewModel.placeOrder()

        #expect(viewModel.orderState == .failed(message: "Failed to proceed the order: Server error (500). Please try again later."))
        #expect(viewModel.showingConfirmation == true)
    }

    @Test func guardDoubleTap_orderPlacing() async throws {
        let mock = CountingNetworkManager()
        let viewModel = CheckoutView.ViewModel(order: mockOrder, orderPlacer: mock)

        async let first = viewModel.placeOrder()
        try await Task.sleep(for: .milliseconds(10))
        async let second = viewModel.placeOrder()

        mock.resume()
        _ = await (first, second)

        #expect(await mock.callCount == 1)
    }
}
