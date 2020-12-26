//
//  ViewController.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 23.12.20.
//

import UIKit

class GameVC: UIViewController {
    
    let airplane = Airplane(image: UIImageView(image: UIImage(named: "airplane")))
    var cloud = Cloud(image: UIImageView(image: UIImage(named: "cloud")))
    let gameOver = false
    var backgroundView: UIImageView!
    
    let timeLabel = UILabel()

    let distanceLabel = UILabel()
    var distanceTravelled = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupLabels()
        setupClouds()
        setupAirplane()
        gameEngine()
    }
    
    private func setupBackground() {
        let imageView = UIImageView(image: UIImage(named: "background"))
        backgroundView = imageView
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupLabels() {
        distanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        distanceLabel.textColor = .white
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            distanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            distanceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            distanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
        
        timeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        timeLabel.textColor = .white
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            timeLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10),
        ])
        
        
    }
    
    private func setupAirplane() {
        airplane.image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(airplane.image)
        
        NSLayoutConstraint.activate([
            airplane.image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            airplane.image.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            airplane.image.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.3),
            airplane.image.heightAnchor.constraint(equalTo: airplane.image.widthAnchor),
        ])
    }
    
    private func setupClouds() {
        cloud.image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cloud.image)
        
        NSLayoutConstraint.activate([
            cloud.image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cloud.image.topAnchor.constraint(equalTo: distanceLabel.topAnchor),
            cloud.image.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.3),
            cloud.image.heightAnchor.constraint(equalTo: cloud.image.widthAnchor),
        ])
    }
    
    private func gameEngine() {
        let startTime = Date()
        var yPosition: Double = 0
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) {
            [weak self] timer in
            let timerDuration = Int(round(Date().timeIntervalSince(startTime)))
            yPosition += 0.03
            self?.updateViews(timer: timerDuration, yPosition: yPosition)
            self?.checkTouch(cloudPosition: self!.cloud.image.frame)
            if (timerDuration == Int(self!.airplane.flightDuration)) {
                timer.invalidate()
            }
        }
    }
    
    private func updateViews(timer: Int, yPosition: Double) {
        timeLabel.text = "Time: \(Int(timer))s"
        distanceTravelled += 0.03 * airplane.speed
        distanceLabel.text = "Distance behind: \(String(format: "%.2f", distanceTravelled))km"
        UIView.animate(withDuration: 1, animations: {
            [weak self] in
            self?.cloud.image.transform = CGAffineTransform(translationX: 0, y: CGFloat(yPosition*100))
        })
    }

    
    private func checkTouch(cloudPosition: CGRect) {
        if cloudPosition.intersects(airplane.image.frame) {
            cloud.reduceAirplaneSpeed(airplane: airplane)
        }
    }


}

