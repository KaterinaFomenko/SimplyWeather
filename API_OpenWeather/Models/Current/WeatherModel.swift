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
    var tempMin: Float = 0
    var tempMax: Float = 0
    var temp: Float = 0
    var dataTxt : String = ""
    
    var tempMinString: String {
        return String(format: "%.1f", tempMin)
    }
    
    var tempMaxString: String {
        return String(format: "%.1f", tempMax)
    }
    
    var tempString: String {
        return String(format:"%.1f", temp)
    }
    
    var logoURL: URL? {
        return URL(string: "https://openweathermap.org/img/wn/\(getImageId)@2x.png")
    }
    
    var getImageId: String {
        switch id {
        case 200...232:
            return "11d"
        case 300...321:
            return "09d"
        case 500...504:
            return "10d"
        case 511:
            return "13d"
        case 520...531:
            return "09d"
        case 600...622:
            return "13d"
        case 701...781:
            return "50d"
        case 800:
            return "01d"
        case 801...804:
            return "04d"
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

