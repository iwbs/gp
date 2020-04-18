//
//  GameScene.swift
//  gp
//
//  Created by devops on 11/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit

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
    
    var timeUntilFire = TimeInterval()
    private var gameTimer:Timer!
    
    var keyTimer = [Timer]()
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        //        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        //        if let label = self.label {
        //            label.alpha = 0.0
        //            label.run(SKAction.fadeIn(withDuration: 2.0))
        //        }

        SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: false)
        
        let musicNode = SKAudioNode(fileNamed: "music.mp3")
        self.musicNode = musicNode
        addChild(self.musicNode)
        
//        self.run(SKAction.playSoundFileNamed("music.mp3", waitForCompletion: false))
        
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
        
        let keys = Util.createSong()
        for k in keys {
            Timer.scheduledTimer(timeInterval: k.time, target: self, selector: #selector(addKey(sender:)), userInfo: k, repeats: false)
        }
        
//        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(addRandomCircle), userInfo: nil, repeats: true)
//        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addRandomCircle), userInfo: nil, repeats: true)
//        Util.addBezier(scene: self, position: CGPoint(x:50, y:50), type: KType.LINE_LEFT)
//        Util.addBezier(scene: self, position: CGPoint(x:-150, y:50), type: KType.LINE_LEFT)
    }

    
    @objc func addRandomCircle() {
//        Util.addCircle(scene: self, position: CGPoint(x: Int.random(in: -250...250), y: Int.random(in: -150...150)), type: Circle.allCases.randomElement()!)
        Util.addCircle(scene: self, position: CGPoint(x: Int.random(in: -250...250), y: Int.random(in: -150...150)), type: KType.CIRCLE_RED)
    }
    
    @objc func addKey(sender: Timer) {
        let key:Key = sender.userInfo as! Key
        switch (key.type) {
            case .CIRCLE_RED, .CIRCLE_YELLOW, .CIRCLE_GREEN:
                Util.addCircle(scene: self, position: key.position, type: key.type)
            case .LINE_LEFT, .LINE_RIGHT:
                Util.addBezier(scene: self, position: key.position, type: key.type)
            default:
                print("default")
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
                else if let label = node as? SKLabelNode, let nodeName = label.name {
                    if nodeName == "pause" {
                        if self.view!.isPaused {
                            self.view!.isPaused = false
//                            gameTimer = Timer.scheduledTimer(timeInterval: timeUntilFire, target: self, selector: #selector(addRandomCircle), userInfo: nil, repeats: false)
                        } else {
                            self.view!.isPaused = true
//                            timeUntilFire = gameTimer.fireDate.timeIntervalSinceNow
//                            gameTimer.invalidate()
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
                            let diff = Util.getDistance(point1: movePosition, point2: circle.position)
                            if diff <= 10 {
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
