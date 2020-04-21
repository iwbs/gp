//
//  GameScene.swift
//  gp
//
//  Created by devops on 11/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, AVAudioPlayerDelegate {
    
    var musicNode:SKAudioNode!
    var pauseLabel:SKLabelNode!
    var restartNode:SKLabelNode!
    var quitNode:SKLabelNode!
    var scoreLabel:SKLabelNode!
    var maskNode:SKShapeNode!
    
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var tmpScore:Int = 0
    var audioPlayer: AVAudioPlayer!
    var currentSong:[Key]!

    
    override func didMove(to view: SKView) {
        let url = Bundle.main.url(forResource: "music", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
            audioPlayer.delegate = self
        } catch {
            print("Error:", error.localizedDescription)
        }
        
        pauseLabel = SKLabelNode(text: "Pause")
        pauseLabel.name = "pause"
        pauseLabel.position = CGPoint(x: 300, y: 150)
        pauseLabel.fontName = "DINCondensed-Bold"
        pauseLabel.fontSize = 36
        pauseLabel.fontColor = UIColor.white
        pauseLabel.zPosition = 6
        pauseLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        self.addChild(pauseLabel)
        
        restartNode = SKLabelNode(text: "Restart")
        restartNode.name = "restart"
        restartNode.position = CGPoint(x: 300, y: 100)
        restartNode.fontName = "DINCondensed-Bold"
        restartNode.fontSize = 36
        restartNode.fontColor = UIColor.white
        restartNode.zPosition = 6
        restartNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        restartNode.isHidden = true
        self.addChild(restartNode)
        
        quitNode = SKLabelNode(text: "Quit")
        quitNode.name = "quit"
        quitNode.position = CGPoint(x: 300, y: 50)
        quitNode.fontName = "DINCondensed-Bold"
        quitNode.fontSize = 36
        quitNode.fontColor = UIColor.white
        quitNode.zPosition = 6
        quitNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        quitNode.isHidden = true
        self.addChild(quitNode)
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 0, y: 150)
        scoreLabel.fontName = "DINCondensed-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        self.addChild(scoreLabel)
        
        maskNode = SKShapeNode.init(rect: CGRect(x: 0, y:0, width: self.size.width, height: self.size.height))
        maskNode.name = "mask|mask"
        maskNode.position = CGPoint(x: -self.size.width/2, y:-self.size.height/2)
        maskNode.lineWidth = 0
        maskNode.fillColor = SKColor(red:0, green:0, blue:0, alpha: 0.5)
        maskNode.zPosition = 5
        maskNode.isHidden = true
        self.addChild(maskNode)
        
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
        
        audioPlayer.play()
    }
    
    func addScore(_ score: Int) {
        self.score += score
    }
    
    func playHitSound() {
        self.run(SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false))
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        audioPlayer.stop()
        let transition = SKTransition.fade(withDuration: 1)
        let finishScene = FinishScene(fileNamed: "FinishScene")
        finishScene!.size = self.size
        finishScene!.anchorPoint = CGPoint(x:0.5, y:0.5)
        finishScene!.score = score
        self.view?.presentScene(finishScene!, transition: transition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var nodeDict = [String: CGFloat]()
        for t in touches {
            let loc = t.location(in: self)
            let nodesArray = self.nodes(at: loc)
            for node in nodesArray {
                if let circle = node as? SKShapeNode, let nodeName = circle.name {
                    if !self.isPaused {
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
                }
                else if let label = node as? SKLabelNode, let nodeName = label.name {
                    if nodeName == "pause" {
                        if self.isPaused {
                            // magic
                            audioPlayer.currentTime -= 0.01
                            audioPlayer.play()
                            self.isPaused = false
                            maskNode.isHidden = true
                            restartNode.isHidden = true
                            quitNode.isHidden = true
                        } else {
                            audioPlayer.pause()
                            self.isPaused = true
                            maskNode.isHidden = false
                            restartNode.isHidden = false
                            quitNode.isHidden = false
                        }
                    } else if nodeName == "restart" {
                        let transition = SKTransition.fade(withDuration: 1)
                        let gameScene = GameScene(fileNamed: "GameScene")
                        gameScene!.size = self.size
                        gameScene!.anchorPoint = CGPoint(x:0.5, y:0.5)
                        self.view?.presentScene(gameScene!, transition: transition)
                    } else if nodeName == "quit" {
                        let transition = SKTransition.fade(withDuration: 1)
                        let menuScene = MenuScene(fileNamed: "MenuScene")
                        menuScene!.size = self.size
                        menuScene!.anchorPoint = CGPoint(x:0.5, y:0.5)
                        self.view?.presentScene(menuScene!, transition: transition)
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isPaused {
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
                                    } else {
                                        NodeUtil.addScoreNode(scene: self, position: circle.position, score: "Miss")
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
    }
}
