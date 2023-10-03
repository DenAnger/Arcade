//
//  Player.swift
//  Arcade
//
//  Created by Denis Abramov on 24.09.2023.
//

import Foundation

class Player: Creature {
    func healSelf() {
        heal()
        info = "Игрок исцелил себя."
    }
    
    func attackPlayer(player: Monster) {
        performAttack(target: player)
    }
    
    override func performAttack(target: Creature) {
        super.performAttack(target: target)
       
        if target.health == 0 {
            info = ""
        }
    }
}
