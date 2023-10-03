//
//  Creature.swift
//  Arcade
//
//  Created by Denis Abramov on 24.09.2023.
//

import UIKit

class Creature {
    var attack: Int
    var defense: Int
    var health: Int
    
    var damageRange: ClosedRange<Int>
    
    var info = ""
    
    init(attack: Int, defense: Int, health: Int, damageRange: ClosedRange<Int>) {
        self.attack = max(1, min(attack, 30))
        self.defense = max(1, min(defense, 30))
        self.health = max(0, health)
        self.damageRange = damageRange
    }
    
    func heal() {
        let maxHealth = 30
        let healAmount = Int(Double(maxHealth) * 0.3)
        health = min(maxHealth, health + healAmount)
    }
    
    /// Нанесённый урон
    /// - Parameter amount: суммарный урон
    private func takeDamage(amount: Int) {
        health = max(0, health - amount)
    }
    
    /// Рассчёт атаки
    /// - Parameter defender: защита
    /// - Returns: количество урона
    private func calculateAttackModifier(defender: Creature) -> Int {
        return attack - defender.defense + 1
    }
    
    func performAttack(target: Creature) {
        let diceRoll = Int.random(in: 1...6)
        let attackModifier = calculateAttackModifier(defender: target)
        
        if diceRoll <= attackModifier {
            let damage = Int.random(in: 1...6)
            target.takeDamage(amount: damage)
            info = "Удар успешен! Нанесено \(damage) урона"
        } else {
            info = "Удар неудачен"
        }
    }
}
