//
//  CenterShaftView.swift
//  AppleCopyCompass
//
//  Created by Myron on 2017/8/14.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class CenterShaftView: UIView {

    func draw_content() {
        draw_shaft_layer()
    }
    
    func draw_shaft_layer() {
        let top = CALayer()
        top.frame = CGRect(
            x: bounds.width * 0.5 - 2,
            y: -bounds.height * 0.05,
            width: 4,
            height: bounds.height * 0.185
        )
        top.backgroundColor = UIColor.white.cgColor
        top.cornerRadius = 4
        layer.addSublayer(top)
        
        let horizontal = CALayer()
        horizontal.frame = CGRect(
            x: bounds.width * 0.3,
            y: bounds.height * 0.5 - 0.5,
            width: bounds.width * 0.4,
            height: 1
        )
        horizontal.backgroundColor = UIColor.white.cgColor
        horizontal.cornerRadius = 0.5
        layer.addSublayer(horizontal)
        
        let vertical = CALayer()
        vertical.frame = CGRect(
            x: bounds.width * 0.5 - 0.5,
            y: bounds.height * 0.3,
            width: 1,
            height: bounds.height * 0.4
        )
        vertical.backgroundColor = UIColor.white.cgColor
        vertical.cornerRadius = 0.5
        layer.addSublayer(vertical)
    }
    
}
