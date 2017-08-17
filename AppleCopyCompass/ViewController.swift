//
//  ViewController.swift
//  AppleCopyCompass
//
//  Created by Myron on 2017/8/14.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var data = LocationData()
    
    // MARK: - Cycle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.controller = self
        
        contrainer_view.contentSize = CGSize(
            width: UIScreen.main.bounds.width * 2,
            height: UIScreen.main.bounds.height
        )
        compass_view.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        gradienter_view.frame = CGRect(
            x: UIScreen.main.bounds.width,
            y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        
        contrainer_view.addSubview(compass_view)
        contrainer_view.addSubview(gradienter_view)
    }
    
    // MARK: - Scroll View
    
    @IBOutlet weak var contrainer_view: UIScrollView!
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            page_control.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndDragging(
            scrollView,
            willDecelerate: false
        )
    }
    
    // MARK: - Page Control
    
    @IBOutlet weak var page_control: UIPageControl!
    
    @IBAction func page_control_action(_ sender: UIPageControl) {
        UIView.animate(withDuration: 0.25, animations: {
            self.contrainer_view.contentOffset.x = CGFloat(self.page_control.currentPage) * UIScreen.main.bounds.width
        })
    }
    
    // MARK: - Compass View
    
    @IBOutlet var compass_view: CompassView!
    
    func update_compass() {
        compass_view.update_magnetic_heading(
            angle: data.heading
        )
        compass_view.update_gps_labels(
            gps: "\(data.latitude_text()) \(data.longitude_text())",
            height: data.altitude_text()
        )
        compass_view.update_local_label(
            direct: data.direction,
            local: data.location
        )
    }
    
    // MARK: - Gradienter View
    
    @IBOutlet var gradienter_view: GradienterView!
    
}
