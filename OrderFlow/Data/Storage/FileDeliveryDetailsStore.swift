import Foundation

struct FileDeliveryDetailsStore: DeliveryDetailsStore {
    private let fileURL = URL.documentsDirectory.appending(path: "deliveryDetails.json")


    func save(deliveryDetails: DeliveryDetails) throws {
        let encoded = try JSONEncoder().encode(deliveryDetails)
        try encoded.write(to: fileURL)
    }

    func load() throws -> DeliveryDetails? {
        guard FileManager().fileExists(atPath: fileURL.path) else {
            return nil
        }
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode(DeliveryDetails.self, from: data)

    }
}
