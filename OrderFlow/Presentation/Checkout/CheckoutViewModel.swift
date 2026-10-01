import Foundation

extension CheckoutView {
    @Observable
    final class ViewModel {
        var orderState: OrderPlacementState = .idle
        var showingConfirmation = false
        let order: Order
        let placeOrderUseCase: PlaceOrderUseCase
        let deliveryDetails: DeliveryDetails

        init(order: Order, placeOrderUseCase: PlaceOrderUseCase, deliveryDetails: DeliveryDetails) {
            self.order = order
            self.placeOrderUseCase = placeOrderUseCase
            self.deliveryDetails = deliveryDetails
        }
        var resultMessage: String {
            switch orderState {
            case .placed(let message), .failed(let message): message
            default: ""
            }
        }

        func placeOrder() async {
            guard orderState != .placing else {
                return
            }
            orderState = .placing
            do {
                let finalOrder = try await placeOrderUseCase.execute(order: order, deliveryDetails: deliveryDetails)
                orderState = .placed(message: "Your order for \(finalOrder.quantity)x \(finalOrder.type.rawValue) cupcakes is on its way!")
            } catch {
                orderState = .failed(message: "Failed to proceed the order: \(error.localizedDescription)")
            }
            showingConfirmation = true
        }
    }
}
