//
//  LocationData.swift
//  AppleCopyCompass
//
//  Created by Myron on 2017/8/14.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion

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
        
        //open_gyro()
        DispatchQueue.global().async {
            while true {
                Thread.sleep(forTimeInterval: 1)
                self.update_gravity()
            }
        }
    }
    
    // MARK: - Compass
    
    var compass = CLLocationManager()
    
    var heading: CGFloat = 0
    
    // 获取磁北方向
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = CGFloat(newHeading.magneticHeading.magnitude)
        controller?.update_compass()
    }
    
    
    var altitude: Double = 0
    var latitude: Double = 0
    var longitude: Double = 0
    var location: String = ""
    var direction: String {
        switch heading {
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
                if let mark = placemarks?.first {
                    if let locality = mark.locality, let sub = mark.subLocality {
                        self.location = "\(locality)\n\(sub)"
                        self.controller?.update_compass()
                    }
                }
        }
    }
    
    // MARK: - 陀螺仪
    
    var motion = CMMotionManager()
    
    func open_gyro() {
        
//        if motion.isGyroAvailable && motion.isGyroActive {
            motion.gyroUpdateInterval = 0.01
        
        
        
            motion.startGyroUpdates(
                to: OperationQueue.main,
                withHandler: { (gyro, error) in
                    print("Gyro x = \(String(describing: gyro?.rotationRate.x)); y = \(String(describing: gyro?.rotationRate.y)); z = \(String(describing: gyro?.rotationRate.z))")
            })
//        }
    }
    
    func update_gravity() {
        motion.deviceMotionUpdateInterval = 1
        motion.startDeviceMotionUpdates(to: .main) { (motion, error) in
            if  let g_x = motion?.gravity.x,
                let g_y = motion?.gravity.y,
                let g_z = motion?.gravity.z {
                // 手机倾斜角度
                let zTheta = atan2(g_z, sqrt(g_x * g_x + g_y * g_y)) / Double.pi * 180
                // 手机与水平面夹角
                let xyTheta = atan2(g_x, g_y) / Double.pi * 180
                print("z = \(zTheta); xy = \(xyTheta)")
            }
        }
        //                    //2. Gravity 获取手机的重力值在各个方向上的分量，根据这个就可以获得手机的空间位置，倾斜角度等 double gravityX = motionManager.deviceMotion.gravity.x;
        //                    double gravityY = motionManager.deviceMotion.gravity.y;
        //                    double gravityZ = motionManager.deviceMotion.gravity.z;
        //                    //获取手机的倾斜角度：
        //                    double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;
        //                    double xyTheta = atan2(gravityX,gravityY)/M_PI*180.0;
        //                    //zTheta是手机与水平面的夹角， xyTheta是手机绕自身旋转的角度
        
        
        
    }
    
//    - (void)useGyroPush{
//    //初始化全局管理对象
//    CMMotionManager *manager = [[CMMotionManager alloc] init];
//    self.motionManager = manager;
//    //判断陀螺仪可不可以，判断陀螺仪是不是开启
//    if ([manager isGyroAvailable] && [manager isGyroActive]){
//    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    //告诉manager，更新频率是100Hz
//    manager.gyroUpdateInterval = 0.01;
//    //Push方式获取和处理数据
//    [manager startGyroUpdatesToQueue:queue
//    withHandler:^(CMGyroData *gyroData, NSError *error)
//    {
//    NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
//    NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
//    NSLog(@"Gyro Rotation z = %.04f", gyroData.rotationRate.z);
//    }];
//    }
//    }
//    
//    作者：执着_执念
//    链接：http://www.jianshu.com/p/5bf81ef8d35a
//    來源：简书
//    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
}
