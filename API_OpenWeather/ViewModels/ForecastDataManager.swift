//
//  ForecastDataManager.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 30/09/2024.
//

import Foundation

class ForecastDataManager: Logable {
    var logOn: Bool = false
    
    // MARK: - Variables
    
    static var shared = ForecastDataManager()
    
    weak var viewController: ViewController?
    
    var forecastArray: [ForecastModel] = []
    var hoursForecastArray: [ForecastModel] = []
   
    var weekArray: [String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
    
    // MARK: - Life Cycle
    
    private init() {
        // Приватный инициализатор, который предотвращает создание других экземпляров класса.
        // Это стандартная практика для синглтонов.
    }
    
    // MARK: Load Data
    
    func loadDataForecast(nameCity: String) {
        WeatherRequest().getForecast(nameCity: nameCity) { weatherApiData, error in
            guard let weatherApiData = weatherApiData else {
                d.print("Ошибка: \(error ?? "Неизвестная ошибка")", self)
                return
            }
            
            print("===getForecast: weatherApiData \(weatherApiData)", self)
            
            self.forecastArray.removeAll()
            self.hoursForecastArray.removeAll()
            
            for element in weatherApiData.list {
//              место func configure
//              { var fm = ForecastModel()
//                fm.id = element.weather.first?.id ?? 0
//                fm.dataTxt = element.dt_txt }
                
                self.forecastArray.append(element.toForecastModel())
                self.hoursForecastArray.append(element.toForecastModel())
            }
            
            d.print("=== self.forecastArray:\(self.forecastArray.count)", self)
            d.print("!!! self.hoursForecastArray: \( self.hoursForecastArray.count)", self)
            
            self.forecastArray = self.filterSevenDays()
            let filteredHours = self.filterTwoDays(self.hoursForecastArray)
            
            d.print("=== self.forecastArray Filtered:\(self.forecastArray.count)", self)
            d.print("!!! filterTwoDays \(self.hoursForecastArray.count)", self)
            d.print("!!! filterTwoDays \(filteredHours)", self)
            
            DispatchQueue.main.async {
                
                self.viewController?.updateData(nameCity: "")
            }
        }
    }
    
    func getFiveDays(_ toDay: Date.FormatStyle.FormatOutput) -> [String] {
        let doubleWeek = weekArray + weekArray
        let nextDay = (weekArray.firstIndex(of: toDay) ?? 0) + 1
        let fiveDaysArray = doubleWeek[nextDay ..< nextDay + 5]
        print("Array(fiveDaysArray): \(Array(fiveDaysArray))")
        return Array(fiveDaysArray)
    }
    
    private func filterSevenDays() -> [ForecastModel] {
       return forecastArray.enumerated().compactMap { index, element in
            (index + 1) % 8 == 0 ? element : nil
        }
    }
    
    private func filterTwoDays(_ array: [ForecastModel]) -> [ForecastModel] {
        return Array(array.prefix(16))
    }
}
    
