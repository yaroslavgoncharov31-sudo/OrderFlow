import Foundation

struct OrderRepositoryImpl: OrderRepository {
    private let session: URLSession
    private let apiKey: String


    init(session: URLSession = .shared, apiKey: String = AppConfig.reqresAPIKey) {
        self.session = session
        self.apiKey = apiKey
    }

    func placeOrder(order: Order, deliveryDetails: DeliveryDetails) async throws -> Order {
        let dto = OrderMapper.toDTO(order: order, deliveryDetails: deliveryDetails)
        let encoded = try JSONEncoder().encode(dto)
        var request = URLRequest(url: URL(string: "https://reqres.in/api/cupcakes")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if !apiKey.isEmpty {
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        }
        let (data, response) = try await session.upload(for: request, from: encoded)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingErrors.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkingErrors.serverError(statusCode: httpResponse.statusCode)
        }
        do {
            let responseDTO = try JSONDecoder().decode(OrderDTO.self, from: data)
            return OrderMapper.toDomain(orderDTO: responseDTO).order
        } catch {
            throw NetworkingErrors.failedToDecodeData(underlying: error)
        }
    }
}
