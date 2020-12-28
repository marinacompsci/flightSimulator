//
//  GameHistoryVC.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 28.12.20.
//

import UIKit

class GameHistoryVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.topItem?.title = "Game Records"
        navigationController?.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view = HistoryView(frame: view.frame)
   }

   override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
   }
}
