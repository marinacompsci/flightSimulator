//
//  CounterView.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 28.12.20.
//

import UIKit

class CounterView: UIView {
    
    let counterLabel = UILabel()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 0/256, green: 0/256, blue: 0/256, alpha: 0.5)
        
        addSubview(counterLabel)

        counterLabel.text = String(3)
        counterLabel.font = UIFont(name: "GillSans-UltraBold", size: 80)
        counterLabel.textAlignment = .center
        counterLabel.textColor = .white
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: frame.width),
            heightAnchor.constraint(equalToConstant: frame.height),
            
            counterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
}
