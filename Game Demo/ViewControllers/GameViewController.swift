//
//  GameViewController.swift
//  Game Demo
//
//  Created by Erdem ILDIZ on 28.12.2020.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            //            if let scene = SKScene(fileNamed: "MyTileScene") {
            //                // Set the scale mode to scale to fit the window
            //                scene.scaleMode = .aspectFit
            //                // Present the scene
            //
            //                view.presentScene(scene)
            //                view.ignoresSiblingOrder = true
            //                view.showsFPS = true
            //                view.showsNodeCount = true
            //                view.showsPhysics = true
            //            }
            let scene = MenuScene(size: view.frame.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
        
        
    }
    
}
