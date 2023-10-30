//
//  Warrior.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation
class Warrior: Character {
    init(name: String) {
        super.init(name: name, healthPoints: 100, weapon: Weapon(name: "Sword", damage: 150))
    }
}
