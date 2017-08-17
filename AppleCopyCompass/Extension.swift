//
//  Extension.swift
//  AppleCopyCompass
//
//  Created by Myron on 2017/8/14.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

// MARK: - CGPoint

extension CGPoint {
    
    func offset(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(
            x: self.x + x,
            y: self.y + y
        )
    }
    
}
