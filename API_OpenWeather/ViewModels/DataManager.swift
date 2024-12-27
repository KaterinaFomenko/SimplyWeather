//
//  HomeDataManager.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 15/09/2024.
//
import Foundation

class DataManager: Logable  {
    var logOn = false
    
    private var locationManager: LocationManager?
    
    // MARK: - Variables
    
    static let shared = DataManager()
    
    weak var viewController: ViewController?
   
    var weatherArray: [WeatherModel] = []
    
    var mockArray: [WeatherModel] = [
    WeatherModel(id: 501, nameCity: "Mock1", mainWeather: "sunni", description: "sunni", tempMin: 0, tempMax: 1),
    WeatherModel(id: 502, nameCity: "Mock2", mainWeather: "sunni2", description: "sunni2", tempMin: -0, tempMax: -1),
    WeatherModel(id: 503, nameCity: "Mock3", mainWeather: "sunni3", description: "sunni3", tempMin: -0, tempMax: -1),
    WeatherModel(id: 503, nameCity: "Mock3", mainWeather: "sunni3", description: "sunni3", tempMin: -0, tempMax: -1)
    //WeatherModel(id: 503, nameCity: "Mock3", mainWeather: "sunni3", description: "sunni3", tempMin: -0, tempMax: -1)
    ]
    
    // MARK: - Life Cycle
    private init() { }
    
    // MARK: Load Data
    func loadData(nameCity: String) {
        WeatherRequest().getWeather(nameCity: nameCity ) { weatherApiData, error in
            guard let weatherApiData = weatherApiData else {
                d.print("API get weather Ошибка: \(error ?? "Неизвестная ошибка")", self)
                self.weatherArray.append(contentsOf: self.mockArray)
                return
            }
            d.print("+++getWeather weatherApiData \(weatherApiData)", self)
           
            self.weatherArray.removeAll()
            self.weatherArray.append(weatherApiData.toWeatherModel())
            self.weatherArray.append(contentsOf: self.mockArray)
            
            d.print("New name of city \(nameCity)", self)

            DispatchQueue.main.async {
              // фон в зав-ти от ID:
              // self.viewController?.setBackGroundImage(self.weatherArray.first?.weatherIDBackground ?? "")
                self.viewController?.updateData(nameCity: nameCity)
            }
        }
    }
    
    public func getCurrentLocation() {
        locationManager = LocationManager()
    }
    
    
}
