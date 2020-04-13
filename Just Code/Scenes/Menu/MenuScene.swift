//
//  MenuScene.swift
//  Just Code
//
//  Created by Ganang Arief Pratama on 10/04/20.
//  Copyright © 2020 CodeFun. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {

    var variablesButton: SKSpriteNode!
    var loopsButton: SKSpriteNode!
    var coursesLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        self.view?.isUserInteractionEnabled = true
        
        coursesLabel = self.childNode(withName: "coursesLabel") as? SKLabelNode
        variablesButton = self.childNode(withName: "variablesButton") as? SKSpriteNode
        loopsButton = self.childNode(withName: "loopsButton") as? SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "variablesButton" {
                let transition = SKTransition.flipVertical(withDuration: 0.5)
                let variablesGameScene = VariablesGameScene(size: frame.size)
                
                self.view?.presentScene(variablesGameScene, transition: transition)
            }
            
        }
    }
}
