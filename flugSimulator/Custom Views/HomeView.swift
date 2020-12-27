//
//  HomeView.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 27.12.20.
//

import UIKit

class HomeView: UIView {
    
    var backgroundView: UIImageView!
    var airplane: Airplane!
    var animationTimer: Timer!
    var gameDelegate: GameProtocol!
    
    init(frame: CGRect, backgroundView: UIImageView, airplane: Airplane) {
        super.init(frame: frame)
        self.backgroundView = backgroundView
        self.airplane = airplane
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setup() {
        setupBackground()
        setupAirplane()
        setupTitle()
        setupButton()
        animation()
    }
    
    private func setupBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.systemGray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.7, y: 0.7)
        layer.addSublayer(gradientLayer)
    }
    
    private func setupAirplane() {
        airplane.image.translatesAutoresizingMaskIntoConstraints = false
        airplane.image.layer.cornerRadius = 40
        airplane.image.backgroundColor = UIColor(red: 256/256, green: 256/256, blue: 256/256, alpha: 0.25)
        addSubview(airplane.image)
        
        NSLayoutConstraint.activate([
            airplane.image.centerXAnchor.constraint(equalTo: centerXAnchor),
            airplane.image.centerYAnchor.constraint(equalTo: centerYAnchor),
            airplane.image.widthAnchor.constraint(equalToConstant: bounds.width * 0.5),
            airplane.image.heightAnchor.constraint(equalTo: airplane.image.widthAnchor),
        ])
    }
    
    private func animation() {
        var angle = CGFloat(0.0)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) {
            [weak self] timer in
            self?.animationTimer = timer
            
            UIView.animate(withDuration: 1) {
                [weak self] in
                angle += 0.2
                self?.airplane.image.transform = CGAffineTransform(rotationAngle: angle)
            }
        }
    }
    
    private func setupTitle() {
        let title = UILabel()
        title.text = "FLIGHT SIMULATOR"
        title.font = UIFont(name: "Avenir Next Condensed", size: 40)
        title.numberOfLines = 0
        title.textColor = .white
        title.textAlignment = .center
        title.layer.borderColor = UIColor.white.cgColor
        title.layer.borderWidth = 2
        title.layer.cornerRadius = 5
        title.backgroundColor = UIColor(red: 100/256, green: 100/256, blue: 100/256, alpha: 0.15)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70),
        ])
        
    }
    
    private func setupButton() {
        let startButton = UIButton()
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitleColor(.systemGray, for: .highlighted)
        startButton.addTarget(self, action: #selector(tellToStartGame), for: .touchUpInside)
        
        startButton.backgroundColor =  UIColor(red: 0/256, green: 0/256, blue: 0/256, alpha: 0.8)
        startButton.layer.cornerRadius = 30
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.widthAnchor.constraint(equalToConstant: bounds.width * 0.7),
            startButton.heightAnchor.constraint(equalToConstant: (bounds.width * 0.3) / 2),            
        ])
    }
    
    @objc
    private func tellToStartGame() {
        gameDelegate.startGame()
    }
    
}
