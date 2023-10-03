//
//  Monster.swift
//  Arcade
//
//  Created by Denis Abramov on 24.09.2023.
//

import UIKit

class Monster: Creature {
    func attackPlayer(player: Player) {
        performAttack(target: player)
    }
    
    override func performAttack(target: Creature) {
        super.performAttack(target: target)
       
        if target.health == 0 {
            info = ""
        }
    }
}
