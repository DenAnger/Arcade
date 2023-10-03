//
//  ViewController.swift
//  Arcade
//
//  Created by Denis Abramov on 24.09.2023.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UI Elements
    @IBOutlet private var playerHealthLabel: UILabel!
    @IBOutlet private var monsterHealthLabel: UILabel!
    
    @IBOutlet private var healButton: UIButton!
    
    @IBOutlet private var attackTheMonsterButton: UIButton!
    @IBOutlet private var attackThePlayerButton: UIButton!
    
    @IBOutlet private var infoView: UIView!
    @IBOutlet private var infoLabel: UILabel!
    
    // MARK: - Properties
    private var player = Player(attack: 10, defense: 5, health: 10, damageRange: 1...6)
    private var monster = Monster(attack: 8, defense: 4, health: 15, damageRange: 1...6)
    
    private var gameEnded = false
    private var healCount = 0
    
    private var isMonsterButtonActive = true

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        infoView.layer.cornerRadius = 10
    }
    
    // MARK: - Actions
    @IBAction func healPlayer() {
        
        if !gameEnded && healCount < 4 {
            healCount += 1
            player.healSelf()
            updateHealthLabels()
            checkGameStatus()
            infoLabel.text = player.info
        }
        
        if healCount == 4 {
            healButton.isEnabled = false
        }
    }
    
    @IBAction func attackTheMonster() {
        
        if !gameEnded {
            player.attackPlayer(player: monster)
            updateHealthLabels()
            checkGameStatus()

            attackTheMonsterButton.isEnabled = false
            attackThePlayerButton.isEnabled = true
            isMonsterButtonActive = false
            infoLabel.text = player.info
        }
    }
    
    @IBAction func attackThePlayer() {
        
        if !gameEnded {
            monster.attackPlayer(player: player)
            updateHealthLabels()
            checkGameStatus()
            
            attackThePlayerButton.isEnabled = false
            attackTheMonsterButton.isEnabled = true
            
            isMonsterButtonActive = true
            infoLabel.text = monster.info
            
            if healCount == 4 {
                healButton.isEnabled = false
            } else {
                healButton.isEnabled = true
            }
        }
    }
    
    // MARK: - Methods
    private func updateHealthLabels() {
        playerHealthLabel.text = "\(player.health) хп"
        monsterHealthLabel.text = "\(monster.health) хп"
    }
    
    private func checkGameStatus() {
        let title: String
        
        if player.health == 0 {
            title = "Выиграл Монстр."
            gameEnded = true
            infoView.isHidden = true
            alertNewGame(title: title)
        } else if monster.health == 0 {
            title = "Выиграл Игрок."
            gameEnded = true
            infoView.isHidden = true
            alertNewGame(title: title)
        }
    }
    
    private func alertNewGame(title: String) {
        let alert = UIAlertController(title: "Игра окончена. \(title)",
                                      message: "Начать новую игру?",
                                      preferredStyle: .alert)
        let startNewGameAction = UIAlertAction(title: "Начать",
                                               style: .default) { (action) in
            self.startNewGame()
        }
        
        alert.addAction(startNewGameAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func startNewGame() {
        player = Player(attack: 10, defense: 5, health: 30, damageRange: 1...6)
        monster = Monster(attack: 8, defense: 4, health: 55, damageRange: 1...6)
        updateHealthLabels()
        gameEnded = false
        
        infoLabel.text = "Нажмите \"Атаковать\", чтобы начать игру"
        
        attackTheMonsterButton.isEnabled = true
        attackThePlayerButton.isEnabled = false
        healButton.isEnabled = false
        infoView.isHidden = false
    }
}
