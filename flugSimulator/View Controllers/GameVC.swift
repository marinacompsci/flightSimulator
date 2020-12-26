//
//  ViewController.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 23.12.20.
//

import UIKit

class GameVC: UIViewController {
    
    let airplane = Airplane(image: UIImageView(image: UIImage(named: "airplane")))
    let cloud = Cloud(image: UIImageView(image: UIImage(named: "cloud")))
    let rightArrow = UIButton()
    let leftArrow = UIButton()
    var backgroundView: UIImageView!
    
    let timeLabel = UILabel()
    let distanceLabel = UILabel()
    var distanceTravelled = 0.0
    
    let gameOver = false
    var airplaneXShift = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupLabels()
        setupClouds()
        setupControlButtons()
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
            airplane.image.bottomAnchor.constraint(equalTo: rightArrow.topAnchor, constant: -5),
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
    
    private func setupControlButtons() {
        view.addSubview(rightArrow)
        view.addSubview(leftArrow)
        rightArrow.tintColor = .black
        rightArrow.setBackgroundImage(UIImage(systemName: "chevron.right.circle.fill"), for: .normal)
        rightArrow.addTarget(self, action: #selector(moveAirplaneToRight), for: .touchUpInside)
        rightArrow.addTarget(self, action: #selector(pushAirplaneToRight), for: .touchDownRepeat)
        
        leftArrow.tintColor = .black
        leftArrow.setBackgroundImage(UIImage(systemName: "chevron.left.circle.fill"), for: .normal)
        leftArrow.addTarget(self, action: #selector(moveAirplaneToLeft), for: .touchUpInside)
        leftArrow.addTarget(self, action: #selector(pushAirplaneToLeft), for: .touchUpInside)

        
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        leftArrow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftArrow.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            leftArrow.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            leftArrow.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.20),
            leftArrow.widthAnchor.constraint(equalTo: leftArrow.heightAnchor),
            
            rightArrow.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            rightArrow.bottomAnchor.constraint(equalTo: leftArrow.bottomAnchor),
            rightArrow.heightAnchor.constraint(equalTo: leftArrow.heightAnchor),
            rightArrow.widthAnchor.constraint(equalTo: leftArrow.widthAnchor),
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

    @objc
    private func moveAirplaneToRight() {
        moveAirplane(toDirection: .right, byAmount: 8)
    }
    
    @objc
    private func pushAirplaneToRight() {
        moveAirplane(toDirection: .right, byAmount: 20)
    }
 
    @objc
    private func moveAirplaneToLeft() {
        moveAirplane(toDirection: .left, byAmount: 8)
    }
    
    @objc
    private func pushAirplaneToLeft() {
        moveAirplane(toDirection: .left, byAmount: 20)
    }
    
    private func moveAirplane(toDirection direction: Direction, byAmount amount: Double) {
        switch direction {
            case .left:
                UIView.animate(withDuration: 0.1, animations: {
                    [weak self] in
                    guard self!.airplane.image.frame.minX - CGFloat(amount) >= 0 else { return }
                    self?.airplaneXShift -= CGFloat(amount)
                    self?.airplane.image.transform = CGAffineTransform(translationX: self!.airplaneXShift, y: 0)
                })
            case .right:
                UIView.animate(withDuration: 0.1, animations: {
                    [weak self] in
                    guard self!.airplane.image.frame.maxX + CGFloat(amount) <= self!.view.bounds.width else { return }
                    self?.airplaneXShift += CGFloat(amount)
                    self?.airplane.image.transform = CGAffineTransform(translationX: self!.airplaneXShift, y: 0)
                })
        }
    }
    
    //TODO: CLOUD TOUCHES AIRPLANE -> SCREEN GOES RED
}

