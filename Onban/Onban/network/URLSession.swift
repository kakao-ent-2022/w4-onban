import Foundation

extension URLSession {
    func load<T: Decodable>(
        urlRequest: URLRequest,
        completion: @escaping(T?, Bool) -> Void
    ) {
        dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if let response = response as? HTTPURLResponse,
               (200..<300).contains(response.statusCode) {
                if let data = data {
                    let decodeData = try? JSONDecoder().decode(ApiResponse<T>.self, from: data)
                    completion(decodeData?.body, true)
                }
            } else {
                completion(nil, false)
            }
            
        }.resume()
    }
}
