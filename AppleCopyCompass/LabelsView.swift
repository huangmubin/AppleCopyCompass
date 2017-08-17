//
//  LabelsView.swift
//  AppleCopyCompass
//
//  Created by Myron on 2017/8/14.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class LabelsView: UIView {

    var scale_labels = [UILabel]()
    var direction_labels = [UILabel]()
    
    func draw_content() {
        draw_scale_labels()
        draw_direction_labels()
    }
    
    func draw_scale_labels() {
        for i in 0 ..< 12 {
            let label = UILabel()
            label.textColor = UIColor.white
            label.text = (i * 30).description
            label.font = UIFont.systemFont(ofSize: bounds.width / 24)
            label.sizeToFit()
            label.center = CircularFunctions.point(
                at_radius: bounds.width * 0.5,
                angle: CGFloat.pi / 6 * CGFloat(i) - CGFloat.pi / 2
            ).offset(x: bounds.width / 2, y: bounds.height / 2)
            scale_labels.append(label)
            addSubview(label)
        }
    }
    
    func draw_direction_labels() {
        for (i, diration) in ["北", "东", "南", "西"].enumerated() {
            let label = UILabel()
            label.textColor = UIColor.white
            label.text = NSLocalizedString(diration, comment: "")
            label.font = UIFont.systemFont(ofSize: bounds.width / 14)
            label.sizeToFit()
            label.center = CircularFunctions.point(
                at_radius: bounds.width * 0.30,
                angle: CGFloat.pi / 2 * CGFloat(i) - CGFloat.pi / 2
                ).offset(x: bounds.width / 2, y: bounds.height / 2)
            direction_labels.append(label)
            addSubview(label)
        }
    }
    
    func rotation(radians: CGFloat) {
        for (i, label) in scale_labels.enumerated() {
            label.center = CircularFunctions.point(
                at_radius: bounds.width * 0.5,
                angle: CGFloat.pi / 6 * CGFloat(i) - CGFloat.pi / 2 + radians
            ).offset(x: bounds.width / 2, y: bounds.height / 2)
        }
        
        
        for (i, label) in direction_labels.enumerated() {
            label.center = CircularFunctions.point(
                at_radius: bounds.width * 0.30,
                angle: CGFloat.pi / 2 * CGFloat(i) - CGFloat.pi / 2 + radians
            ).offset(x: bounds.width / 2, y: bounds.height / 2)
        }
    }
    
}
