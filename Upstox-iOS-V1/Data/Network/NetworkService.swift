//
//  NetworkService.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 24/07/25.
//

import Foundation
import Combine

protocol NetworkServicing {
    func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<T, Error>
}

final class NetworkService: NetworkServicing {
    func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> T in
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: result.data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
