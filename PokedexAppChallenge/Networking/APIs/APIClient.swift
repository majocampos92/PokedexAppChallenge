//
//  APIClient.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

class APIClient {
    
    /// Handles network requests and decodes API responses into the expected model

    func request<T: Decodable>(endpoint: PokemonAPI,completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        // Validate URL from endpoint
        guard let url = URL(string: endpoint.url) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Handle request error
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }

            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            
            // Ensure data is not nil
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                // Decode JSON into expected model
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }

        }.resume()
    }
}
