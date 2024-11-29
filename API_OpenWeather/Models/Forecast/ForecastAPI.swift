//
//  ForecastAPI.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 30/09/2024.
//

import Foundation
struct ForecastAPI: Decodable {
    let list: [WeatherForecasAPI]
}

struct WeatherForecasAPI: Decodable {
    var main: MainForecast
    var weather: [WeatherForecast]
    var dt_txt: String
    
    func toForecastModel() -> ForecastModel {
        var weatherModel = ForecastModel()
        
        weatherModel.id = weather.first?.id ?? 0
        weatherModel.temp = main.temp
        weatherModel.dataTxt = dt_txt
        
        return weatherModel
    }
}

struct MainForecast: Decodable {
    var temp: Float
}

struct WeatherForecast: Decodable {
    var id: Int
}
