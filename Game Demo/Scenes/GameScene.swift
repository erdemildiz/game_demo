//
//  GameScene.swift
//  Game Demo
//
//  Created by Erdem ILDIZ on 28.12.2020.
//

import SpriteKit

struct PlayColors {
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
    ]
}

enum SwitchState: Int {
    case red, yellow, green, blue
}

struct GamePersistent {
    
    @Storage(key: "recentScore", defaultValue: 0)
    static var score
    
    @Storage(key: "hightScore", defaultValue: 0)
    static var highScore
}

class GameScene: SKScene {
    
    // Values
    var switchState: SwitchState = .red
    var currentColorIndex: Int?
    var score = 0
    
    // Nodes
    lazy var colorSwitch: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "ColorCircle")
        node.size = .init(width: frame.width / 3, height: frame.width / 3)
        node.position = .init(x: frame.midX, y: frame.minY + node.frame.height)
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        node.zPosition = ZPosition.colorSwitch
        return node
    }()
    lazy var spawnBall: SKSpriteNode = {
        let node = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: .clear, size: .init(width: 30, height: 30))
        node.position = .init(x: frame.midX, y: frame.maxY)
        node.colorBlendFactor = 1
        node.name = "Ball"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        node.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        node.physicsBody?.collisionBitMask = PhysicsCategories.none
        node.zPosition = ZPosition.ball
        return node
    }()
    lazy var scoreLabel: SKLabelNode = {
        let label = SKLabelNode()
        label.fontSize = 60
        label.color = .white
        label.position = .init(x: frame.midX, y: frame.midY)
        label.zPosition = ZPosition.label
        return label
    }()
    lazy var scoreSound: SKAudioNode = {
        let audio = SKAudioNode(fileNamed: "bling")
        audio.autoplayLooped = false
        return audio
    }()
    
    override func didMove(to view: SKView) {
    
        setupPhysics()
        setupScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        turnWheel()
    }
    
    func setupPhysics() {
        updateBall()
        updateScore()
        physicsWorld.gravity = .init(dx: 0, dy: -1.0)
        physicsWorld.contactDelegate = self
    }
    
    func setupScene() {
        backgroundColor = AppSetting.stageBgColor
        addChild(colorSwitch)
        addChild(spawnBall)
        addChild(scoreLabel)
        addChild(scoreSound)
    }
    
    func updateBall() {
        currentColorIndex = Int.random(in: 0..<4)
        spawnBall.color = PlayColors.colors[currentColorIndex!]
    }
    
    func updateScore() {
        scoreLabel.text = "Score: \(score)"
    }
    
    func turnWheel() {
        if let newState = SwitchState(rawValue: switchState.rawValue + 1) {
            switchState = newState
        } else {
            switchState = .red
        }
        
        colorSwitch.run(.rotate(byAngle: .pi / 2, duration: 0.25))
    }
    
    func gameOver() {
        let menuScene = MenuScene(size: view!.bounds.size)
        GamePersistent.score = score
        GamePersistent.highScore = score > GamePersistent.highScore ? score : GamePersistent.highScore
        view!.presentScene(menuScene)
    }
}


extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                if currentColorIndex == switchState.rawValue {
                    scoreSound.run(.play())
                    score += 10
                    updateScore()
                    ball.run(.fadeOut(withDuration: 0.25)) {
                        self.updateBall()
                        ball.alpha = 1
                        ball.run(.move(to: .init(x: self.frame.midX, y: self.frame.maxY), duration: 0))
                    }
                } else {
                    gameOver()
                }
            }
        }
    }
}
