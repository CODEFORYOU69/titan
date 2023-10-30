//
//  Magus.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation

class Magus: Character {
    var healingPower: Int
    
    init(name: String, weapon: Weapon = Weapon(name: "Staff", damage: 5)) {  // Ajout du paramètre 'weapon' avec une valeur par défaut
        self.healingPower = 20 // Tu peux ajuster cette valeur
        super.init(name: name, healthPoints: 120, weapon: weapon)  // Passage de 'weapon' à 'super.init()'
    }
    
    // Méthode pour soigner un autre personnage
    func heal(target: Character) {
        target.healthPoints += self.healingPower
        print("\(self.name) a soigné \(target.name) de \(self.healingPower) points de vie.")
        print("Points de vie restants de \(target.name): \(target.healthPoints)")
    }
    
    // Méthode pour attaquer ou soigner
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

