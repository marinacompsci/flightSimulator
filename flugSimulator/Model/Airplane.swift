//
//  Airplane.swift
//  flugSimulator
//
//  Created by Marina Beatriz Santana de Aguiar on 23.12.20.
//

import UIKit

class Airplane {
    /*
     Km per Seconds
     */
    var speed: Double = 847 / 3600
    
    /*
     Time in seconds the airplane can fly according to its amount of fuel
     */
    let flightDuration: Double = 2 * 60
    
    /*
     Speed < 235km / 3600s -> crash
     */
    let stallSpeed: Double = 235 / 3600
    
    var crashed = false
    
    var image: UIImageView!
    
    func reduceSpeed(byAmount amount: Double) {
        speed = speed * amount
    }
    
    init(image: UIImageView) {
        self.image = image
    }
}
