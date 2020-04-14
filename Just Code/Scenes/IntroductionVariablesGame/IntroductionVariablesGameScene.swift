//
//  IntroductionVariablesGameScene.swift
//  Just Code
//
//  Created by Ganang Arief Pratama on 14/04/20.
//  Copyright © 2020 CodeFun. All rights reserved.
//

import SpriteKit

class IntroductionVariablesGameScene: SKScene {
    
    var startButton: SKSpriteNode!

    override func didMove(to view: SKView) {
        self.view?.isUserInteractionEnabled = true
        backgroundColor = .black
    
        startButton = self.childNode(withName: "StartButton") as? SKSpriteNode
    }
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let touch = touches.first
            
            if let location = touch?.location(in: self) {
                let nodesArray = self.nodes(at: location)
                
                if nodesArray.first?.name == "StartButton" {
                    let transition = SKTransition.flipVertical(withDuration: 0.5)
                    let variablesGameScene = VariablesGameScene(size: frame.size)
    
                    self.view?.presentScene(variablesGameScene, transition: transition)
                
            }
        }
    }
}
