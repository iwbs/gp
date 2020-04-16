//
//  Util.swift
//  gp
//
//  Created by devops on 15/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit

class Util {
    
    class func addScore(scene: SKScene, position: CGPoint, score: String) {
        var color:SKColor
        switch score {
        case "300":
            color = SKColor(red:255/255, green:128/255, blue:0/255, alpha: 0.8)
        case "100":
            color = SKColor(red:0/255, green:204/255, blue:0/255, alpha: 0.8)
        case "50":
            color = SKColor(red:204/255, green:0/255, blue:204/255, alpha: 0.8)
        default:
            color = SKColor(red:128/255, green:128/255, blue:128/255, alpha: 0.8)
        }
        
        let mark:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(45))
        mark.position = position
        mark.lineWidth = CGFloat(5)
        mark.fillColor = color
        mark.zPosition = 4
        let scaleAction = SKAction.scale(by: CGFloat(1.4), duration: 0.4)
        let fadeAction = SKAction.fadeOut(withDuration: 0.4)
        mark.run(SKAction.sequence([SKAction.group([scaleAction, fadeAction]), SKAction.removeFromParent()]))
        scene.addChild(mark)
        
        let scoreLabel = SKLabelNode(text: score)
        scoreLabel.position = CGPoint(x: position.x, y: position.y - 16)
        scoreLabel.fontName = "HelveticaNeue"
        scoreLabel.fontSize = 34
        scoreLabel.zPosition = 5
        scoreLabel.fontColor = UIColor.white
        scoreLabel.run(SKAction.sequence([SKAction.group([scaleAction, fadeAction]), SKAction.removeFromParent()]))
        scene.addChild(scoreLabel)
    }
    
    class func addCircle(scene: SKScene, position: CGPoint, type: Circle){
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
        
        let stroke:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(160))
        stroke.name = "stroke|\(uuid)"
        stroke.position = position
        stroke.strokeColor = strokeColor
        stroke.zPosition = 1
        //        stroke.run(SKAction.sequence([SKAction.scale(by: CGFloat(0.24), duration: scaleDuration),
        //                                      SKAction.removeFromParent()]))
        let initialLineWidth = CGFloat(3)
        let scale = CGFloat(0.25)
        let finalLineWidth = initialLineWidth / scale
        let animationDuration = scaleDuration
        let scaleAction = SKAction.scale(by: scale, duration: animationDuration)
        let lineWidthAction = SKAction.customAction(withDuration: animationDuration) { (shapeNode, time) in
            if let shape = shapeNode as? SKShapeNode {
                let progress = time / CGFloat(animationDuration)
                shape.lineWidth = initialLineWidth + progress * (finalLineWidth - initialLineWidth)
            }
        }
        let missAction = SKAction.run({
            addScore(scene: scene, position: position, score: "Miss")
        })
        let group = SKAction.sequence([SKAction.group([scaleAction, lineWidthAction]), SKAction.removeFromParent(), missAction])
        stroke.run(group)
        scene.addChild(stroke)
        
        
        // fill part
        let fill:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(40))
        fill.name = "fill|\(uuid)"
        fill.position = position
        fill.lineWidth = CGFloat(5)
        fill.fillColor = strokeColor
        fill.zPosition = 2
        fill.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration), SKAction.removeFromParent()]))
        scene.addChild(fill)
        
    }
    
    class func addBezier(scene: SKScene, position: CGPoint) {
        let uuid = UUID().uuidString
        let color = SKColor(red:130/255, green:130/255, blue:255/255, alpha: 1)
        let strokeColor = SKColor(red:30/255, green:30/255, blue:255/255, alpha: 1)
        let ballColor = SKColor(red:30/255, green:30/255, blue:255/255, alpha: 0.5)
        let startPoint = CGPoint(x: position.x - 150, y: position.y)
        let endPoint = CGPoint(x: position.x + 150, y: position.y)
        let controlPoint = CGPoint(x: position.x, y: position.y - 100)
        let duration:TimeInterval = 1
        let scaleDuration:TimeInterval = 1
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // tube part
        let tube:SKShapeNode = SKShapeNode.init(path: path.cgPath)
        tube.name = "bezier|\(uuid)"
        tube.position = position
        tube.lineWidth = CGFloat(75)
        tube.strokeColor = color
        tube.zPosition = 2
        tube.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration+duration), SKAction.removeFromParent()]))
        scene.addChild(tube)
        
        let tubeBorder:SKShapeNode = SKShapeNode.init(path: path.cgPath)
        tubeBorder.name = "bezier|\(uuid)"
        tubeBorder.position = position
        tubeBorder.lineWidth = CGFloat(85)
        tubeBorder.strokeColor = SKColor(red:255/255, green:255/255, blue:255/255, alpha: 1)
        tubeBorder.zPosition = 1
        tubeBorder.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration+duration), SKAction.removeFromParent()]))
        scene.addChild(tubeBorder)
        
        // stroker part
        let stroke:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(160))
        stroke.name = "startStroke|\(uuid)"
        stroke.position = startPoint
        stroke.strokeColor = strokeColor
        stroke.zPosition = 3
        //        stroke.run(SKAction.sequence([SKAction.scale(by: CGFloat(0.24), duration: scaleDuration),
        //                                      SKAction.removeFromParent()]))
        let initialLineWidth = CGFloat(3)
        let scale = CGFloat(0.25)
        let finalLineWidth = initialLineWidth / scale
        let animationDuration = scaleDuration
        let scaleAction = SKAction.scale(by: scale, duration: animationDuration)
        let lineWidthAction = SKAction.customAction(withDuration: animationDuration) { (shapeNode, time) in
            if let shape = shapeNode as? SKShapeNode {
                let progress = time / CGFloat(animationDuration)
                shape.lineWidth = initialLineWidth + progress * (finalLineWidth - initialLineWidth)
            }
        }
        let group = SKAction.sequence([SKAction.group([scaleAction, lineWidthAction]), SKAction.removeFromParent()])
        stroke.run(group)
        scene.addChild(stroke)
        
        // start part
        let start:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(40))
        start.name = "start|\(uuid)"
        start.position = startPoint
        start.lineWidth = CGFloat(5)
        start.fillColor = color
        start.zPosition = 3
        start.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration+duration), SKAction.removeFromParent()]))
        scene.addChild(start)
        
        // end part
        let end:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(40))
        end.name = "end|\(uuid)"
        end.position = endPoint
        end.lineWidth = CGFloat(5)
        end.fillColor = color
        end.zPosition = 3
        end.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration+duration), SKAction.removeFromParent()]))
        scene.addChild(end)
        
        // move part
        let move:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(40))
        move.name = "move|\(uuid)"
        move.lineWidth = CGFloat(5)
        move.fillColor = ballColor
        move.zPosition = 4
        move.run(SKAction.sequence([SKAction.hide(), SKAction.wait(forDuration: scaleDuration), SKAction.unhide(), SKAction.follow(path.cgPath, duration:duration), SKAction.removeFromParent()]))
        scene.addChild(move)
    }
    
}
