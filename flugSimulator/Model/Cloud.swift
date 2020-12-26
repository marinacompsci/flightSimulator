//
//  Cloud.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 23.12.20.
//

import UIKit

struct Cloud {
    let speedReduction = 0.25
    
    var image: UIImageView!
    
    func reduceAirplaneSpeed(airplane: Airplane) {
        airplane.reduceSpeed(byAmount: (1-speedReduction))
        if (airplane.speed <= airplane.stallSpeed) {
            // lose game
        }
    }
}
