//
//  HomeVC.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 27.12.20.
//

import UIKit

class HomeVC: UIViewController {
    
    var backgroundView: UIImageView!
    var airplane: Airplane!
    var gameVC: GameVC!
    var gameProtocol: GameProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseGameInfo()
        setup()
    }
    
    private func setup() {
        // DELETE THIS LATER
        backgroundView = UIImageView(image: UIImage(named: "background"))
        airplane = Airplane(image: UIImageView(image: UIImage(named: "airplane")))
        gameVC = GameVC()
        
        let homeVC = HomeView(frame: view.frame, backgroundView: backgroundView, airplane: airplane)
        view = homeVC
        homeVC.gameDelegate = self
    }
    
    
    private func chooseGameInfo() {
        // Choose Game's Background
        // Choose Game's Difficulty
        // Choose Game's Airplane
        // Pass attributes to gameVC
    }
    
   
}

extension HomeVC: GameProtocol {
    func startGame() {
        navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
