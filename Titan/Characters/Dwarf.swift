//
//  Dwarf.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation

class Dwarf: Character {
    
        init(name: String) {
            super.init(name: name, healthPoints: 80, weapon: Weapon(name: "axe", damage: 35))
        }
    }
