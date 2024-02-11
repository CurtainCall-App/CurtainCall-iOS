//
//  MoyaProvider + Extension.swift
//  Common
//
//  Created by 김민석 on 2/11/24.
//

import Foundation
import Moya

extension MoyaProvider {
    public func request<T: Decodable>(_ target: Target) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    guard let result = try? JSONDecoder().decode(T.self, from: response.data) else {
                        print(String(data: response.data, encoding: .utf8) ?? "")
                        continuation.resume(throwing: MoyaError.jsonMapping(response))
                        return
                    }
                    continuation.resume(returning: result)
                case .failure(let error):
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
