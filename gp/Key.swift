//
//  Note.swift
//  gp
//
//  Created by devops on 18/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//

import SpriteKit

class Key {
    
    var time:TimeInterval!
    var position:CGPoint!
    var type:KType!
    
    init(time:TimeInterval, position:CGPoint, type:KType) {
        self.time = time
        self.position = position
        self.type = type
    }
}
