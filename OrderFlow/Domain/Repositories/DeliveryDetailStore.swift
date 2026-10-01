import Foundation

protocol DeliveryDetailsStore {
    func save(deliveryDetails: DeliveryDetails) throws
    func load() throws -> DeliveryDetails?
}
