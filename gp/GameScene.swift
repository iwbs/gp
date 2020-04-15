//
//  GameScene.swift
//  gp
//
//  Created by devops on 11/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit
//import GameplayKit

class GameScene: SKScene {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    private var gameTimer:Timer!
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        //        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        //        if let label = self.label {
        //            label.alpha = 0.0
        //            label.run(SKAction.fadeIn(withDuration: 2.0))
        //        }
        
        // Create shape node to use during mouse interaction
        //        let w = (self.size.width + self.size.height) * 0.05
        //        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        //
        //        if let spinnyNode = self.spinnyNode {
        //            spinnyNode.lineWidth = 2.5
        //
        //
        //
        //            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
        //            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
        //                                              SKAction.fadeOut(withDuration: 0.5),
        //                                              SKAction.removeFromParent()]))
        //        }
        

        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 0, y: 150)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        score = 0
        
//        self.scaleMode = SKSceneScaleMode.resizeFill
        self.addChild(scoreLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addRandomCircle), userInfo: nil, repeats: true)
        
        
        //        addCircle(position: CGPoint(x: 0, y: 0), type: Circle.red)
        Util.addBezier(scene: self, position: CGPoint(x:0, y:0))
        
    }

    
    @objc func addRandomCircle() {
        Util.addCircle(scene: self, position: CGPoint(x: Int.random(in: -250...250), y: Int.random(in: -150...150)), type: Circle.allCases.randomElement()!)
    }
    
    func addScore(_ score: Int) {
        self.score += score
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
                if let circle = node as? SKShapeNode {
                    let nodeName = circle.name!
                    let name = nodeName.components(separatedBy: "|")
                    let type = name[0]
                    let uuid = name[1]
                    let isExist = nodeDict[uuid] != nil
                    if isExist {
                        let diff = circle.calculateAccumulatedFrame().width - nodeDict[uuid]!
                        if type == "stroke" {
                            if diff < 10 {
                                addScore(300)
                            } else if diff < 30 {
                                addScore(100)
                            } else if diff < 50 {
                                addScore(50)
                            } else {
                                print("too early")
                            }
                            for c in self.children {
                                if let nodeName = c.name, nodeName.hasSuffix(uuid) {
                                    c.removeFromParent()
                                }
                            }
                        }
                        if type == "startStroke" {
                            if diff < 10 {
                                addScore(300)
                            } else if diff < 30 {
                                addScore(100)
                            } else if diff < 50 {
                                addScore(50)
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
            for node in nodesArray {
                if let circle = node as? SKShapeNode {
                    let nodeName = circle.name!
                    let name = nodeName.components(separatedBy: "|")
                    let type = name[0]
                    if type == "move" {
                        addScore(5)
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
