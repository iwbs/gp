//
//  MenuScene.swift
//  gp
//
//  Created by devops on 18/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit

class RankingScene: SKScene {

    var scoreBtn = [SKLabelNode]()
    
    override func didMove(to view: SKView) {
        for n in 0...9 {
            scoreBtn.append(self.childNode(withName: "score\(n)") as! SKLabelNode)
        }

        let defaults = UserDefaults.standard
        let ranking = defaults.array(forKey: "ranking") as? [Int] ?? [Int]()
        for (idx, r) in ranking.enumerated() {
            scoreBtn[idx].text = "\(idx+1). \(r)"
        }
        
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(addRandomCircle), userInfo: nil, repeats: true)
    }
    
    @objc func addRandomCircle() {
        NodeUtil.addFadingCircle(scene: self)
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
