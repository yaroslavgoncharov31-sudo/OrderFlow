internal import Testing
@testable import OrderFlow

@MainActor
struct NetworkTests {

    private(set) var details = DeliveryDetails(
        name: "TestName",
        streetAddress: "TestAddress",
        zip: "1111111",
        city: "TestCity",
        email: "example@mail.com"
    )

    private(set) var order = Order()
    @Test func placeOrder_success_setConfirmation() async throws {
        let repo = MockOrderRepository(behavior: .success(order))
        let useCase = PlaceOrderUseCase(repository: repo)
        let viewModel = CheckoutView.ViewModel(order: order, placeOrderUseCase: useCase, deliveryDetails: details)
        await viewModel.placeOrder()

        #expect(viewModel.orderState == .placed(message: "Your order for 3x Chocolate cupcakes is on its way!"))
        #expect(viewModel.showingConfirmation == true)
    }

    @Test func placeOrder_serverError_setsFailureMessage() async throws {
        let repo = MockOrderRepository(behavior: .failure(NetworkingErrors.serverError(statusCode: 500)))
        let useCase = PlaceOrderUseCase(repository: repo)
        let viewModel = CheckoutView.ViewModel(order: order, placeOrderUseCase: useCase, deliveryDetails: details)
        await viewModel.placeOrder()

        #expect(viewModel.orderState == .failed(message: "Failed to proceed the order: Server error (500). Please try again later."))
        #expect(viewModel.showingConfirmation == true)
    }

    @Test func guardDoubleTap_orderPlacing() async throws {
        let mock = CountingOrderRepository()
        let useCase = PlaceOrderUseCase(repository: mock)
        let viewModel = CheckoutView.ViewModel(order: order, placeOrderUseCase: useCase, deliveryDetails: details)

        async let first = viewModel.placeOrder()
        try await Task.sleep(for: .milliseconds(10))
        async let second = viewModel.placeOrder()

        mock.resume()
        _ = await (first, second)

        #expect(mock.callCount == 1)
    }
}
