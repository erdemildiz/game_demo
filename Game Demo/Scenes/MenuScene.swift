//
//  MenuScene.swift
//  Game Demo
//
//  Created by Erdem ILDIZ on 1.01.2021.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        setupStage()
    }
    
    func setupStage() {
        backgroundColor = AppSetting.stageBgColor
        addLabel()
        addLogo()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
    
    func addLabel(){
        let playLabel = SKLabelNode(text: "Tap to Play!")
        playLabel.fontSize = 50
        playLabel.color = .white
        playLabel.position = .init(x: frame.midX, y: frame.midY)
        let highScoreLabel = SKLabelNode(text: "Highscore: \(GamePersistent.highScore)")
        highScoreLabel.fontSize = 40
        highScoreLabel.color = .white
        highScoreLabel.position = .init(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height * 4)
        let recentScoreLabel = SKLabelNode(text: "Recent Score: \(GamePersistent.score)")
        recentScoreLabel.fontSize = 40
        recentScoreLabel.color = .white
        recentScoreLabel.position = .init(x: frame.midX, y: highScoreLabel.position.y - recentScoreLabel.frame.size.height * 2)
        addChild(playLabel)
        addChild(highScoreLabel)
        addChild(recentScoreLabel)
        animate(label: playLabel)
        
    }
    
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = .init(width: frame.size.width / 4, height: frame.size.width / 4)
        logo.position = .init(x: frame.midX, y: frame.midY + frame.size.height / 4)
        addChild(logo)
    }
    
    func animate(label: SKLabelNode) {
        label.run(.repeatForever(.sequence([
            .scale(by: 1.1, duration: 0.5),
            .scale(by: 0.9, duration: 0.5)
        ])))
    }

}

