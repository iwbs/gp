//
//  FinishScene.swift
//  gp
//
//  Created by devops on 18/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit

class FinishScene: SKScene {

    var scoreLbl:SKLabelNode!
    var backBtn:SKLabelNode!
    var score:Int = 0
    
    override func didMove(to view: SKView) {
        scoreLbl = self.childNode(withName: "score") as? SKLabelNode
        scoreLbl.text = "\(score)"
        backBtn = self.childNode(withName: "back") as? SKLabelNode
        
        // update ranking
        if score > 0 {
            let defaults = UserDefaults.standard
            var ranking = defaults.array(forKey: "ranking") as? [Int] ?? [Int]()
            ranking.append(score)
            ranking = Array(ranking.sorted().reversed())
            if ranking.count > 10 {
                ranking.remove(at: 10)
            }
            defaults.set(ranking, forKey: "ranking")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let loc = t.location(in: self)
            let nodesArray = self.nodes(at: loc)
            if nodesArray.first?.name == "back" {
                let transition = SKTransition.fade(withDuration: 1)
                let menuScene = MenuScene(fileNamed: "MenuScene")
                menuScene!.size = self.size
                menuScene!.anchorPoint = CGPoint(x:0.5, y:0.5)
                self.view?.presentScene(menuScene!, transition: transition)
            }
        }
    }
}
