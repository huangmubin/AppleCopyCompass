//
//  CompassView.swift
//  AppleCopyCompass
//
//  Created by Myron on 2017/8/14.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class CompassView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy()
    }
    
    private func deploy() {
        shaft_view.frame = CGRect(
            x: UIScreen.main.bounds.width * 0.1,
            y: UIScreen.main.bounds.height * 0.1,
            width: UIScreen.main.bounds.width * 0.8,
            height: UIScreen.main.bounds.width * 0.8
        )
        shaft_view.draw_content()
        addSubview(shaft_view)
        
        scale_view.frame = CGRect(
            x: UIScreen.main.bounds.width * 0.1,
            y: UIScreen.main.bounds.height * 0.1,
            width: UIScreen.main.bounds.width * 0.8,
            height: UIScreen.main.bounds.width * 0.8
        )
        scale_view.draw_contents()
        addSubview(scale_view)
        
        labels_view.frame = CGRect(
            x: UIScreen.main.bounds.width * 0.1,
            y: UIScreen.main.bounds.height * 0.1,
            width: UIScreen.main.bounds.width * 0.8,
            height: UIScreen.main.bounds.width * 0.8
        )
        labels_view.draw_content()
        addSubview(labels_view)
        
    }
    
    // MARK: - Scale View
    
    var scale_view = ScaleView()
    
    // MARK: - Label View
    
    var labels_view = LabelsView()
    
    // MARK: - Center Shaft
    
    var shaft_view = CenterShaftView()
    
    func update_magnetic_heading(angle: CGFloat) {
        let radians = -angle / 180.0 * CGFloat.pi
        UIView.animate(withDuration: 0.1, animations: {
            self.scale_view.transform = CGAffineTransform(
                rotationAngle: radians
            )
            self.labels_view.rotation(
                radians: radians
            )
        })
        
        degree_label.text = String(format: "%.0f°", angle)
    }
    
    // MAKR: - Labels
    
    @IBOutlet weak var degree_label: UILabel! {
        didSet {
            degree_label.font = UIFont.systemFont(
                ofSize: UIScreen.main.bounds.height / 7,
                weight: UIFontWeightUltraLight
            )
        }
    }
    @IBOutlet weak var direct_label: UILabel!
    @IBOutlet weak var local_label: UILabel!
    
    @IBOutlet weak var gps_label: UILabel!
    @IBOutlet weak var height_label: UILabel!
    
    func update_gps_labels(gps: String, height: String) {
        gps_label.text = gps
        height_label.text = height
    }
    
    func update_local_label(direct: String, local: String) {
        direct_label.text = direct
        local_label.text = local
    }
    
}
