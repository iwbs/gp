//
//  GameScene.swift
//  gp
//
//  Created by devops on 11/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var tmpScore:Int = 0
    
    private var gameTimer:Timer!
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        //        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        //        if let label = self.label {
        //            label.alpha = 0.0
        //            label.run(SKAction.fadeIn(withDuration: 2.0))
        //        }

        SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 0, y: 150)
        scoreLabel.fontName = "DINCondensed-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        self.addChild(scoreLabel)
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addRandomCircle), userInfo: nil, repeats: true)
        Util.addBezier(scene: self, position: CGPoint(x:0, y:0))
    }

    
    @objc func addRandomCircle() {
        Util.addCircle(scene: self, position: CGPoint(x: Int.random(in: -250...250), y: Int.random(in: -150...150)), type: Circle.allCases.randomElement()!)
    }
    
    func addScore(_ score: Int) {
        self.score += score
    }
    
    func playHitSound() {
        self.run(SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        if let label = self.label {
        //            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        //        }
        var nodeDict = [String: CGFloat]()
        for t in touches {
            let loc = t.location(in: self)
            let nodesArray = self.nodes(at: loc)
            for node in nodesArray {
                if let circle = node as? SKShapeNode, let nodeName = circle.name {
                    let name = nodeName.components(separatedBy: "|")
                    let type = name[0]
                    let uuid = name[1]
                    let isExist = nodeDict[uuid] != nil
                    if isExist {
                        let diff = circle.calculateAccumulatedFrame().width - nodeDict[uuid]!
                        if type == "stroke" {
                            if diff < 10 {
                                Util.addScoreNode(scene: self, position: circle.position, score: "300")
                                addScore(300)
                                playHitSound()
                            } else if diff < 30 {
                                Util.addScoreNode(scene: self, position: circle.position, score: "100")
                                addScore(100)
                                playHitSound()
                            } else if diff < 50 {
                                Util.addScoreNode(scene: self, position: circle.position, score: "50")
                                addScore(50)
                                playHitSound()
                            } else {
                                Util.addScoreNode(scene: self, position: circle.position, score: "Miss")
                            }
                            for c in self.children {
                                if let nodeName = c.name, nodeName.hasSuffix(uuid) {
                                    c.removeFromParent()
                                }
                            }
                        }
                        
                        if type == "startStroke" {
                            if diff < 10 {
                                tmpScore = 300;
                            } else if diff < 30 {
                                tmpScore = 100;
                            } else if diff < 50 {
                                tmpScore = 50;
                            }
                        }
                    } else {
                        if type == "fill" || type == "start" {
                            nodeDict[uuid] = circle.calculateAccumulatedFrame().width
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let loc = t.location(in: self)
            let nodesArray = self.nodes(at: loc)
            var movePosition:CGPoint = CGPoint(x:0, y:0)
            for node in nodesArray {
                if let circle = node as? SKShapeNode {
                    if let nodeName = circle.name {
                        let name = nodeName.components(separatedBy: "|")
                        let type = name[0]
                        // let uuid = name[1]
                        if type == "move" {
                            movePosition = circle.position
                            addScore(5)
                        }
                        
                        if type == "end" {
                            let diff = Util.getDistance(point1: movePosition, point2: circle.position)
                            if diff <= 3 {
                                print(diff)
                                print(tmpScore)
                                if tmpScore == 300 {
                                    Util.addScoreNode(scene: self, position: circle.position, score: "300")
                                    addScore(300)
                                    playHitSound()
                                } else if tmpScore == 100 {
                                    Util.addScoreNode(scene: self, position: circle.position, score: "100")
                                    addScore(100)
                                    playHitSound()
                                } else if tmpScore == 50 {
                                    Util.addScoreNode(scene: self, position: circle.position, score: "50")
                                    addScore(50)
                                    playHitSound()
                                }
                                tmpScore = 0
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
