//
//  PortfolioViewModel.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 24/07/25.
//

import Foundation
import Combine

final class PortfolioViewModel {
    
    @Published private(set) var holdings: [Holding] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    private let useCase: PortfolioUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: PortfolioUseCase = PortfolioUseCaseImpl()) {
        self.useCase = useCase
    }
    
    /// Fetch Holding Data
    func fetchHoldings() {
        isLoading = true
        errorMessage = nil
        
        useCase.execute()
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] holdings in
                self?.holdings = holdings
            }
            .store(in: &cancellables)
    }
}
