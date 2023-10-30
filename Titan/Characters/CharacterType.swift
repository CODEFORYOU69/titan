//
//  CharacterType.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation

enum CharacterType: Int, CaseIterable {
    case warrior = 1
    case magus
    case colossus
    case dwarf
    
    var description: String {
        switch self {
        case .warrior:
            return "Warrior"
        case .magus:
            return "Magus"
        case .colossus:
            return "Colossus"
        case .dwarf:
            return "Dwarf"
        }
    }
}
