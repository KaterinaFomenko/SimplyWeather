//
//  WeatherSmallAPI.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 14/09/2024.
//

import Foundation

struct WeatherAPI: Decodable {
    var weather: [Weather]
    var main: Main
    var name: String?
    
    func toWeatherModel() -> WeatherModel {
        var weatherModel = WeatherModel()
        weatherModel.id = weather[0].id
        weatherModel.temp = main.temp
       // weatherModel.tempMax = main.temp_max
       // weatherModel.tempMin = main.temp_min
        weatherModel.mainWeather = weather[0].main
        weatherModel.description = weather[0].description
        weatherModel.nameCity = name
        
        print("+++\(weatherModel)")
        return weatherModel
    }
}

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
}

struct Main: Decodable {
    var temp: Float
    var temp_min: Float
    var temp_max: Float
}


