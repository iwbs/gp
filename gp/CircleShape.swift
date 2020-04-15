//
//  CircleShape.swift
//  gp
//
//  Created by devops on 15/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit

class CircleShape: SKShapeNode {
    
    var uuid: String?
    var type: String?
    
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func createObject(_ uuid: String, position: CGPoint, color: SKColor, duration: TimeInterval) -> CircleShape {
        
        let stroke = CircleShape.init(circleOfRadius: CGFloat(200))
        stroke.type = "stroke"
        stroke.uuid = uuid
        stroke.name = "stroke|\(uuid)"
        stroke.position = position
        stroke.lineWidth = CGFloat(7)
        stroke.strokeColor = color
        stroke.zPosition = 1
        
        let scale = SKAction.scale(by: CGFloat(0.24), duration: duration)
        let remove = SKAction.removeFromParent()
        let actions = SKAction.sequence([scale, remove])
        
        stroke.run(actions)

        return stroke
//        self.addChild(stroke)
    }
}
