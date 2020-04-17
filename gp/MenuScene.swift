//
//  MenuScene.swift
//  gp
//
//  Created by devops on 18/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {

    var newGameBtn:SKLabelNode!
    var rankingBtn:SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        newGameBtn = self.childNode(withName: "newGame") as? SKLabelNode
        rankingBtn = self.childNode(withName: "ranking") as? SKLabelNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let loc = t.location(in: self)
            let nodesArray = self.nodes(at: loc)
            if nodesArray.first?.name == "newGame" {
                let transition = SKTransition.fade(withDuration: 1)
                let gameScene = GameScene(size: self.size)
                gameScene.anchorPoint = CGPoint(x:0.5, y:0.5)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
