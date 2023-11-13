//
//  Team.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation


class Team {
    var name: String
    var members: [Character] = []  // array of team member
    static var usedNames: [String] = []  // static array for usednames members
    static var usedTeamNames: [String] = [] // static array of used team names

    init(name: String) {
            self.name = name
        }
    func addMember() {
        var characterType: CharacterType?
        while characterType == nil {
            print("Choisissez le type de personnage à ajouter à votre équipe:")
            for type in CharacterType.allCases {
                print("\(type.rawValue). \(type.description)")
            }
            if let choice = readLine(), let choiceInt = Int(choice), let selectedType = CharacterType(rawValue: choiceInt) {
                characterType = selectedType
            } else {
                print("Choix invalide. Essayez encore.")
            }
        }

        var name: String?
        while name == nil {
            print("Entrez le nom du personnage:")
            if let enteredName = readLine(), !Team.usedNames.contains(enteredName) {
                name = enteredName
                Team.usedNames.append(enteredName)
            } else if name != nil {
                print("Ce nom est déjà utilisé. Essayez-en un autre.")
            }
        }

        let newCharacter: Character
        switch characterType! {
        case .warrior:
            newCharacter = Warrior(name: name!)
        case .magus:
            newCharacter = Magus(name: name!)
        case .colossus:
            newCharacter = Colossus(name: name!)
        case .dwarf:
            newCharacter = Dwarf(name: name!)
        }

        members.append(newCharacter)
        print("\(newCharacter.name) a été ajouté à votre équipe en tant que \(type(of: newCharacter))!")
    }



    func displayMembers() {
        print("Membres de l'équipe:")
        for (index, member) in members.enumerated() {
            print("\(index + 1). \(member.name) (\(type(of: member)))")
        }
    }

      func teamIsAlive() -> Bool {
          for member in members {
              if member.healthPoints > 0 {
                  return true
              }
          }
          return false
      }

    
    func attack(targetTeam: Team) {
        print("Choisissez un personnage de votre équipe pour attaquer:")
        displayMembers()
        var attacker: Character? = nil
        while attacker == nil {
            if let choice = readLine(), let choiceInt = Int(choice), choiceInt > 0 && choiceInt <= members.count {
                attacker = members[choiceInt - 1]
            } else {
                print("Choix invalide. Essayez encore.")
            }
        }

        print("Choisissez un personnage à attaquer dans l'équipe adverse:")
        targetTeam.displayMembers()

        var target: Character? = nil
        while target == nil {
            if let choice = readLine(), let choiceInt = Int(choice), choiceInt > 0 && choiceInt <= targetTeam.members.count {
                target = targetTeam.members[choiceInt - 1]
            } else {
                print("Choix invalide. Essayez encore.")
            }
        }

        if let attacker = attacker, let target = target {
            attacker.attack(target: target)
            print("\(attacker.name) a attaqué \(target.name)!")
        } else {
            print("Erreur : attaquant ou cible non valide.")
        }

    }
    
}
