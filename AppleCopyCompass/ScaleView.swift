//
//  ScaleView.swift
//  AppleCopyCompass
//
//  Created by Myron on 2017/8/14.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class ScaleView: UIView {

    func draw_contents() {
        draw_arrow_layer()
        draw_thin_layers()
        draw_fat_layers()
    }
    
    func draw_arrow_layer() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.02))
        path.addLine(to: CGPoint(x: bounds.width * 0.517, y: bounds.height * 0.06 * 0.86602540378))
        path.addLine(to: CGPoint(x: bounds.width * 0.483, y: bounds.height * 0.06 * 0.86602540378))
        path.close()
        
        let shape_layer = CAShapeLayer()
        shape_layer.path = path.cgPath
        shape_layer.frame = bounds
        shape_layer.lineJoin = kCALineJoinRound
        shape_layer.lineCap = kCALineCapRound
        shape_layer.lineWidth = 4
        shape_layer.strokeColor = UIColor.red.cgColor
        shape_layer.fillColor = UIColor.red.cgColor
        layer.addSublayer(shape_layer)
    }
    
    func draw_thin_layers() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width / 2, y: 0))
        path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height))
        
        for i in 0 ..< 144 {
            let shape_layer = CAShapeLayer()
            shape_layer.path = path.cgPath
            shape_layer.frame = bounds
            shape_layer.lineCap = kCALineCapRound
            shape_layer.lineWidth = 1
            shape_layer.strokeColor = UIColor.white.cgColor
            shape_layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat.pi / 72 * CGFloat(i)))
            shape_layer.strokeStart = 0.07
            shape_layer.strokeEnd = 0.128
            layer.addSublayer(shape_layer)
        }
    }

    func draw_fat_layers() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width / 2, y: 0))
        path.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height))
        
        for i in 0 ..< 12 {
            let shape_layer = CAShapeLayer()
            shape_layer.path = path.cgPath
            shape_layer.frame = bounds
            shape_layer.lineCap = kCALineCapRound
            shape_layer.lineWidth = 3
            shape_layer.strokeColor = UIColor.white.cgColor
            shape_layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat.pi / 6 * CGFloat(i)))
            shape_layer.strokeStart = 0.07
            shape_layer.strokeEnd = 0.13
            layer.addSublayer(shape_layer)
        }
    }
    
    
}
