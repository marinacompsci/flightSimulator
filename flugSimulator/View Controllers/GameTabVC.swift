//
//  GameTabVC.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 28.12.20.
//

import UIKit

class GameTabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gameVC = GameVC()
        gameVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "gamecontroller"), tag: 0)
        
        let historyVC = GameHistoryVC()
        historyVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "list.bullet"), tag: 1)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        viewControllers = [gameVC, historyVC]
    }
    
    
}
