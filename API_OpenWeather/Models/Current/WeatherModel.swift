//
//  WeatherSmallModel.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 14/09/2024.
//

import Foundation
import UIKit

public struct WeatherModel {
    
    var id: Int = 0
    var nameCity: String?
    var mainWeather: String = ""
    var description: String = ""
    var temp: Float = 0
    var tempMin: Float = 0
    var tempMax: Float = 0
    var dataTxt : String = ""
    
    var tempString: String {
        return String(format:"%.1f", temp)
    }
    
    var tempMinString: String {
        return String(format: "%.1f", tempMin)
    }
    
    var tempMaxString: String {
        return String(format: "%.1f", tempMax)
    }
    
//    var logoURL2: URL? {
//        return URL(string: "https://openweathermap.org/img/wn/\(getImageId).png")
//    }
    
    var logoURL: String {
        return "\(getImageId).png"
    }
    
    
    var getImageId: String {
        switch id {
        case 200...232:
           // return "11d" // thunderstorm
            return "16_thunderstorm"
        case 300...321:
           // return "09d" // shower rain
            return "6_rain"
        case 500...504:
           // return "10d" // rain
            return "7_rainSun"
        case 511:
          //  return "13d" // snow
            return "9_snowflake"
        case 520...531:
         //   return "09d" // shower rain
            return "6_rain"
        case 600...622:
        //    return "13d" // snow
            return "10_darkCloudSnowind"
        case 701...781:
            //return "50d"  // mist
            return "14_temperature"
        case 800:
        //   return "01d" // clear sky
            return "2_sun"
        case 801...804:
       //     return "04d" // broken clouds
            return "3_twoClouds"
        default:
            return "0"
        }
    }
    
    var weatherIDBackground: String {
        switch id {
        case 200...232:
            return "Thunderstorm" // гроза
        case 300...321:
            return "Drizzle" //Мелкий дождь
        case 500...504:
            return "Rain" //Дождь
        case 511:
            return "FreezingRain" //Ледяной дождь
        case 520...531:
            return "Showers" // Переменный дождь
        case 600...622:
            return "Snow" // Снег
        case 701...781:
            return "MistFog"// Туман
        case 800:
            return "Clear" // Ясно
        case 801...804:
            return "Clouds" // Облачно
        default:
            return "TheUnknownWeather" // Неизвестная погода
        }
    }
    
    var getBackgroundView: UIImage {
        return UIImage(named: weatherIDBackground) ?? UIImage()
    }
}

extension WeatherModel {
    public func mockData() -> [WeatherModel] {
        return [
            WeatherModel(id: 501, nameCity: "Sosnowiec", mainWeather: "Rain", description: "Strong Rain", tempMin: 9, tempMax: 12),
            WeatherModel(id: 502, nameCity: "Znamenka", mainWeather: "Sun", description: "Light Sun", tempMin: 20, tempMax: 25)
        ]
    }
}

