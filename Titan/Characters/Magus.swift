//
//  Magus.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation

class Magus: Character {
    var healingPower: Int
    
    init(name: String, weapon: Weapon = Weapon(name: "Staff", damage: 10)) {
        self.healingPower = 20
        super.init(name: name, healthPoints: 120, weapon: weapon)  
    }
    
    func heal(target: Character) {
        target.healthPoints += self.healingPower
        print("\(self.name) a soigné \(target.name) de \(self.healingPower) points de vie.")
        print("Points de vie restants de \(target.name): \(target.healthPoints)")
    }
    
    func action(choice: Int, target: Character) {
        if choice == 1 {
            // Attaquer
            self.attack(target: target)
        } else if choice == 2 {
            // Soigner
            heal(target: target)
        }
    }
}

