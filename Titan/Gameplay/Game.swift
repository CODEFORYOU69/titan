//
//  Game.swift
//  Titan
//
//  Created by younes ouasmi on 23/10/2023.
//

import Foundation


class Game {
    var team1: Team
    var team2: Team
    var roundCount: Int = 0
    static var totalDamage: Int = 0
    static var totalHealing: Int = 0

    init() {
        self.team1 = Team(name: "Joueur 1")
        self.team2 = Team(name: "Joueur 2")
    }

    func initializeGame() {
        team1.name = askForTeamName(player: "Joueur 1")
        composeTeam(team: team1)
        team2.name = askForTeamName(player: "Joueur 2")
        composeTeam(team: team2)
    }

    func askForTeamName(player: String) -> String {
        print("\(player), donnez un nom à votre équipe:")
        return readLine() ?? ""
    }

    func composeTeam(team: Team) {
        print("\(team.name), composez votre équipe:")
        for _ in 1...3 {
            team.addMember()
        }
    }

    func displayTeams() {
        team1.displayMembers()
        team2.displayMembers()
    }
    func displayTeamHealth(team: Team) {
        print("État de santé de l'équipe :")
        for member in team.members {
            print("\(member.name): \(member.healthPoints) points de vie")
        }
    }
    func fight() {
       
            
            var roundCount = 0
      
        while team1.teamIsAlive() && team2.teamIsAlive() {
                roundCount += 1
                print("Tour \(roundCount)")
            
            let actionPlayer1 = playerAction(team: team1, opponentTeam: team2)
            
            actionPlayer1()
            displayTeamHealth(team: team1)
            displayTeamHealth(team: team2)
            
            if !team2.teamIsAlive() {
                break
            }
            
            let actionPlayer2 = playerAction(team: team2, opponentTeam: team1)
            actionPlayer2()
            displayTeamHealth(team: team1)
            displayTeamHealth(team: team2)
            
            if !team1.teamIsAlive() {
                break
            }
            
                    }
        displayStats()
    }
    func displayStats() {
        print("Statistiques du jeu :")
        print("Nombre de tours : \(roundCount)")
        print("Dégâts totaux infligés : \(Game.totalDamage)")
        print("Soins totaux : \(Game.totalHealing)")
    }
   
    func selectCharacter(from team: Team, with prompt: String, excluding characterToExclude: Character? = nil) -> Character {
        while true {
            print(prompt)
            for (index, member) in team.members.enumerated() {
                if member !== characterToExclude {
                    print("\(index + 1). \(member.name) (\(type(of: member)))")
                }
            }
            if let choice = readLine(), let index = Int(choice), index > 0, index <= team.members.count {
                let selectedCharacter = team.members[index - 1]
                if selectedCharacter !== characterToExclude && selectedCharacter.healthPoints > 0 {
                    return selectedCharacter
                } else {
                    print("Ce personnage ne peut pas être choisi. Choisissez-en un autre.")
                }
            } else {
                print("Choix invalide. Essayez encore.")
            }
        }
    }


    func chooseAction(for character: Character) -> String {
        while true {
            print("1. Attaquer")
            if character is Magus {
                print("2. Soigner")
            }
            if let choice = readLine(), (choice == "1" || (choice == "2" && character is Magus)) {
                return choice
            } else {
                print("Choix invalide. Essayez encore.")
            }
        }
    }

    func playerAction(team: Team, opponentTeam: Team) -> () -> Void {
        let chosenCharacter = self.selectCharacter(from: team, with: "\(team.name), choisissez un personnage de votre équipe:")
        let action = self.chooseAction(for: chosenCharacter)
        
        return {
            if action == "1" {
                let target = self.selectCharacter(from: opponentTeam, with: "\(team.name), choisissez un personnage à attaquer dans l'équipe adverse:")
                chosenCharacter.attack(target: target)
                print("\(chosenCharacter.name) a attaqué \(target.name)!")
            } else if action == "2" {
                let target = self.selectCharacter(from: team, with: "\(team.name), choisissez un personnage à soigner dans votre équipe:", excluding: chosenCharacter)
                if let magus = chosenCharacter as? Magus {
                    magus.heal(target: target)
                    print("\(magus.name) a soigné \(target.name)!")
                }
            }
        }
    }
    func start() {
        initializeGame()
        displayTeams()
        fight()
    }
}
