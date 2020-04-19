//
//  GameScene.swift
//  gp
//
//  Created by devops on 11/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var musicNode:SKAudioNode!
    var pauseLabel:SKLabelNode!
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var tmpScore:Int = 0
    var audioPlayer: AVAudioPlayer!
    var currentSong:[Key]!

    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        //        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        //        if let label = self.label {
        //            label.alpha = 0.0
        //            label.run(SKAction.fadeIn(withDuration: 2.0))
        //        }

        SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
        
        let url = Bundle.main.url(forResource: "music", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print("Error:", error.localizedDescription)
        }
        
        pauseLabel = SKLabelNode(text: "Pause")
        pauseLabel.name = "pause"
        pauseLabel.position = CGPoint(x: 300, y: 150)
        pauseLabel.fontName = "DINCondensed-Bold"
        pauseLabel.fontSize = 36
        pauseLabel.fontColor = UIColor.white
        self.addChild(pauseLabel)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 0, y: 150)
        scoreLabel.fontName = "DINCondensed-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        self.addChild(scoreLabel)
        
        currentSong = SongUtil.createSong()
        for k in currentSong {
            let addNodeAction = SKAction.run {
                switch (k.type) {
                    case .CIRCLE_RED, .CIRCLE_YELLOW, .CIRCLE_GREEN:
                        NodeUtil.addCircle(scene: self, position: k.position, type: k.type)
                    case .LINE_LEFT, .LINE_RIGHT:
                        NodeUtil.addBezier(scene: self, position: k.position, type: k.type)
                    default:
                        print("default")
                }
            }
            self.run(SKAction.sequence([SKAction.wait(forDuration: k.time), addNodeAction]))
        }
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
                                NodeUtil.addScoreNode(scene: self, position: circle.position, score: "300")
                                addScore(300)
                                playHitSound()
                            } else if diff < 30 {
                                NodeUtil.addScoreNode(scene: self, position: circle.position, score: "100")
                                addScore(100)
                                playHitSound()
                            } else if diff < 50 {
                                NodeUtil.addScoreNode(scene: self, position: circle.position, score: "50")
                                addScore(50)
                                playHitSound()
                            } else {
                                NodeUtil.addScoreNode(scene: self, position: circle.position, score: "Miss")
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
                else if let label = node as? SKLabelNode, let nodeName = label.name {
                    if nodeName == "pause" {
                        if self.isPaused {
                            // magic
                            audioPlayer.currentTime -= 0.02
                            audioPlayer.play()
                            self.isPaused = false
                        } else {
                            audioPlayer.pause()
                            self.isPaused = true
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
                        let uuid = name[1]
                        if type == "move" {
                            movePosition = circle.position
                            addScore(5)
                        }
                        
                        if type == "end" {
                            let diff = NodeUtil.getDistance(point1: movePosition, point2: circle.position)
                            if diff <= 10 {
                                if tmpScore == 300 {
                                    NodeUtil.addScoreNode(scene: self, position: circle.position, score: "300")
                                    addScore(300)
                                    playHitSound()
                                } else if tmpScore == 100 {
                                    NodeUtil.addScoreNode(scene: self, position: circle.position, score: "100")
                                    addScore(100)
                                    playHitSound()
                                } else if tmpScore == 50 {
                                    NodeUtil.addScoreNode(scene: self, position: circle.position, score: "50")
                                    addScore(50)
                                    playHitSound()
                                }
                                for c in self.children {
                                    if let nodeName = c.name, nodeName.hasSuffix(uuid) {
                                        c.removeFromParent()
                                    }
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
