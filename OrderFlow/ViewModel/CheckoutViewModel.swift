import Foundation

extension CheckoutView {
    @Observable
    final class ViewModel {
        let order: Order
        let orderPlacer: OrderPlacing
        var confirmationMessage = ""
        var orderWasPlaced = false

        init(order: Order, orderPlacer: OrderPlacing = NetworkManager()) {
            self.order = order
            self.orderPlacer = orderPlacer
        }

        func placeOrder() async {
            do {
                let finalOrder = try await orderPlacer.placeOrder(order: order)
                confirmationMessage = "Your order for \(finalOrder.quantity)x \(finalOrder.type.rawValue) cupcakes is on its way!"
                orderWasPlaced = true
            } catch {
                confirmationMessage = error.localizedDescription
                orderWasPlaced = false
            }
        }
    }
}
