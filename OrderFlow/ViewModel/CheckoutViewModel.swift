import Foundation

extension CheckoutView {
    @Observable
    final class ViewModel {
        var orderState: OrderPlacementState = .idle
        var showingConfirmation = false
        let order: Order
        let orderPlacer: OrderPlacing

        init(order: Order, orderPlacer: OrderPlacing = NetworkManager()) {
            self.order = order
            self.orderPlacer = orderPlacer
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
                let finalOrder = try await orderPlacer.placeOrder(order: order)
                orderState = .placed(message: "Your order for \(finalOrder.quantity)x \(finalOrder.type.rawValue) cupcakes is on its way!")
            } catch {
                orderState = .failed(message: "Failed to proceed the order: \(error.localizedDescription)")
            }
            showingConfirmation = true
        }
    }
}
