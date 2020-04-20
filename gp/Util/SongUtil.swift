//
//  SongUtil.swift
//  gp
//
//  Created by devops on 19/4/2020.
//  Copyright © 2020 comp7506. All rights reserved.
//
import SpriteKit

class SongUtil {
    
    class func createSong() -> [Key] {
        var keys = [Key]()
        
        keys.append(Key(time: 8, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 8.4, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 8.85, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        
        keys.append(Key(time: 11.7, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 12.15, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 12.9, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        
        keys.append(Key(time: 15.55, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 16.05, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 16.6, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        
        keys.append(Key(time: 19.3, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 19.88, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 20.8, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        
        keys.append(Key(time: 23.45, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 23.85, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 24.8, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        
        keys.append(Key(time: 27.3, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 27.8, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 28.7, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        
        keys.append(Key(time: 31.15, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 31.79, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 32.43, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        
        keys.append(Key(time: 35, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 35.5, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: 36.4, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        
        
        keys.append(Key(time: 39, position: CGPoint(x:0, y:70), type:KType.CIRCLE_YELLOW))
        
        keys.append(Key(time: 40.3, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 40.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 40.9, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: 42.3, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 42.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 42.9, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: 44.3, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 44.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 44.9, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: 46.3, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 46.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 46.9, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: 48.3, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 48.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 48.9, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: 50.3, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 50.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 50.9, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: 54.85, position: CGPoint(x:-170, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 55.25, position: CGPoint(x:0, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 55.65, position: CGPoint(x:170, y:0), type:KType.CIRCLE_YELLOW))
        
        keys.append(Key(time: 59, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 59.3, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 59.6, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: 60.4, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 60.7, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 61, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: 62.7, position: CGPoint(x:-170, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 63.1, position: CGPoint(x:0, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: 63.5, position: CGPoint(x:170, y:0), type:KType.CIRCLE_YELLOW))
        
        keys.append(Key(time: 66.8, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 67.1, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 67.4, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))

        keys.append(Key(time: 68.3, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 68.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 68.9, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: 70.7, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 71, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 71.3, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))

        keys.append(Key(time: 72.15, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: 72.45, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: 72.75, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))

        return keys
    }
    
}
