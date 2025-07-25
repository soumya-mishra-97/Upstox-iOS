//
//  PortfolioUseCase.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 24/07/25.
//

import Foundation
import Combine

protocol PortfolioUseCase {
    func execute() -> AnyPublisher<[Holding], Error>
}

final class PortfolioUseCaseImpl: PortfolioUseCase {
    private let repository: HoldingsRepository
    
    init(repository: HoldingsRepository = HoldingsRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[Holding], Error> {
        return repository.fetchHoldings()
    }
}
