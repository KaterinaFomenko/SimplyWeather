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
    
    var logoURL2: URL? {
        return URL(string: "https://openweathermap.org/img/wn/\(getImageId)@2x.png")
    }
    
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
            return "50d"  // mist
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
}

extension ForecastModel {
    public func mockData() -> [WeatherModel] {
        return [
            WeatherModel(id: 501, nameCity: "Sosnowiec", mainWeather: "Rain", description: "Strong Rain", tempMin: 9, tempMax: 12),
            WeatherModel(id: 502, nameCity: "Znamenka", mainWeather: "Sun", description: "Light Sun", tempMin: 20, tempMax: 25)
        ]
    }
}

