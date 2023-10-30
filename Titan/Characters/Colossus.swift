//
//  Colossus.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation

class Colossus: Character {
    init(name: String) {
        super.init(name: name, healthPoints: 120, weapon: Weapon(name: "Masse", damage: 8))
    }
}
