//
//  HoldingViewController.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 24/07/25.
//

import UIKit
import Combine

class HoldingViewController: UIViewController {
    
    @IBOutlet weak var assetsTableView: UITableView!
    
    private let viewModel = PortfolioViewModel()
    private let bottomSheetView = PortfolioBottomSheetView()
    private var bottomSheetHeightConstraint: NSLayoutConstraint?
    private var cancellables = Set<AnyCancellable>()
    
    /// Loading Indicator
    private let loadingIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = UIColor(hex: "#1E4EBC")
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchHoldings()
    }
    
    // MARK: - Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        assetsTableView.delegate = self
        assetsTableView.dataSource = self
        assetsTableView.separatorStyle = .singleLine
        assetsTableView.separatorColor = .gray
        assetsTableView.separatorInset = .zero
        assetsTableView.register(UINib(nibName: "HoldingTableViewCell", bundle: nil), forCellReuseIdentifier: "HoldingTableViewCell")
        
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(bottomSheetView)
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomSheetHeightConstraint = bottomSheetView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        bottomSheetHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        bottomSheetView.heightChanged = { [weak self] newHeight in
            self?.bottomSheetHeightConstraint?.constant = newHeight
            UIView.animate(withDuration: 0.3) {
                self?.view.layoutIfNeeded()
            }
        }
        assetsTableView.contentInset.bottom = 80
    }
    
    /// Observes ViewModel for data, loading, and error changes
    private func bindViewModel() {
        bindHoldings()
        bindLoadingState()
        bindErrors()
    }
    
    /// Reloads table on holdings update
    private func bindHoldings() {
        viewModel.$holdings
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.assetsTableView.reloadData()
                self.updateSummary()
            }
            .store(in: &cancellables)
    }
    
    
    /// Portfolio Summary
    private func updateSummary() {
        let holdings = viewModel.holdings
        
        let currentValue = holdings.reduce(0.0) { result, holding in
            result + (holding.ltp * Double(holding.quantity))
        }
        
        let investment = holdings.reduce(0.0) { result, holding in
            result + (holding.avgPrice * Double(holding.quantity))
        }
        
        let todaysPL = holdings.reduce(0.0) { result, holding in
            result + ((holding.ltp - holding.close) * Double(holding.quantity))
        }
        
        bottomSheetView.configure(
            currentValue: currentValue,
            investment: investment,
            todaysPL: todaysPL
        )
    }
    
    /// Lodading State
    private func bindLoadingState() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
            }
            .store(in: &cancellables)
    }
    
    /// Error State
    private func bindErrors() {
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.showErrorAlert(message: message)
            }
            .store(in: &cancellables)
    }
}


extension HoldingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.holdings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HoldingTableViewCell", for: indexPath) as? HoldingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.holdings[indexPath.row])
        return cell
    }
}
