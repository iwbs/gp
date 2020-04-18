//
//  Util.swift
//  gp
//
//  Created by devops on 15/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit

class Util {
    
    class func addScoreNode(scene: SKScene, position: CGPoint, score: String) {
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
    
    class func addCircle(scene: SKScene, position: CGPoint, type: KType){
        // stroke part
        var scaleDuration:TimeInterval
        var strokeColor:SKColor
        switch type {
            case .CIRCLE_RED:
                scaleDuration = 1
                strokeColor = SKColor(red:215/255, green:30/255, blue:30/255, alpha: 1)
            case .CIRCLE_YELLOW:
                scaleDuration = 1.15
                strokeColor = SKColor(red:235/255, green:235/255, blue:30/255, alpha: 1)
            case .CIRCLE_GREEN:
                scaleDuration = 1.3
                strokeColor = SKColor(red:30/255, green:235/255, blue:30/255, alpha: 1)
            default:
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
        let group = SKAction.sequence([SKAction.group([scaleAction, lineWidthAction]), SKAction.removeFromParent()])
        stroke.run(group)
        scene.addChild(stroke)
        
        
        // fill part
        let fill:SKShapeNode = SKShapeNode.init(circleOfRadius: CGFloat(40))
        fill.name = "fill|\(uuid)"
        fill.position = position
        fill.lineWidth = CGFloat(5)
        fill.fillColor = strokeColor
        fill.zPosition = 2
        let missAction = SKAction.run({
            addScoreNode(scene: scene, position: position, score: "Miss")
        })
        fill.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration), SKAction.removeFromParent(), missAction]))
        scene.addChild(fill)
        
    }
    
    class func addBezier(scene: SKScene, position: CGPoint, type: KType) {
        let uuid = UUID().uuidString
        let color = SKColor(red:130/255, green:130/255, blue:255/255, alpha: 1)
        let strokeColor = SKColor(red:30/255, green:30/255, blue:255/255, alpha: 1)
        let ballColor = SKColor(red:30/255, green:30/255, blue:255/255, alpha: 0.5)
        var startPoint:CGPoint
        var endPoint:CGPoint
        let controlPoint = CGPoint(x: position.x, y: position.y - 100)
        if type == KType.LINE_LEFT {
            startPoint = CGPoint(x: position.x - 150, y: position.y)
            endPoint = CGPoint(x: position.x + 150, y: position.y)
        } else {
            startPoint = CGPoint(x: position.x + 150, y: position.y)
            endPoint = CGPoint(x: position.x - 150, y: position.y)
        }
        let duration:TimeInterval = 1
        let scaleDuration:TimeInterval = 1
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        // tube part
        let tube:SKShapeNode = SKShapeNode.init(path: path.cgPath)
        tube.name = "bezier|\(uuid)"
//        tube.position = position
        tube.lineWidth = CGFloat(75)
        tube.strokeColor = color
        tube.zPosition = 2
        tube.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration+duration), SKAction.removeFromParent()]))
        scene.addChild(tube)
        
        let tubeBorder:SKShapeNode = SKShapeNode.init(path: path.cgPath)
        tubeBorder.name = "bezier|\(uuid)"
//        tubeBorder.position = position
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
        let missAction = SKAction.run({
            addScoreNode(scene: scene, position: endPoint, score: "Miss")
        })
        end.run(SKAction.sequence([SKAction.wait(forDuration: scaleDuration+duration), SKAction.removeFromParent(), missAction]))
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
    
    class func getDistance(point1:CGPoint, point2:CGPoint) -> CGFloat {
        return sqrt(pow(point1.x - point2.x,2) + pow(point1.y - point2.y,2))
    }
    
    class func createSong() -> [Key] {
        var keys = [Key]()
        //ive been hearing symphonies
        keys.append(Key(time: 8, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 8.4, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 8.85, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        // before all i heard was silence
        keys.append(Key(time: 11.7, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 12.15, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 12.9, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        // a rhapsody for you and me
        keys.append(Key(time: 15.55, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 16.05, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 16.6, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        // and every melody is timeless
        keys.append(Key(time: 19.3, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 19.88, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 20.8, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        // life was stringing me along
        keys.append(Key(time: 23.45, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 23.85, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 24.8, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        // then you came and you cut me loose
        keys.append(Key(time: 27.3, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 27.8, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 28.7, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        //was solo singing on my own
        keys.append(Key(time: 31.15, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 31.79, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 32.43, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        //now i can't find the key without you
        keys.append(Key(time: 35, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 35.5, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 36.4, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        
        // and
        keys.append(Key(time: 39.5, position: CGPoint(x:0, y:70), type:KType.CIRCLE_RED))
        
        //now your song is on repeat
        keys.append(Key(time: 40.4, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 40.8, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 41.2, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        // and i'm dancing on
        keys.append(Key(time: 42.4, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 42.8, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 43.2, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        // to your heart beat
        keys.append(Key(time: 44.4, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 44.8, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 45.2, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        // and when you're gone
        keys.append(Key(time: 46.3, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 46.7, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 47.1, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        // i feel incomplete
        keys.append(Key(time: 48.3, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 48.7, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 49.1, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: 50.2, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 50.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 51, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        
        //symphony
        keys.append(Key(time: 54.85, position: CGPoint(x:-170, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 55.35, position: CGPoint(x:0, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 55.85, position: CGPoint(x:170, y:0), type:KType.CIRCLE_YELLOW))
        
        // hold me tight
        keys.append(Key(time: 59, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 59.3, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 59.6, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        // now you go
        keys.append(Key(time: 60.4, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 60.7, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 61, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        //symphony
        keys.append(Key(time: 62.7, position: CGPoint(x:-170, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 63.2, position: CGPoint(x:0, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 63.7, position: CGPoint(x:170, y:0), type:KType.CIRCLE_YELLOW))
        
        //
        keys.append(Key(time: 66.8, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 67.1, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 67.4, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        //
        keys.append(Key(time: 68.3, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 68.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 68.9, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        //
        keys.append(Key(time: 70.7, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 71, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 71.3, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        //
        keys.append(Key(time: 72.15, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 72.45, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 72.75, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        
        
        
        
        return keys
    }
}
