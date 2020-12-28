//
//  ViewController.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 23.12.20.
//

import UIKit

class GameVC: UIViewController {
    
    var airplane = Airplane(image: UIImageView(image: UIImage(named: "airplane")))
    var cloud = Cloud(image: UIImageView(image: UIImage(named: "cloud")))
    
    let rightArrow = UIButton()
    let leftArrow = UIButton()
    var backgroundView: UIImageView!
    
    let timeLabel = UILabel()
    let distanceLabel = UILabel()
    let gearButton = UIButton()
    var distanceTravelled = 0.0
    var timerDuration = 0
    let hitLabel = UILabel()
    
    var gameOver = false
    var isCounting = false
    var airplaneXShift = CGFloat(0)
    var cloudTopConstraint: NSLayoutConstraint!
    var cloudCenterXConstraint: NSLayoutConstraint!
    let cloudPositions = [-100, -80, -50, -30, -10, 10, 30, 50, 80, 100]
    var gameTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupGearButton()
        setupHitlabel()
        setupLabels()
        setupClouds()
        setupControlButtons()
        setupAirplane()
        showCounter()
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
    
    private func setupGearButton() {
        view.addSubview(gearButton)
        gearButton.setBackgroundImage(UIImage(systemName: "gear"), for: .normal)
        gearButton.translatesAutoresizingMaskIntoConstraints = false
        gearButton.tintColor = .white
        gearButton.backgroundColor = UIColor(red: 100/256, green: 100/256, blue: 100/256, alpha: 0.5)
        gearButton.layer.cornerRadius = 5
        gearButton.addTarget(self, action: #selector(showGearOptions), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            gearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            gearButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            gearButton.heightAnchor.constraint(equalToConstant: 30),
            gearButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setupHitlabel() {
        hitLabel.text = "Hit!"
        hitLabel.font = UIFont(name: "GillSans-UltraBold", size: 80)
        hitLabel.textAlignment = .center
        hitLabel.textColor = .systemPink
        hitLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hitLabel)
        hitLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            hitLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hitLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupLabels() {
        distanceLabel.font = UIFont(name: "Avenir Next", size: 20)
        distanceLabel.textColor = .white
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            distanceLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 10),
            distanceLabel.rightAnchor.constraint(equalTo: gearButton.leftAnchor, constant: -10),
            distanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
        ])
        
        timeLabel.font = UIFont(name: "Avenir Next", size: 20)
        timeLabel.textColor = .white
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            timeLabel.rightAnchor.constraint(equalTo: gearButton.leftAnchor, constant: -10),
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
        // THIS IS A HACK -> constant should not be equals -30
        // this is just so the cloud is bound to the very top of the screen
        cloudTopConstraint = cloud.image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30)
        cloudCenterXConstraint = cloud.image.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([
            cloudCenterXConstraint,
            cloudTopConstraint,
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
    
    private func showCounter() {
        isCounting = true
        let layerView = CounterView()
        view.addSubview(layerView)
        NSLayoutConstraint.activate([
            layerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            layerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        var counter = 3
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            [weak self] timer in
            if (counter < 0) {
                self?.isCounting = false
                timer.invalidate()
                layerView.removeFromSuperview()
                self?.gameEngine()
            }
            layerView.counterLabel.text = String(counter)
            counter -= 1
        }
    }
    
    private func gameEngine() {
        let startTime = Date()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) {
            [weak self] timer in
            guard let self = self else { return }
            self.timerDuration = Int(round(Date().timeIntervalSince(startTime)))
            self.updateViews(timer: self.timerDuration)
            // This is a hack -> Find out how to crop image out of imageView
            // Fire only when it really touches the image and not the rectangle where the image is inside
            // Maybe look for a vector img
            self.checkTouch(cloudPosition: self.cloud.image.frame.insetBy(dx: 0, dy: 58))
            self.repositionCloud()
            self.checkGame(insideTimer: timer)
        }
    }
    
    private func checkGame(insideTimer timer: Timer) {
        if (timerDuration == Int(airplane.flightDuration)) {
            timer.invalidate()
            showAlert(withTitle: "Congratulations!", withMessage: "You managed to survive for 2 minutes.", firstButtonMessage: "Close", secondButtonMessage: "Play again")
        } else if airplane.crashed {
            timer.invalidate()
            showAlert(withTitle: "Game Over!", withMessage: "You lost too much speed.", firstButtonMessage: "Close", secondButtonMessage: "Play again")
        }
    }
    
    private func showAlert(withTitle title: String,
                           withMessage message: String,
                           firstButtonMessage: String, secondButtonMessage: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: firstButtonMessage, style: .default) {
            [weak self] _ in
            self?.navigationController?.pushViewController(HomeVC(), animated: true)
        })
        
        if secondButtonMessage != nil { alertController.addAction(UIAlertAction(title: secondButtonMessage, style: .default) {
            [weak self] _ in
                self?.gameTimer.invalidate()
                self?.restartGame()
            })
        }
        present(alertController, animated: true)
        
    }
    
    private func updateViews(timer: Int) {
        timeLabel.text = "Time: \(Int(timer))s"
        distanceTravelled += 0.03 * airplane.speed
        distanceLabel.text = "Distance behind: \(String(format: "%.2f", distanceTravelled))km"
        cloudTopConstraint.constant += CGFloat.random(in: 3...10)
    }
    
    private func repositionCloud() {
        if self.cloud.image.frame.minY >= self.view.bounds.height {
            self.cloudTopConstraint.constant = 0
            self.cloudCenterXConstraint.constant = CGFloat(self.cloudPositions.randomElement()!)
            self.cloud.setTouchedAirplane(toValue: false)
        }
    }

    private func checkTouch(cloudPosition: CGRect) {
        if !cloud.touchedAirplane && cloudPosition.intersects(airplane.image.frame) {
            cloud.touchedAirplane = true
            cloud.reduceAirplaneSpeed(airplane: airplane)
            UIView.animate(withDuration: 1) {
                [weak self] in
                self?.hitLabel.isHidden = false
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {
                    [weak self] _ in
                    self?.hitLabel.isHidden = true
                }
            }
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
    
    private func restartGame() {
        cloudCenterXConstraint.constant = CGFloat(cloudPositions.randomElement()!)
        cloudTopConstraint.constant = 0
        airplaneXShift = 0
        cloud.touchedAirplane = false
        airplane.speed = 847 / 3600
        airplane.crashed = false
        gameOver = false
        distanceTravelled = 0.0
        showCounter()
    }
    
    @objc
    private func showGearOptions() {
        guard !isCounting else { return }
        let alertVC = UIAlertController(title: "Options", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Restart", style: .destructive) {
          [weak self] _ in
            self?.gameTimer.invalidate()
            self?.restartGame()
        })
        alertVC.addAction(UIAlertAction(title: "Back to Home", style: .default) {
            [weak self] _ in
            self?.gameTimer.invalidate()
            self?.navigationController?.pushViewController(HomeVC(), animated: true)
        })
        present(alertVC, animated: true)
    }
    
    //TODO: SAVE BEST RESULTS LOCALLY
    //TODO: REFACTOR OTHER VIEWS OUT OF THIS VIEWCONTROLLER
    //TODO: CHECK IF SPEED IS INDEED DECREASING
    //TODO: CLOUD CANNOT DISAPPEAR FROM SCREEN AFTER ADDING RANDOM CONSTANT TO X COORDINATE
    
}

