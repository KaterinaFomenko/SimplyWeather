//
//  WeatherRequest.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 12/09/2024.
//

import Foundation

//https://api.openweathermap.org/data/2.5/weather?q=Sosnowiec&appid=18560c3e0951a14743dc5a9d2b174eb0

class WeatherRequest {
    // URL для API OpenWeatherMap
    let scheme = "https://"
    let baseURL = "api.openweathermap.org"
    let weatherList = "/data/2.5/weather?"
    let forecastList = "/data/2.5/forecast?"
    
    let sortParametr = "q=Sosnowiec"
    let countParam = "&cnt=800"
    let appid = "&appid=18560c3e0951a14743dc5a9d2b174eb0"
    let metric = "&units=imperial"
    
    func getWeather(nameCity: String = "Dnipro", completion: @escaping (_ weatherData: WeatherAPI?, _ error: String?) -> ()) {
        // Формируем URL
        guard let url = URL(string: scheme + baseURL + weatherList + "q=\(nameCity)" + appid + metric)  else {
            completion(nil, "Invalid URL")
            return
        }
        print(url)
        // Создаем запрос
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Запрос данных с использованием URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, "HTTP Request Failed: \(error.localizedDescription)")
                return
            }
            print("+++1.GetWeather.Data \(data)")
            // Проверяем данные
            if let data = data {
                do {
                    // Декодируем JSON в модель WeatherAPI
                    let weatherData = try JSONDecoder().decode(WeatherAPI.self, from: data)
                    print("+++2. data from request \(weatherData)")
                    completion(weatherData, nil)
                } catch {
                    // Обрабатываем ошибки декодирования
                    completion(nil, "Invalid Response: \(error.localizedDescription)")
                }
            } else {
                completion(nil, "No data received")
            }
        }
        task.resume()
    }
    //https://api.openweathermap.org/data/2.5/forecast/daily?lat={lat}&lon={lon}&cnt={cnt}&appid={API key}
    //https://api.openweathermap.org/data/2.5/forecast?q=Sosnowiec/daily&cnt=56&appid=18560c3e0951a14743dc5a9d2b174eb0
    
    func getForecast(nameCity: String = "Dnipro", completion: @escaping (_ weatherData: ForecastAPI?, _ error: String?) -> ()) {
        // Формируем URL
        guard let url = URL(string: scheme + baseURL + forecastList + "q=\(nameCity)" + countParam + appid + metric)  else {
            completion(nil, "Invalid URL")
            return
        }
        print(url)
        
        // Создаем запрос
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Запрос данных с использованием URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, "HTTP Request Failed: \(error.localizedDescription)")
                return
            }
            print("===1.getForecast.Data \(data)")
            // Проверяем данные
            if let data = data {
                do {
                    // Декодируем JSON в модель WeatherAPI
                    let weatherData = try JSONDecoder().decode(ForecastAPI.self, from: data)
                    print("===2. data from Forecast request \(weatherData)")
                    completion(weatherData, nil)
                } catch {
                    // Обрабатываем ошибки декодирования
                    completion(nil, "Invalid Response: \(error.localizedDescription)")
                }
            } else {
                completion(nil, "No data received")
            }
        }
        task.resume()
    }
}







