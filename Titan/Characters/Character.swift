//
//  Character.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation
class Character {
    static var usedNames: [String] = [] // Variable statique pour stocker les noms déjà utilisés
    var name: String {
        didSet {
            if Character.usedNames.contains(name) {
                // Gérer le cas où le nom est déjà utilisé
            } else {
                Character.usedNames.append(name) // Ajouter le nouveau nom à la liste
            }
        }
    }
    var healthPoints: Int
    var weapon: Weapon  // Ajout de la propriété 'weapon'
    
    init(name: String, healthPoints: Int, weapon: Weapon) {  
        self.name = name
        self.healthPoints = healthPoints
        self.weapon = weapon  // Initialisation de 'weapon'
        if !Character.usedNames.contains(name) {
            Character.usedNames.append(name) // Ajouter le nom à la liste lors de l'initialisation
        }
    }
    
    func attack(target: Character) {
        target.healthPoints -= self.weapon.damage  // Utilisation de 'weapon.damage'
        print("\(self.name) a infligé \(self.weapon.damage) points de dégâts à \(target.name) avec \(self.weapon.name).")
        print("Points de vie restants de \(target.name): \(target.healthPoints)")
    }
}

