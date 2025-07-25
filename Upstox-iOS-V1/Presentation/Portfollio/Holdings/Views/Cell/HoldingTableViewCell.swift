//
//  HoldingTableViewCell.swift
//  Upstox-iOS-V1
//
//  Created by Soumya Mishra on 25/07/25.
//

import UIKit

class HoldingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stockSymbolLbl: UILabel!
    @IBOutlet weak var netQTYLbl: UILabel!
    @IBOutlet weak var currentPriceLbl: UILabel!
    @IBOutlet weak var pnlValueLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }
    
    // MARK: - Setup
    private func setupInitialState() {
        stockSymbolLbl.text = "NA"
        netQTYLbl.text = "0.0"
        currentPriceLbl.text = "0.0"
        pnlValueLbl.text = "0.0"
        pnlValueLbl.textColor = .label
    }
    
    // MARK: - Configuration
    func configure(with asset: Holding) {
        stockSymbolLbl.text = asset.symbol
        netQTYLbl.text = asset.quantity.description
        currentPriceLbl.text = asset.ltp.asCurrency()
        
        let pnlValue = asset.pnl
        let prefix = pnlValue >= 0 ? "" : "-"
        pnlValueLbl.text = "\(prefix)\(abs(pnlValue).asCurrency())"
        
        updatePNLTextColor(for: pnlValue)
    }

    private func updatePNLTextColor(for pnl: Double) {
        switch pnl {
        case let value where value > 0:
            pnlValueLbl.textColor = .systemGreen
        case let value where value < 0:
            pnlValueLbl.textColor = .systemRed
        default:
            pnlValueLbl.textColor = .label
        }
    }
}
