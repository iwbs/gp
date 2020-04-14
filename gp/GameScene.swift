//
//  GameScene.swift
//  gp
//
//  Created by devops on 11/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
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
        
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addRandomCircle), userInfo: nil, repeats: true)
        
        
        //        addCircle(position: CGPoint(x: 0, y: 0), type: Circle.red)
        addBezier(position: CGPoint(x: 0, y: 0))
        
    }
    
    enum Circle: CaseIterable {
        case red, green, yellow
    }
    
    @objc func addRandomCircle() {
        addCircle(position: CGPoint(x: Int.random(in: -300...300), y: Int.random(in: -300...300)), type: Circle.allCases.randomElement()!)
    }
    
    func addCircle(position: CGPoint, type: Circle){
        // stroke part
        var scaleDuration:TimeInterval
        var strokeColor:SKColor
        switch type {
        case .red:
            scaleDuration = 1
            strokeColor = SKColor(red:215/255, green:30/255, blue:30/255, alpha: 1)
        case .yellow:
            scaleDuration = 1.15
            strokeColor = SKColor(red:235/255, green:235/255, blue:30/255, alpha: 1)
        case .green:
            scaleDuration = 1.3
            strokeColor = SKColor(red:30/255, green:235/255, blue:30/255, alpha: 1)
        }
        
        let uuid = UUID().uuidString
        
        let stroke:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(200))
        stroke.name = "stroke|\(uuid)"
        stroke.position = position
        stroke.lineWidth = CGFloat(7)
        stroke.strokeColor = strokeColor
        stroke.zPosition = 1
        stroke.run(SKAction.sequence([SKAction.scale(by: CGFloat(0.24), duration: scaleDuration),
                                      SKAction.removeFromParent()]))
        self.addChild(stroke)
        
        
        // fill part
        let fill:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(50))
        fill.name = "fill|\(uuid)"
        fill.position = position
        fill.lineWidth = CGFloat(7)
        fill.fillColor = strokeColor
        fill.zPosition = 2
        fill.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration), SKAction.removeFromParent()]))
        self.addChild(fill)
        
    }
    
    func addBezier(position: CGPoint) {
        let uuid = UUID().uuidString
        let color = SKColor(red:130/255, green:130/255, blue:255/255, alpha: 1)
        let strokeColor = SKColor(red:30/255, green:30/255, blue:255/255, alpha: 1)
        let ballColor = SKColor(red:30/255, green:30/255, blue:255/255, alpha: 0.5)
        let startPoint = CGPoint(x:50, y:300)
        let endPoint = CGPoint(x:300, y:300)
        let controlPoint = CGPoint(x:170, y:200)
        let duration:TimeInterval = 1
        let scaleDuration:TimeInterval = 1
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // tube part
        let tube:SKShapeNode = SKShapeNode.init(path: path.cgPath)
        tube.name = "bezier|\(uuid)"
        tube.position = position
        tube.lineWidth = CGFloat(92)
        tube.strokeColor = color
        tube.zPosition = 2
        tube.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration+duration), SKAction.removeFromParent()]))
        self.addChild(tube)
        
        let tubeBorder:SKShapeNode = SKShapeNode.init(path: path.cgPath)
        tubeBorder.name = "bezier|\(uuid)"
        tubeBorder.position = position
        tubeBorder.lineWidth = CGFloat(108)
        tubeBorder.strokeColor = SKColor(red:255/255, green:255/255, blue:255/255, alpha: 1)
        tubeBorder.zPosition = 1
        tubeBorder.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration+duration), SKAction.removeFromParent()]))
        self.addChild(tubeBorder)
        
        // stroker part
        let stroke:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(200))
        stroke.name = "stroke|\(uuid)"
        stroke.position = startPoint
        stroke.lineWidth = CGFloat(7)
        stroke.strokeColor = strokeColor
        stroke.zPosition = 3
        stroke.run(SKAction.sequence([SKAction.scale(by: CGFloat(0.24), duration: scaleDuration),
                                      SKAction.removeFromParent()]))
        self.addChild(stroke)
        
        // start part
        let start:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(50))
        start.name = "start|\(uuid)"
        start.position = startPoint
        start.lineWidth = CGFloat(7)
        start.fillColor = color
        start.zPosition = 3
        start.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration+duration), SKAction.removeFromParent()]))
        self.addChild(start)
        
        // end part
        let end:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(50))
        end.name = "end|\(uuid)"
        end.position = endPoint
        end.lineWidth = CGFloat(7)
        end.fillColor = color
        end.zPosition = 3
        end.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration+duration), SKAction.removeFromParent()]))
        self.addChild(end)
        
        // move part
        let move:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(50))
        move.name = "move|\(uuid)"
        move.lineWidth = CGFloat(7)
        move.fillColor = ballColor
        move.zPosition = 4
        move.run(SKAction.sequence([SKAction.hide(), SKAction.wait(forDuration: scaleDuration), SKAction.unhide(), SKAction.follow(path.cgPath, duration:duration), SKAction.removeFromParent()]))
        self.addChild(move)
    }
    
    //    func touchDown(atPoint pos : CGPoint) {
    //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
    //            n.position = pos
    //            n.strokeColor = SKColor.green
    //            self.addChild(n)
    //        }
    //    }
    //
    //    func touchMoved(toPoint pos : CGPoint) {
    //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
    //            n.position = pos
    //            n.strokeColor = SKColor.blue
    //            self.addChild(n)
    //        }
    //    }
    //
    //    func touchUp(atPoint pos : CGPoint) {
    //        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
    //            n.position = pos
    //            n.strokeColor = SKColor.red
    //            self.addChild(n)
    //        }
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        if let label = self.label {
        //            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        //        }
        //
        //        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        var nodeDict = [String: CGFloat]()
        for t in touches {
            let loc = t.location(in: self)
            let nodesArray = self.nodes(at: loc)
            for node in nodesArray {
                if let circle = node as? SKShapeNode {
                    let nodeName = circle.name!
                    let name = nodeName.components(separatedBy: "|")
                    let isExist = nodeDict[name[1]] != nil
                    if isExist {
                        let diff = circle.calculateAccumulatedFrame().width - nodeDict[name[1]]!
                        if diff < 10 {
                            print("300")
                        } else if diff < 30 {
                            print("100")
                        } else if diff < 50 {
                            print("50")
                        } else {
                            print("too early")
                        }
                        for c in self.children {
                            if (c.name?.hasSuffix(name[1]))!  {
                                c.removeFromParent()
                            }
                        }
                    } else {
                        // must be fill first
                        nodeDict[name[1]] = circle.calculateAccumulatedFrame().width
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        for t in touches { self.touchMov  2ed(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
