//
//  HTTPClient.swift
//  VenueFinder
//
//  Created by Claude on 29.03.2026.
//

import Foundation

// MARK: - Error

enum HTTPError: Error, Sendable, LocalizedError {
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingFailed(Error)
    case networkFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            "Invalid response from server"
        case .httpError(let code):
            "HTTP \(code)"
        case .decodingFailed:
            "Failed to decode response"
        case .networkFailed(let error):
            error.localizedDescription
        }
    }
}

// MARK: - HTTPClient

struct HTTPClient: Sendable {
    private var url: URL
    private var session: URLSession
    private let apiKey: String
    private let apiVersion: String = "1970-01-01"

    init(baseURL: URL, apiKey: String, session: URLSession = .shared) {
        self.url = baseURL
        self.apiKey = apiKey
        self.session = session
    }

    func fetch(_ url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiVersion, forHTTPHeaderField: "X-Places-Api-Version")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        print("📡 Request URL: \(url)")
        print("📡 Headers: Accept=application/json, X-Places-Api-Version=\(apiVersion)")

        do {
            let (data, response) = try await session.data(for: request)
            print("📡 Response Status: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
            try validateStatusCode(response)
            return data
        } catch let error as URLError {
            throw HTTPError.networkFailed(error)
        } catch {
            throw error
        }
    }
    
    func post(_ url: URL, _ body: Data) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiVersion, forHTTPHeaderField: "X-Places-Api-Version")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        do {
            let (data, response) = try await session.data(for: request)
            try validateStatusCode(response)
            return data
        } catch let error as URLError {
            throw HTTPError.networkFailed(error)
        } catch {
            throw error
        }
    }
    
}

// MARK: - Helper

private func validateStatusCode(_ response: URLResponse) throws {
    guard let httpResponse = response as? HTTPURLResponse else {
        throw HTTPError.invalidResponse
    }
    guard (200..<300).contains(httpResponse.statusCode) else {
        throw HTTPError.httpError(statusCode: httpResponse.statusCode)
    }
}

// MARK: - Extensions

extension HTTPClient {
    static func live(apiKey: String) -> HTTPClient {
        HTTPClient(baseURL: URL(string: "https://api.foursquare.com/v3")!, apiKey: apiKey)
    }
    
    static var mock: HTTPClient {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        return HTTPClient(baseURL: URL(string: "https://api.example.com")!, apiKey: "mock-key", session: session)
    }
}

// MARK: - Decoding Helper

extension HTTPClient {
    func decode<T: Decodable>(
        _ type: T.Type,
        from url: URL
    ) async throws -> T {
        print("📡 Fetching from: \(url)")
        let data = try await fetch(url)
        
        // Try to decode as error first
        if let errorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
            throw HTTPError.decodingFailed(NSError(domain: errorResponse.message, code: -1))
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            throw HTTPError.decodingFailed(error)
        }
    }
}

// MARK: - Error Response

private struct APIErrorResponse: Decodable {
    let message: String
}

// MARK: - Mock Support

final class MockURLProtocol: URLProtocol {
    static var mockData: [String: Data] = [:]
    static var shouldFail: Bool = false
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        guard let client = client else { return }
        
        if Self.shouldFail {
            let error = NSError(domain: "MockError", code: -1)
            client.urlProtocol(self, didFailWithError: error)
            return
        }
        
        let path = request.url?.path ?? ""
        if let data = Self.mockData[path] {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client.urlProtocol(self, didLoad: data)
            client.urlProtocolDidFinishLoading(self)
        } else {
            let error = NSError(domain: "MockError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not found"])
            client.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
