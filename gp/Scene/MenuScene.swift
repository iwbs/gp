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
        // preload sound
        SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
        SKAction.playSoundFileNamed("music.mp3", waitForCompletion: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let loc = t.location(in: self)
            let nodesArray = self.nodes(at: loc)
            let nodeName = nodesArray.first?.name
            if nodeName == "newGame" {
                let transition = SKTransition.fade(withDuration: 1)
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene!.size = self.size
                gameScene!.anchorPoint = CGPoint(x:0.5, y:0.5)
                self.view?.presentScene(gameScene!, transition: transition)
            } else if nodeName == "ranking" {
                let transition = SKTransition.fade(withDuration: 1)
                let rankingScene = RankingScene(fileNamed: "RankingScene")
                rankingScene!.size = self.size
                rankingScene!.anchorPoint = CGPoint(x:0.5, y:0.5)
                self.view?.presentScene(rankingScene!, transition: transition)
            }
        }
    }
}
