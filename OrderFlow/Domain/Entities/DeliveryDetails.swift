import Foundation

struct DeliveryDetails: Equatable {
    var name = ""
    var streetAddress = ""
    var zip = ""
    var city = ""
    var email = ""
    var hasValidAddress: Bool {
        [name, streetAddress, zip, city, email]
            .allSatisfy { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty } && email.contains("@") && zip.count <= 16
    }
}
