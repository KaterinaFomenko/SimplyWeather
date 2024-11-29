//
//  LocationManager.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 06/10/2024.
//

import Foundation
import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization() // Запрашиваем разрешение
        self.locationManager.startUpdatingLocation() // Начинаем обновление местоположения
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Обратное геокодирование
        let locale = Locale(identifier: "en_US")
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { (placemarks, error) in
            if let error = error {
                print("Ошибка геокодирования: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first,
               let cityName = placemark.locality {
                print("Город: \(cityName)") // Здесь вы получаете название города
                let userInfo = ["CityName" : cityName]
                NotificationCenter.default.post(name: .sendCityNameNotify, object: nil, userInfo: userInfo)
            }
        }
        
        // Останавливаем обновление местоположения после получения
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка получения местоположения: \(error.localizedDescription)")
    }
}
