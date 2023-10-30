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
    var roundCount: Int = 0  // Compteur de tours
    static var totalDamage: Int = 0  // Compteur de dégâts
    static var totalHealing: Int = 0  // Compteur de soins

    init() {
        self.team1 = Team(name: "Joueur 1")
        self.team2 = Team(name: "Joueur2")
    }

    // Méthode pour initialiser le jeu
    func initializeGame() {
        print("Joueur 1, donnez un nom à votre équipe:")
        if let team1Name = readLine() {
            team1.name = team1Name
        }

        print("Joueur 2, donnez un nom à votre équipe:")
        if let team2Name = readLine() {
            team2.name = team2Name
        }

        print("\(team1.name), composez votre équipe:")
        for _ in 1...3 {
            team1.addMember()
        }

        print("\(team2.name), composez votre équipe:")
        for _ in 1...3 {
            team2.addMember()
        }
    }


    // Méthode pour afficher les équipes
    func displayTeams() {
        print("Équipe du \(team1.name) :")
        team1.displayMembers()
        print("Équipe du \(team2.name):")
        team2.displayMembers()
    }
    func displayTeamHealth(team: Team) {
        print("État de santé de l'équipe :")
        for member in team.members {
            print("\(member.name): \(member.healthPoints) points de vie")
        }
    }
    // Méthode pour gérer le combat
    func fight() {
       
            
            var roundCount = 0  // Compteur de tours
      
        while team1.members.count > 0 && team2.members.count > 0 {
                roundCount += 1  // Incrémente le compteur de tours
                print("Tour \(roundCount)")
            
            // Logique pour le joueur 1
            let actionPlayer1 = playerAction(team: team1, opponentTeam: team2)
            // Exécute l'action
            actionPlayer1()
            displayTeamHealth(team: team1)
            displayTeamHealth(team: team2)
            
            // Vérifie si l'équipe 2 est toujours en vie
            if !team2.teamIsAlive() {
                break
            }
            
            // Logique pour le joueur 2
            let actionPlayer2 = playerAction(team: team2, opponentTeam: team1)
            // Exécute l'action
            actionPlayer2()
            displayTeamHealth(team: team1)
            displayTeamHealth(team: team2)
            
            // Vérifie si l'équipe 1 est toujours en vie
            if !team1.teamIsAlive() {
                break
            }
            
                    }
        // Annonce le gagnant et affiche les statistiques
                displayStats()
        
        // Affiche les statistiques du jeu
         func displayStats() {
             print("Statistiques du jeu :")
             print("Nombre de tours : \(roundCount)")
             print("Dégâts totaux infligés : \(Game.totalDamage)")
             print("Soins totaux : \(Game.totalHealing)")
         }

      

    }
    func playerAction(team: Team, opponentTeam: Team) -> () -> Void {
        print("\(team.name), choisissez un personnage de votre équipe:")
        team.displayMembers()

        var chosenCharacter: Character? = nil
        while chosenCharacter == nil {
            if let choice = readLine(), let choiceInt = Int(choice), choiceInt > 0 && choiceInt <= team.members.count {
                let potentialCharacter = team.members[choiceInt - 1]
                if potentialCharacter.healthPoints > 0 {
                    chosenCharacter = potentialCharacter
                } else {
                    print("Ce personnage est mort. Choisissez-en un autre.")
                }
            } else {
                print("Choix invalide. Essayez encore.")
            }
        }
        
        print("\(team.name),Choisissez une action:")
        print("1. Attaquer")
        print("2. Soigner")
        
        var action: String? = nil
        while action == nil {
            if let choice = readLine() {
                if choice == "1" || choice == "2" {
                    action = choice
                } else {
                    print("Choix invalide. Essayez encore.")
                }
            }
        }
        
        return {

            if action == "1" {
                        // Logique pour attaquer
                        print("\(team.name),Choisissez un personnage à attaquer dans l'équipe adverse:")
                        opponentTeam.displayMembers()

                        var target: Character? = nil
                        while target == nil {
                            if let choice = readLine(), let choiceInt = Int(choice), choiceInt > 0 && choiceInt <= opponentTeam.members.count {
                                let potentialTarget = opponentTeam.members[choiceInt - 1]
                                if potentialTarget.healthPoints > 0 {
                                    target = potentialTarget
                                } else {
                                    print("Ce personnage est mort. Choisissez-en un autre.")
                                }
                            } else {
                                print("Choix invalide. Essayez encore.")
                            }
                        }
                
                chosenCharacter?.attack(target: target!)
                print("\(chosenCharacter!.name) a attaqué \(target!.name)!")
                
            } else {
                // Logique pour soigner
                print("\(team.name),Choisissez un personnage à soigner dans votre équipe:")
                  team.displayMembers()
                  
                  var target: Character? = nil
                  while target == nil {
                      if let choice = readLine(), let choiceInt = Int(choice), choiceInt > 0 && choiceInt <= team.members.count {
                          let potentialTarget = team.members[choiceInt - 1]
                          if potentialTarget.healthPoints > 0 {
                              target = potentialTarget
                          } else {
                              print("Ce personnage est mort. Choisissez-en un autre.")
                          }
                      } else {
                          print("Choix invalide. Essayez encore.")
                      }
                  }
                  
                  if let magus = chosenCharacter as? Magus {
                      magus.heal(target: target!)
                      print("\(magus.name) a soigné \(target!.name)!")
                  } else {
                      print("Ce personnage ne peut pas soigner.")
                  }
              }
        }

    }


    // Méthode pour démarrer le jeu
    func start() {
        initializeGame()
        displayTeams()
        fight()
    }
}
