//
//  HistoryCell.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 28.12.20.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    
    static let reuseId = "HistoryCell"
    var date: Date!
    var distance: Double!
    var speed: Double!
    
    let badge = UIImageView(image: UIImage(systemName: "rosette"))
    let distanceLabel = UILabel()
    let speedLabel = UILabel()
    let dateLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    func setup(date: Date, distance: Double, speed: Double) {
        self.date = date
        self.distance = distance
        self.speed = speed
        
        contentView.backgroundColor = .systemPink
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupBadge()
        setupDistanceLabel()
        setupSpeedLabel()
        setupDateLabel()
    }
    
    private func setupBadge() {
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.tintColor = .white
        contentView.addSubview(badge)
        
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            badge.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            badge.widthAnchor.constraint(equalToConstant: 35),
            badge.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func setupDistanceLabel() {
        distanceLabel.textColor = .white
        distanceLabel.font = UIFont(name: "Avenir Next Condensed", size: 20)
        distanceLabel.text = "Distance: \(distance!)"
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: badge.bottomAnchor, constant: 10),
            distanceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func setupSpeedLabel() {
        speedLabel.text = "Speed: \(speed!)"
        speedLabel.textColor = .white
        speedLabel.font = UIFont(name: "Avenir Next Condensed", size: 20)
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(speedLabel)
        
        NSLayoutConstraint.activate([
            speedLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10),
            speedLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
    }
    
    
    private func setupDateLabel() {
        dateLabel.text = "\(date.formatToSimpleDate())"
        dateLabel.numberOfLines = 0
        dateLabel.textColor = .white
        dateLabel.font = UIFont(name: "Avenir Next Condensed", size: 20)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: speedLabel.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
