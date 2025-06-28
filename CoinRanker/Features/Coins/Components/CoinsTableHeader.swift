//
//  CoinsTableHeader.swift
//  CoinRanker
//
//  Created by Felix kariuki on 28/06/2025.
//

import UIKit
import SwiftUI

class CoinsTableHeaderView: UIView {
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let coinsLabel: UILabel = {
        let label = UILabel()
        label.text = "# Coins"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let change24hLabel: UILabel = {
        let label = UILabel()
        label.text = "24h"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.systemGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    

    private func setupView() {
        backgroundColor = UIColor.systemBackground
        
        addSubview(containerStackView)
        addSubview(separatorView)
        

        containerStackView.addArrangedSubview(coinsLabel)
        containerStackView.addArrangedSubview(priceLabel)
        containerStackView.addArrangedSubview(change24hLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerStackView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -12),
            
   
            coinsLabel.widthAnchor.constraint(equalTo: containerStackView.widthAnchor, multiplier: 0.4),
            priceLabel.widthAnchor.constraint(equalTo: containerStackView.widthAnchor, multiplier: 0.3),
            change24hLabel.widthAnchor.constraint(equalTo: containerStackView.widthAnchor, multiplier: 0.3),
            
      
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func configure(coinsText: String = "# Coins", priceText: String = "Price", change24hText: String = "24h") {
        coinsLabel.text = coinsText
        priceLabel.text = priceText
        change24hLabel.text = change24hText
    }
    
    func updateAppearance(for colorScheme: ColorScheme) {
        switch colorScheme {
        case .dark:
            backgroundColor = UIColor.systemBackground
            separatorView.backgroundColor = UIColor.systemGray5
        case .light:
            backgroundColor = UIColor.systemBackground
            separatorView.backgroundColor = UIColor.systemGray6
        @unknown default:
            backgroundColor = UIColor.systemBackground
            separatorView.backgroundColor = UIColor.systemGray5
        }
    }
}

struct CoinsTableHeader: UIViewRepresentable {
    let coinsText: String
    let priceText: String
    let change24hText: String
    
    @Environment(\.colorScheme) private var colorScheme
    
    init(
        coinsText: String = "# Coins",
        priceText: String = "Price",
        change24hText: String = "24h"
    ) {
        self.coinsText = coinsText
        self.priceText = priceText
        self.change24hText = change24hText
    }
    
    func makeUIView(context: Context) -> CoinsTableHeaderView {
        let headerView = CoinsTableHeaderView()
        headerView.configure(
            coinsText: coinsText,
            priceText: priceText,
            change24hText: change24hText
        )
        return headerView
    }
    
    func updateUIView(_ uiView: CoinsTableHeaderView, context: Context) {
        uiView.configure(
            coinsText: coinsText,
            priceText: priceText,
            change24hText: change24hText
        )
        uiView.updateAppearance(for: colorScheme)
    }
}
