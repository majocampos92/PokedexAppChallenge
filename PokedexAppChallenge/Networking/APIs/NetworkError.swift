//
//  NetworkError.swift
//  PokedexAppChallenge
//
//  Created by Maria Campos on 7/4/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received from server"
        case .decodingError:
            return "Error decoding response"
        case .serverError(let code):
            return "Server error with status code: \(code)"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
    
    var userMessage: String {
        switch self {
        case .noData:
            return "No encontramos datos"

        case .serverError(let code):
            return "Error del servidor"

        case .invalidURL:
            return "Error interno de la app"

        case .decodingError:
            return "Error procesando datos"

        case .unknown:
            return "Algo salió mal, vuelve a intentar"
        }
    }
}
