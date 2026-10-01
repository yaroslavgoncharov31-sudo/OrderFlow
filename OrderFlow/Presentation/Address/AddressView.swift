import SwiftUI

struct AddressView: View {
    @Environment(\.coordinator) private var coordinator
    @Binding var deliveryDetails: DeliveryDetails
    let store: DeliveryDetailsStore

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $deliveryDetails.name)
                TextField("Street address", text: $deliveryDetails.streetAddress)
                TextField("City", text: $deliveryDetails.city)
                TextField("Zip", text: $deliveryDetails.zip)
                TextField("Email", text: $deliveryDetails.email)
            }
            Section {
                Button("Proceed to checkout") {
                    try? store.save(deliveryDetails: deliveryDetails)
                    coordinator.showCheckout()
                }
            }
            .disabled(deliveryDetails.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var deliveryDetails = DeliveryDetails()
    @Previewable @State var store = DeliveryDetailsStore.self
    AddressView(deliveryDetails: $deliveryDetails, store: store as! DeliveryDetailsStore)
}
