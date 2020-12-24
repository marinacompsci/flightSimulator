//
//  Airplane.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 23.12.20.
//

import UIKit

struct Airplane {
    /*
     Km per Seconds
     */
    var speed: Double = 847 / 3600
    
    /*
     Time in seconds the airplane can fly according to its amount of fuel
     */
    let flightDuration: Double = 2 * 60
    
    /*
     Speed < 235 -> crash
     */
    let stallSpeed: Double = 235
    
    var image: UIImageView!
    
    init(image: UIImageView) {
        self.image = image
    }
}
