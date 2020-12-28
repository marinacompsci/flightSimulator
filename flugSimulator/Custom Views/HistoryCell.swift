//
//  HistoryCell.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 28.12.20.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    
    static let reuseId = "HistoryCell"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        contentView.backgroundColor = .systemPink
    }
}
