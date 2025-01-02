

import Foundation
import UIKit

class SearchDataManager: Logable {
    var logOn: Bool = false
    
    // MARK: - Variables
    static let shared = SearchDataManager()
    weak var searchVC: SearchViewController?
    
    //  weak var dataManager: DataManager?
    var arrayRecentCities: [String] = []
    var defaultCities = ["Los Angeles", "Barselona", "Paris", "Tokio", "London", "New York"]
    
    private init() {}
    
    func getDisplayedCities() -> [String] {
        let resentCities = Array(arrayRecentCities.prefix(5))
        let allCities = resentCities.isEmpty ? defaultCities : resentCities
        print("getDisplayedCities: \(allCities)")
        return allCities
    }
    
    func requestByCityName(_ textField: UITextField) {
        guard let nameCity = textField.text, !nameCity.isEmpty else { return }
        
        //add to history list
        saveNewCity(nameCity: nameCity)
        
        // dataManager?.loadData(nameCity: nameCity)
        // Можно использовать NotificationCenter, если нужно отправить уведомление
        let userInfo = ["CityName": nameCity]
        NotificationCenter.default.post(
            name: .sendCityNameNotify,
            object: nil,
            userInfo: userInfo
        )
    }
    
    func saveNewCity(nameCity: String) {
            if arrayRecentCities.isEmpty {
                arrayRecentCities += defaultCities
            }
        
            if !arrayRecentCities.contains(nameCity) {
                
                arrayRecentCities.insert(nameCity, at: 0)
                if arrayRecentCities.count > 10 {
                    arrayRecentCities.removeLast()
                }
                UserDefaults.standard.set(arrayRecentCities, forKey: "RecentCities")
                UserDefaults.standard.synchronize()
            }
        }
}
