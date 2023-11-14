//
//  Character.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation
class Character {
    static var usedNames: [String] = []
    var name: String {
        didSet {
            if Character.usedNames.contains(name) {
                print("Ce nom est déjà utilisé. Veuillez en choisir un autre.")
                name = oldValue
            } else {
                Character.usedNames.append(name)
            }
        }
    }
    var healthPoints: Int {
        didSet {
            if healthPoints < 0 {
                healthPoints = 0
            }
        }
    }

    var weapon: Weapon
    
    init(name: String, healthPoints: Int, weapon: Weapon) {  
        self.name = name
        self.healthPoints = healthPoints
        self.weapon = weapon
        if !Character.usedNames.contains(name) {
            Character.usedNames.append(name)
        }
    }
    
    func attack(target: Character) {
        target.healthPoints -= self.weapon.damage
        Game.totalDamage += weapon.damage
        print("\(self.name) a infligé \(self.weapon.damage) points de dégâts à \(target.name) avec \(self.weapon.name).")
        print("Points de vie restants de \(target.name): \(target.healthPoints)")
    }
}

