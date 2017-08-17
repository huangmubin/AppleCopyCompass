//
//  CircularFunctions.swift
//  AppleCopyCompass
//
//  Created by Myron on 2017/8/14.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class CircularFunctions {
    
    class func point(at_radius: CGFloat, angle: CGFloat) -> CGPoint {
        let x = at_radius * cos(angle)
        let y = at_radius * sin(angle)
        return CGPoint(x: x, y: y)
    }
    
}
