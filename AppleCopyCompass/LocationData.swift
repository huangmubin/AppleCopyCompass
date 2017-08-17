//
//  LocationData.swift
//  AppleCopyCompass
//
//  Created by Myron on 2017/8/14.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit
import CoreLocation

class LocationData: NSObject, CLLocationManagerDelegate {

    weak var controller: ViewController?
    
    override init() {
        super.init()
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .restricted:
            return
        case .notDetermined:
            self.compass.requestWhenInUseAuthorization()
        default:
            break
        }
        compass.delegate = self
        compass.desiredAccuracy = kCLLocationAccuracyBest
        compass.startUpdatingHeading()
        compass.startUpdatingLocation()
    }
    
    // MARK: - Compass
    
    var compass = CLLocationManager()
    
    var heading: CGFloat = 0
    
    // 获取磁北方向
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = -CGFloat(newHeading.magneticHeading.magnitude)
        controller?.update_compass()
    }
    
    
    var altitude: Double = 0
    var latitude: Double = 0
    var longitude: Double = 0
    var location: String = ""
    var direction: String {
        switch altitude {
        case 0 ..< 15, 345 ..< 360:
            return "北"
        case 15 ..< 75:
            return "东北"
        case 75 ..< 105:
            return "东"
        case 105 ..< 165:
            return "东南"
        case 165 ..< 195:
            return "南"
        case 195 ..< 255:
            return "西南"
        case 255 ..< 285:
            return "西"
        case 285 ..< 345:
            return "西北"
        default: return ""
        }
    }
    func altitude_text() -> String {
        return String(format: "海拔 %.0f 米", altitude)
    }
    func latitude_text() -> String {
        let h = Int(latitude)
        let m_s = (latitude - Double(h)) * 60
        let m = Int(m_s)
        let s = Int((m_s - Double(m)) * 60)
        let text = latitude > 0 ? "北纬" : "南纬"
        return "\(text) \(h)°\(m)′\(s)″"
    }
    func longitude_text() -> String {
        let h = Int(longitude)
        let m_s = (longitude - Double(h)) * 60
        let m = Int(m_s)
        let s = Int((m_s - Double(m)) * 60)
        let text = longitude > 0 ? "东经" : "西经"
        return "\(text) \(h)°\(m)′\(s)″"
    }
    
    let geocoder = CLGeocoder()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        altitude = locations.first?.altitude ?? 0
        latitude = locations.first?.coordinate.latitude ?? 0
        longitude = locations.first?.coordinate.longitude ?? 0
        controller?.update_compass()
        
        geocoder.reverseGeocodeLocation(
            locations[0]) { (placemarks, error) in
                print(placemarks)
                if let mark = placemarks?.first {
                    if let locality = mark.locality, let sub = mark.subLocality {
                        self.location = "\(locality)\n\(sub)"
                        self.controller?.update_compass()
                    }
                }
        }
    }
    
    
}
