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
        let correction = -0.9;
        keys.append(Key(time: correction + 8, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 8.4, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 8.85, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        
        keys.append(Key(time: correction + 11.7, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: correction + 12.15, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: correction + 12.9, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        
        keys.append(Key(time: correction + 15.55, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 16.05, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 16.6, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        
        keys.append(Key(time: correction + 19.3, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: correction + 19.88, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: correction + 20.8, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        
        keys.append(Key(time: correction + 23.45, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 23.85, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 24.8, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        
        keys.append(Key(time: correction + 27.3, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: correction + 27.8, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: correction + 28.7, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        
        keys.append(Key(time: correction + 31.15, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 31.79, position: CGPoint(x:170, y:50), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 32.43, position: CGPoint(x:0, y:-70), type:KType.LINE_LEFT))
        
        keys.append(Key(time: correction + 35, position: CGPoint(x:170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: correction + 35.5, position: CGPoint(x:-170, y:50), type:KType.CIRCLE_GREEN))
        keys.append(Key(time: correction + 36.4, position: CGPoint(x:0, y:-70), type:KType.LINE_RIGHT))
        
        
        keys.append(Key(time: correction + 39, position: CGPoint(x:0, y:70), type:KType.CIRCLE_YELLOW))
        
        keys.append(Key(time: correction + 40.3, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 40.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 40.9, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: correction + 42.3, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 42.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 42.9, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: correction + 44.3, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 44.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 44.9, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: correction + 46.3, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 46.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 46.9, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: correction + 48.3, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 48.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 48.9, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: correction + 50.3, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 50.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 50.9, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: correction + 54.85, position: CGPoint(x:-170, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 55.25, position: CGPoint(x:0, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 55.65, position: CGPoint(x:170, y:0), type:KType.CIRCLE_YELLOW))
        
        keys.append(Key(time: correction + 59, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 59.3, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 59.6, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: correction + 60.4, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 60.7, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 61, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: correction + 62.7, position: CGPoint(x:-170, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 63.1, position: CGPoint(x:0, y:0), type:KType.CIRCLE_YELLOW))
        keys.append(Key(time: correction + 63.5, position: CGPoint(x:170, y:0), type:KType.CIRCLE_YELLOW))
        
        keys.append(Key(time: correction + 66.8, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 67.1, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 67.4, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))

        keys.append(Key(time: correction + 68.3, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 68.6, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 68.9, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))
        
        keys.append(Key(time: correction + 70.7, position: CGPoint(x:150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 71, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 71.3, position: CGPoint(x:-150, y:-110), type:KType.CIRCLE_RED))

        keys.append(Key(time: correction + 72.15, position: CGPoint(x:-150, y:10), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 72.45, position: CGPoint(x:0, y:-50), type:KType.CIRCLE_RED))
        keys.append(Key(time: correction + 72.75, position: CGPoint(x:150, y:-110), type:KType.CIRCLE_RED))

        return keys
    }
    
}
