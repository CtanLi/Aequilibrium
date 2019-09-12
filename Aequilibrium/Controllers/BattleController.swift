//
//  BattleController.swift
//  Aequilibrium
//
//  Created by CtanLI on 2019-09-11.
//  Copyright © 2019 aequilibrium. All rights reserved.
//

import UIKit

class BattleController: UIViewController {

    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player2Image: UIImageView!
    @IBOutlet weak var winnersView: UILabel!
    
    
    var fighters = [TransformerViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        battleScene()
        winnersView.text = checkWinner()
    }
    
    func battleScene() {
        if let firstImage = fighters.first?.tvm.team_icon, let secondImage = fighters.last?.tvm.team_icon {
            player1Image.loadImageUsingCacheWithURLString(urlString: firstImage)
            player2Image.loadImageUsingCacheWithURLString(urlString: secondImage)
        }
    }
    
    func checkWinner() -> String  {
        if let player1Courage = fighters.first?.tvm.courage, let player2Courage = fighters.last?.tvm.courage, let player1Strength = fighters.first?.tvm.strength, let player2Strength = fighters.last?.tvm.strength, let player1Skill = fighters.first?.tvm.skill, let player2Skill = fighters.last?.tvm.skill, let player1Intelligence = fighters.first?.tvm.intelligence, let player2Intelligence = fighters.last?.tvm.intelligence, let player1Speed = fighters.first?.tvm.speed, let player2Speed = fighters.last?.tvm.speed, let player1Endurance = fighters.first?.tvm.endurance, let player2Endurance = fighters.last?.tvm.endurance, let player1Firepower = fighters.first?.tvm.firepower, let player2Firepower = fighters.last?.tvm.firepower {
            
            let maxCourage = max(player1Courage, player2Courage)
            let maxSkill = max(player1Skill, player2Skill)

            let couragePoints = abs(player1Courage - player2Courage)
            let strengthPoints = abs(player1Strength - player2Strength)
            let skillPoints = abs(player1Skill - player2Skill)
            
            //
            //Special rules
            //
            if fighters.first?.tvm.name == "Optimus Prime" || fighters.last?.tvm.name == "Optimus Prime" {
                return "Optimus Prime"
            }
            
            if fighters.first?.tvm.name == "Optimus Prime" && fighters.last?.tvm.name == "Predaking" {
                return "Transformers Destroyed"
            }
            
            //
            // Checking for the transformer based on points lost on courage and strenght 
            //
            if couragePoints >= 4 && strengthPoints >= 3 {
                if maxCourage == player1Courage {
                    return fighters.first?.tvm.name ?? ""
                } else {
                    return fighters.last?.tvm.name ?? ""
                }
            }
            
            //
            // Checking for the transformer with highest skill point
            //
            if skillPoints >= 3 {
                if maxSkill == player1Skill {
                    return fighters.first?.tvm.name ?? ""
                } else {
                    return fighters.last?.tvm.name ?? ""
                }
            }
            
            //
            // Checking for a tie and highest overall rating
            //
            let player1OverrallRanking = player1Strength + player1Intelligence + player1Speed + player1Endurance + player1Firepower
            let player2OverrallRanking = player2Strength + player2Intelligence + player2Speed + player2Endurance + player2Firepower
            if player1OverrallRanking == player2OverrallRanking {
                return "Transformers Destroyed"
            } else if player1OverrallRanking > player2OverrallRanking {
                return fighters.first?.tvm.name ?? ""
            } else {
                return fighters.last?.tvm.name ?? ""
            }
        }
        return String()
    }
}
