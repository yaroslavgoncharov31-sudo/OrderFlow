import Foundation

struct NetworkManager: OrderPlacing {
    func placeOrder(order: Order) async throws -> Order {
        let encoded = try JSONEncoder().encode(order)
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let apiKey = AppConfig.reqresAPIKey
        if !apiKey.isEmpty {
            request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        }
        request.httpMethod = "POST"
        let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingErrors.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkingErrors.serverError(statusCode: httpResponse.statusCode)
        }
        do {
            return try JSONDecoder().decode(Order.self, from: data)
        } catch {
            throw NetworkingErrors.failedToDecodeData(underlying: error)
        }
    }
}
