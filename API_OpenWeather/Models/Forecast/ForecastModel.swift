//
//  ForecastModel.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 30/09/2024.
//

import Foundation

struct ForecastModel {
    var id: Int = 0
    var temp: Float = 0
    var dataTxt : String = ""
    
    var tempString: String {
        return String(format: "%.1f", temp)
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
}

extension ForecastModel {
    public func mockData() -> [WeatherModel] {
        return [
            WeatherModel(id: 501, nameCity: "Sosnowiec", mainWeather: "Rain", description: "Strong Rain", tempMin: 9, tempMax: 12),
            WeatherModel(id: 502, nameCity: "Znamenka", mainWeather: "Sun", description: "Light Sun", tempMin: 20, tempMax: 25)
        ]
    }
}

