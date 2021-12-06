//
//  MainMenu.swift
//  GameFire
//
//  Created by Никита Коголенок on 3.08.21.
//

import SpriteKit

class MainMenu: SKScene {
    var starfield: SKEmitterNode!
    var newGameButtonNode: SKSpriteNode!
    var levelButtonNode: SKSpriteNode!
    var labelLavelNode: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        starfield = self.childNode(withName: " starfieldAnimate") as? SKEmitterNode
        starfield.advanceSimulationTime(10)
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as? SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "swift_newGameBtn")
        
        levelButtonNode = self.childNode(withName: "levelButton") as? SKSpriteNode
        levelButtonNode.texture = SKTexture(imageNamed: "swift_levelBtn")
        
        labelLavelNode = self.childNode(withName: "labelLevelButton") as? SKLabelNode
        
        let userLevel = UserDefaults.standard
        
        if userLevel.bool(forKey: "hard") {
            labelLavelNode.text = "Сложно"
        } else {
            labelLavelNode.text = "Легко"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "newGameButton" {
                let transition = SKTransition.flipVertical(withDuration: 0.5)
                let gameScene = GameScene(size: UIScreen.main.bounds.size)
                self.view?.presentScene(gameScene, transition: transition)
            } else if nodesArray.first?.name == "levelButton" {
                changeLevel()
            }
        }
    }
    
    func changeLevel() {
        let userLevel = UserDefaults.standard
        
        if labelLavelNode.text == "Легко" {
            labelLavelNode.text = "Сложно"
            
            userLevel.setValue(true, forKey: "hard")
        } else {
            labelLavelNode.text = "Легко"
            userLevel.setValue(false, forKey: "hard")
        }
        
        userLevel.synchronize()
    }
}
