//
//  VariablesGameScene.swift
//  Just Code
//
//  Created by Ganang Arief Pratama on 10/04/20.
//  Copyright © 2020 CodeFun. All rights reserved.
//

import SpriteKit

class VariablesGameScene: SKScene, SKPhysicsContactDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var player: SKSpriteNode!
    var forwardImage: SKSpriteNode!
    var backwardImage: SKSpriteNode!
    var rightImage: SKSpriteNode!
    var leftImage: SKSpriteNode!
    var replayImage: SKSpriteNode!
    var actionsLabel: SKLabelNode!
    var stepsLabel: SKLabelNode!
    var playButton: SKSpriteNode!
    var rectangleImage: SKSpriteNode!
    var rectangleOne: SKSpriteNode!
    var rectangleTwo: SKSpriteNode!
    var rectangleThree: SKSpriteNode!
    var coinOne: SKSpriteNode!
    var coinTwo: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var backButton: SKSpriteNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Coins \(score)"
            checkGame()
        }
    }
    var steps = [String]()
    let playerCategory: UInt32 = 0x1 << 0
    let coinCategory: UInt32 = 0x1 << 1
    var gameTableView = UITableView()
    var isPlaying = false
    var isCorrect = false
    var correctBanner: SKSpriteNode!
    var falseBanner: SKSpriteNode!
    var marioCoin: SKAction!
    var isCoinOne = false
    var isCoinTwo = false
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        let width = self.frame.size.width
        let height = self.frame.size.height
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Coins \(score)")
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = .white
        scoreLabel.fontName = "Avenir Next"
        scoreLabel.position = CGPoint(x: width/2, y: height - 80)
        self.addChild(scoreLabel)
        
        replayImage = SKSpriteNode(imageNamed: "replay")
        replayImage.name = "replay"
        replayImage.position = CGPoint(x: width - 50, y: height - 70)
        replayImage.size = CGSize(width: 25, height: 25)
        self.addChild(replayImage)
        
        backButton = SKSpriteNode(imageNamed: "backButton")
        backButton.name = "backButton"
        backButton.position = CGPoint(x: 50, y: height - 70)
        backButton.size = CGSize(width: 25, height: 25)
        self.addChild(backButton)
        
        actionsLabel = SKLabelNode(text: "ACTIONS")
        actionsLabel.fontSize = 24
        actionsLabel.fontColor = .white
        actionsLabel.fontName = "Avenir Next"
        actionsLabel.position = CGPoint(x: width/4, y: height/4)
        self.addChild(actionsLabel)
        
        forwardImage = SKSpriteNode(imageNamed: "forward")
        forwardImage.name = "forward"
        forwardImage.position = CGPoint(x: width/4 - 30, y: height/4 - 40)
        forwardImage.size = CGSize(width: 50, height: 50)
        self.addChild(forwardImage)
        
        backwardImage = SKSpriteNode(imageNamed: "back")
        backwardImage.name = "backward"
        backwardImage.position = CGPoint(x: width/4 + 30, y: height/4 - 40)
        backwardImage.size = CGSize(width: 50, height: 50)
        self.addChild(backwardImage)
        
        leftImage = SKSpriteNode(imageNamed: "left")
        leftImage.name = "left"
        leftImage.position = CGPoint(x: width/4 - 30, y: height/4 - 120)
        leftImage.size = CGSize(width: 50, height: 50)
        self.addChild(leftImage)
        
        rightImage = SKSpriteNode(imageNamed: "right")
        rightImage.name = "right"
        rightImage.position = CGPoint(x: width/4 + 30, y: height/4 - 120)
        rightImage.size = CGSize(width: 50, height: 50)
        self.addChild(rightImage)
        
        stepsLabel = SKLabelNode(text: "STEPS")
        stepsLabel.fontSize = 24
        stepsLabel.fontColor = .white
        stepsLabel.fontName = "Avenir Next"
        stepsLabel.position = CGPoint(x: width/2 + 80, y: height/4)
        self.addChild(stepsLabel)
        
        playButton = SKSpriteNode(imageNamed: "playButton")
        playButton.name = "play"
        playButton.position = CGPoint(x: width / 2, y: height/4 + playButton.size.height + 20)
        playButton.size = CGSize(width: 140, height: 40)
        self.addChild(playButton)
        
        player = SKSpriteNode(imageNamed: "rodent")
        player.position = CGPoint(x: width / 2, y: height/4 + playButton.size.height + player.size.height + 30)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = coinCategory
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(player)
        
        rectangleOne = SKSpriteNode(imageNamed: "rectangle")
        rectangleOne.position = CGPoint(x: width / 2, y: height/4 + playButton.size.height + player.size.height + 110)
        rectangleOne.zPosition = -5
        rectangleOne.size = CGSize(width: 120, height: 80)
        self.addChild(rectangleOne)
        
        rectangleTwo = SKSpriteNode(imageNamed: "rectangle")
        rectangleTwo.position = CGPoint(x: width / 2, y: height/4 + playButton.size.height + player.size.height + 190)
        rectangleTwo.zPosition = -5
        rectangleTwo.size = CGSize(width: 120, height: 80)
        self.addChild(rectangleTwo)
        
        rectangleThree = SKSpriteNode(imageNamed: "rectangle")
        rectangleThree.position = CGPoint(x: width / 2, y: height/4 + playButton.size.height + player.size.height + 270)
        rectangleThree.zPosition = -5
        rectangleThree.size = CGSize(width: 120, height: 80)
        self.addChild(rectangleThree)
        
        coinOne = SKSpriteNode(imageNamed: "coin")
        coinOne.position = CGPoint(x: width / 2, y: height/4 + playButton.size.height + player.size.height + 190)
        coinOne.zPosition = 0
        coinOne.name = "coin_one"
        coinOne.size = CGSize(width: 50, height: 50)
        coinOne.physicsBody = SKPhysicsBody(rectangleOf: coinOne.size)
        coinOne.physicsBody?.isDynamic = true
        coinOne.physicsBody?.categoryBitMask = coinCategory
        coinOne.physicsBody?.contactTestBitMask = playerCategory
        coinOne.physicsBody?.collisionBitMask = 0
        self.addChild(coinOne)
        
        coinTwo = SKSpriteNode(imageNamed: "coin")
        coinTwo.position = CGPoint(x: width / 2, y: height/4 + playButton.size.height + player.size.height + 270)
        coinTwo.zPosition = 0
        coinTwo.name = "coin_two"
        coinTwo.size = CGSize(width: 50, height: 50)
        coinTwo.physicsBody = SKPhysicsBody(rectangleOf: coinTwo.size)
        coinTwo.physicsBody?.isDynamic = true
        coinTwo.physicsBody?.categoryBitMask = coinCategory
        coinTwo.physicsBody?.contactTestBitMask = playerCategory
        coinTwo.physicsBody?.collisionBitMask = 0
        self.addChild(coinTwo)
        
        // Table setup
        gameTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        gameTableView.frame = CGRect(x: width/2, y: height - 50, width: 180, height: 175)
        gameTableView.backgroundColor = .black
        gameTableView.delegate = self
        gameTableView.dataSource = self
        view.addSubview(gameTableView)
    
        marioCoin = SKAction.playSoundFileNamed("marioCoin.mp3", waitForCompletion: false)
        
        correctBanner = SKSpriteNode(imageNamed: "correctBanner")
        correctBanner.name = "correctBanner"
        correctBanner.position = CGPoint(x: width/2, y: height - 150)
        correctBanner.zPosition = 10
        
        falseBanner = SKSpriteNode(imageNamed: "falseBanner")
        falseBanner.name = "falseBanner"
        falseBanner.position = CGPoint(x: width/2, y: height - 150)
        falseBanner.zPosition = 10
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & playerCategory) != 0 && (secondBody.categoryBitMask & coinCategory) != 0 {
            playerDidCollisionWithCoin(playerNode: firstBody.node as! SKSpriteNode, coinNode: secondBody.node as! SKSpriteNode)
        }
    }
    
    func playerDidCollisionWithCoin(playerNode: SKSpriteNode, coinNode: SKSpriteNode) {
        
        self.run(marioCoin)
        coinNode.removeFromParent()
        if (coinNode.name == "coin_one") {
            isCoinOne = true
        }
        if (coinNode.name == "coin_two") {
            isCoinTwo = true
        }
        score += 10
    }
    
    func playPlayer() {
    
        let animationDuration = 0.7
        var actionArray = [SKAction]()
        var playerY = player.position.y
        var playerX = player.position.x
        
        if (!isPlaying && steps.count != 0) {
            for step in steps {
                if (step == "forward()") {
                    playerY += 80
                    playerX += 0
                    actionArray.append(SKAction.move(to: CGPoint(x: playerX, y: playerY), duration: animationDuration))
                    actionArray.append(SKAction.fadeIn(withDuration: 0.3))
                }
            }
            isPlaying = true
            player.run(SKAction.sequence(actionArray), completion: {
                if (self.isCorrect) {
                    self.showCorrectBanner()
                } else {
                    self.showFalseBanner()
                }
            })
        }
        
    }
    
    func showCorrectBanner() {
        self.addChild(correctBanner)
        isCorrect = false
    }
    
    func showFalseBanner() {
        self.addChild(falseBanner)
        isCorrect = false
    }
    
    func checkGame() {
        if score == 20 {
            isCorrect = true
        }
    }
    
    func resetGame() {
        let height = self.frame.size.height
        
        isPlaying = false
        score = 0
        let move = SKAction.moveTo(y: height/4 + playButton.size.height + player.size.height + 30, duration: 0.7)
        move.timingMode = SKActionTimingMode.easeInEaseOut
        player.run(move, completion: {
            if (self.isCoinOne) {
                self.addChild(self.coinOne)
                self.isCoinOne = false
            }
            if (self.isCoinTwo) {
                self.addChild(self.coinTwo)
                self.isCoinTwo = false
            }
        })
        steps = []
        gameTableView.reloadData()
        correctBanner.removeFromParent()
        falseBanner.removeFromParent()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "play" {
               playPlayer()
            }
            
            if nodesArray.first?.name == "forward" {
                updateTable(direction: "forward()")
            }
            
            if nodesArray.first?.name == "backward" {
                updateTable(direction: "backward()")
            }
            
            if nodesArray.first?.name == "left" {
                updateTable(direction: "left()")
            }
            
            if nodesArray.first?.name == "right" {
                updateTable(direction: "right()")
            }
            
            if nodesArray.first?.name == "replay" {
                resetGame()
            }
            
            if nodesArray.first?.name == "backButton" {
                if let scene = MenuScene(fileNamed: "MenuScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    self.view?.presentScene(scene)
                    self.resetGame()
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let number = indexPath.row + 1
        cell.backgroundColor = .black
        cell.textLabel?.text = "\(number). \(self.steps[indexPath.row])"
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func updateTable(direction: String) {
        self.steps.append(direction)
        self.gameTableView.beginUpdates()
        self.gameTableView.insertRows(at: [IndexPath.init(row: self.steps.count-1, section: 0)], with: .automatic)
        self.gameTableView.endUpdates()
    }

}
