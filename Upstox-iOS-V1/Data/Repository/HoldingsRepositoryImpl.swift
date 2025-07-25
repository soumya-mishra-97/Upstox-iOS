//
//  HoldingsRepositoryImpl.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 25/07/25.
//

import Foundation
import Combine

protocol HoldingsRepository {
    func fetchHoldings() -> AnyPublisher<[Holding], Error>
}

final class HoldingsRepositoryImpl: HoldingsRepository {
    private let networkService: NetworkServicing
    
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchHoldings() -> AnyPublisher<[Holding], Error> {
        guard let url = URL(string: Endpoint.holdings) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return networkService
            .fetchData(from: url)
            .map { (response: HoldingsResponse) in
                response.data.userHolding
            }
            .eraseToAnyPublisher()
    }
}
