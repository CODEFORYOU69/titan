//
//  Team.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation  // Importe le module Foundation pour utiliser des fonctionnalités comme readLine()

// Définition de la classe Team
class Team {
    var name: String
    var members: [Character] = []  // Tableau pour stocker les membres de l'équipe
    static var usedNames: [String] = []  // Tableau statique pour stocker les noms déjà utilisés
    static var usedTeamNames: [String] = [] // Tablkeau statique pour stocker les noms d'équipes déja utilisés

    init(name: String) {
            self.name = name
        }
    // Méthode pour ajouter un membre à l'équipe
    func addMember() {
        print("Choisissez le type de personnage à ajouter à votre équipe:")
        print("1. Warrior")
        print("2. Magus")
        print("3. Colossus")
        print("4. Dwarf")
        if let choice = readLine(), let choiceInt = Int(choice) {
            var name: String? = nil
            while name == nil {
                print("Entrez le nom du personnage:")
                if let enteredName = readLine() {
                    if !Team.usedNames.contains(enteredName) {
                        name = enteredName
                        Team.usedNames.append(name!)  // Ajoute le nom à la liste des noms utilisés
                    } else {
                        print("Ce nom est déjà utilisé. Essayez-en un autre.")
                    }
                }
            }

            var newCharacter: Character?  // Variable pour stocker le nouveau personnage
            // Crée un nouveau personnage en fonction du choix de l'utilisateur
            switch choiceInt {
            case 1:
                newCharacter = Warrior(name: name!)
            case 2:
                newCharacter = Magus(name: name!)
            case 3:
                newCharacter = Colossus(name: name!)
            case 4:
                newCharacter = Dwarf(name: name!)
            default:
                print("Choix invalide.")
            }

            // Ajoute le nouveau personnage à l'équipe
            if let newCharacter = newCharacter {
                members.append(newCharacter)
                print("\(name!) a été ajouté à votre équipe en tant que \(type(of: newCharacter))!")
            }
        }
    }


    // Méthode pour afficher les membres de l'équipe
    func displayMembers() {
        print("Membres de l'équipe:")
        for (index, member) in members.enumerated() {
            print("\(index + 1). \(member.name) (\(type(of: member)))")
        }
    }
    // Méthode pour vérifier si l'équipe est toujours en vie
      func teamIsAlive() -> Bool {
          for member in members {
              if member.healthPoints > 0 {
                  return true
              }
          }
          return false
      }
    // Méthode pour attaquer un personnage d'une autre équipe
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

            attacker?.attack(target: target!)
            print("\(attacker!.name) a attaqué \(target!.name)!")
        }
}
