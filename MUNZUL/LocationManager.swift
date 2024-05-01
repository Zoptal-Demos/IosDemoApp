//
//  LocationManager.swift
//  Deal
//
//  Created by Ranjit on 22/07/19.
//  Copyright © 2019 RichestSoft. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import GoogleMaps
import GooglePlaces
import UIKit

enum LocationManageState {
    case failed
    case updating
    case stoped
    case paused
}

class LocationManager: NSObject {
    
    private let locationManager: CLLocationManager = CLLocationManager()
    var state = LocationManageState.stoped
    var currentLocation = CLLocation()
    var currentAddress = String()
    var geoCoder = GMSGeocoder()
    let SCENEDELEGATE = SceneDelegate.sharedDelegate

    static let shared: LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    func requestLocationAtOnce() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation() //iOS 9 and later
        state = .updating
        if getPermission() == false {
//            displayAlertWithTitleMessageAndTwoButtons()
        }
    }
    
    func getPermission() -> Bool
    {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            return true
        case .authorizedWhenInUse:
            return true
        case .denied, .restricted:
            return false
        case .notDetermined:
            return false
        default:
            break
        }
        return true
    }
    
    func stopUpdating() {
        locationManager.stopUpdatingLocation()
        state = .stoped
    }
    
    
    func fetchAddress(location located: CLLocation, fetched: @escaping(_ address: GMSAddress, _ formattedAddress: String, _ error: Bool) -> Void) {
        geoCoder.reverseGeocodeCoordinate(located.coordinate) { (response, error) in
            if error == nil, response != nil {
                let address: GMSAddress = (response?.firstResult())!
                let lines = address.locality
                var addressElements = [String]()
                
                if let city = address.locality{
                    addressElements.append(city)
                }
                
//                if let state = address.administrativeArea{
//                    addressElements.append(state)
//                }
                
                if let country = address.country{
                    addressElements.append(country)
                }
                
                if let pinCode = address.postalCode{
                    addressElements.append(pinCode)
                }
                //let formatted: String = (lines?.joined(separator: " "))!
               // debugPrint(formatted)
                self.currentAddress = addressElements.joined(separator: ",")
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                fetched(address, addressElements.joined(separator: ","), false)
            } else {
                debugPrint("Error While reverce Geo Coding for Location:\(located) Error: \(error.debugDescription)")
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                fetched(GMSAddress(), "", true)
            }
        }
    }
    
    
    func getAddressFromLatLon(latitude: String, withLongitude longitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(latitude)")!
        let lon: Double = Double("\(longitude)")!
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            print(pm.country ?? "")
                                            print(pm.locality ?? "")
                                            print(pm.subLocality ?? "")
                                            print(pm.thoroughfare ?? "")
                                            print(pm.postalCode ?? "")
                                            print(pm.subThoroughfare ?? "")
                                            var addressString : String = ""
                                            if pm.subLocality != nil {
                                                addressString = addressString + pm.subLocality! + ", "
                                            }
                                            if pm.thoroughfare != nil {
                                                addressString = addressString + pm.thoroughfare! + ", "
                                            }
                                            if pm.locality != nil {
                                                addressString = addressString + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressString = addressString + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressString = addressString + pm.country! + ", "
                                            }
                                            if pm.postalCode != nil {
                                                addressString = addressString + pm.postalCode! + " "
                                            }
                                            print(addressString)
                                        }
                                    })
        
    }
    
    func displayAlertWithTitleMessageAndTwoButtons() {
        let alertController = UIAlertController(title: "Enable Location",
                                                message: "In order to use MUNZUL you need to enable your location.\n\nGo to settings > MUNZUL > Location > Enable Location While Using the App",
                                                preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alertAction) in
            UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!)! as URL, options: [:], completionHandler: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
       
        SCENEDELEGATE.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Did Location access permission was changed: \(status)")
        switch status {
        case .denied:
            print("get Location permission to access")
            self.displayAlertWithTitleMessageAndTwoButtons()
        case .notDetermined,.restricted:
            print("get Location permission to access")
            manager.requestWhenInUseAuthorization()
        default:
            print("Permission given")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        state = .updating
        if ((locations.first?.coordinate) != nil) {
            currentLocation = locations.first!
            print("Location updated: \(currentLocation.coordinate)")
        }
        print("Location updated: \(String(describing: locations.first?.coordinate))")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        state = .failed
        print("Failed to update Locations: \(error.localizedDescription)")
        manager.requestLocation() //iOS 9 and later
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        state = .paused
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        state = .updating
    }
}

