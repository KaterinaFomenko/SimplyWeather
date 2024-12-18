//
//  ViewController.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 12/09/2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, Logable {
    var logOn: Bool = true
    
    private var tableViewBottomConstraint: NSLayoutConstraint!
    
    private var lastIndexPathTableView: IndexPath = IndexPath(row: 0, section: 0)
    
    // MARK: - UI Components
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        //tableView.backgroundColor = .orange
        // Register cells
        tableView.register(CellTop.self, forCellReuseIdentifier: CellTop.identifier)
        tableView.register(CellWeekWether.self, forCellReuseIdentifier: CellWeekWether.identifier)
        tableView.register(TodayWeatherCell.self, forCellReuseIdentifier: TodayWeatherCell.identifier)
        tableView.register(SearchLocationCell.self, forCellReuseIdentifier: SearchLocationCell.identifier)
        tableView.register(HourlyForecastCell.self, forCellReuseIdentifier: HourlyForecastCell.identifier)
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        
        DataManager.shared.viewController = self
        ForecastDataManager.shared.viewController = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sendCityNameNotification),
            name: .sendCityNameNotify,
            object: nil)
        
        let lastNameCity = UserSaving.getParam(key: .savedCity)
        
        if !lastNameCity.isEmpty {
            DataManager.shared.loadData(nameCity: lastNameCity)
            ForecastDataManager.shared.loadDataForecast(nameCity: lastNameCity)
        } else {
            DataManager.shared.getCurrentLocation()
        }
        
        // фон в зав-ти от ID: забираем первый эл-т массива и устанавливаем его в фун-ю
        //        if let firstWeather = DataManager.shared.weatherArray.first {
        //            setBackGroundImage(firstWeather.weatherIDBackground)
        //        }
        
        // MARK: Notification появления клавиатуры вызвать функцию подъёма контента
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(moveContentUp),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        // MARK: Notification исчезновения клавиатуры И вызвать функцию возврата контента в исходное положение
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moveContentBack),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        d.print("viewDidAppear", self)
        self.view.setGradientBackground(UIColor(hex: "5598E4"), UIColor(hex: "7CADD0"))
        
        //        if let firstWeather = DataManager.shared.weatherArray.first {
        //            setBackGroundImage(firstWeather.weatherIDBackground)
        //        }
    }
    
    // фон в зав-ти от ID:
    //    public func setBackGroundImage(_ imageNameBG: String) {
    //        let bacImage = UIImage(named: imageNameBG)
    //        let imageView = UIImageView(image: bacImage)
    //
    //        imageView.contentMode = .scaleAspectFill
    //        imageView.frame = self.view.bounds
    //        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    //        imageView.tag = 100
    //
    //        if let backgroundImageView = self.view.viewWithTag(100) as? UIImageView {
    //            // Теперь у вас есть доступ к вашему UIImageView
    //            print("Найден UIImageView с тегом 100")
    //            backgroundImageView.image = bacImage
    //        } else {
    //            //Первый запуск
    //            print("UIImageView не найден")
    //            self.view.insertSubview(imageView, at: 0) // Добавляем на задний план
    //        }
    //    }
    
    // Обработчик sendCityNameNotify для передачи имени города
    @objc func sendCityNameNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let currentCity = userInfo["CityName"] as? String {
            d.print("CurrentLocation info from VC: \(currentCity)", self)
            DataManager.shared.loadData(nameCity: currentCity)
            ForecastDataManager.shared.loadDataForecast(nameCity: currentCity)
        }
    }
    
    // появление клавиатуры сдвигание контента верхнего высоту закрываемого контента
    @objc func moveContentUp(_ notification: NSNotification) {
        // Get height Keyboard
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let keyboardHeight = keyboardFrame?.size.height ?? 100
        
        // Изменяем нижний констрейнт на высоту клавиатуры
        tableViewBottomConstraint.constant = -keyboardHeight - 10
        //scrollToBottom()
        
        //lastIndexPathTableView = IndexPath(row: DataManager.shared.weatherArray.count - 1, section: 0)
        
        //tableView.scrollToRow(at: lastIndexPathTableView, at: .top, animated: true)
        
        // Анимируем изменение
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    // создать функцию для возвращения контента в исходное положение при исчезновении клавиатуры
    @objc func moveContentBack(_ notification: Notification) {
        tableViewBottomConstraint.constant = 0
        
        // Анимируем изменение
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    //    func scrollToBottom() {
    //        let bottomOffset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height + tableView.contentInset.bottom)
    //        tableView.setContentOffset(bottomOffset, animated: true)
    //    }
    
    func updateData(nameCity: String) {
        
        if !nameCity.isEmpty {
            d.print("+++Save City = \(nameCity)", self)
            UserSaving.saveParam(key: .savedCity, value: nameCity)
        }
        
        self.tableView.reloadData()
        
        //        if let firstWeather = DataManager.shared.weatherArray.first {
        //            print("\nVC Погода в городе \(firstWeather.nameCity): \(firstWeather.description)")
        //            setBackGroundImage(firstWeather.weatherIDBackground)
        //        }
    }
    
    // MARK: - UISetup
    private func setupUI() {
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = true
   //     tableView.isScrollEnabled = false
        tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableViewBottomConstraint,
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    deinit {
        // 5. Удаляем наблюдателя при деинициализации, чтобы избежать утечек памяти
        NotificationCenter.default.removeObserver(self, name: .sendCityNameNotify, object: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        d.print("5. размер массива weatherArray \(DataManager.shared.weatherArray.count)", self)
        return DataManager.shared.weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return Constant.heightCellTop
        case 1:
            return Constant.heightCellToday
        case 2:
            return Constant.heightCellHours
        case 3:
            return Constant.heightWeatherWeek
        case 4:
            return Constant.heightSearchLocation
            
        default:
            return Constant.heightDefaultCell
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0 :
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellTop.identifier,
                for: indexPath
            ) as! CellTop
            cell.configureTopCell()
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TodayWeatherCell.identifier,
                for: indexPath
            ) as! TodayWeatherCell
            cell.configureMiddleCell(with: DataManager.shared.weatherArray[0])
            cell.selectedBackgroundView = getClearView()
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HourlyForecastCell.identifier,
                for: indexPath
            ) as! HourlyForecastCell
            let hoursForecastArray = ForecastDataManager.shared.hoursForecastArray
            d.print("!!! VC Data from hoursForecastArray \(hoursForecastArray)", self)
            cell.configure(array: hoursForecastArray)
            cell.selectedBackgroundView = getClearView() // selectedBackgroundView
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellWeekWether.identifier,
                for: indexPath
            ) as! CellWeekWether
            let forecastArray = ForecastDataManager.shared.forecastArray
            d.print("===VC Data from ForecastDataManager \(forecastArray)", self)
            cell.configure(array: forecastArray)
            cell.selectedBackgroundView = getClearView() // selectedBackgroundView
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchLocationCell.identifier,
                for: indexPath) as! SearchLocationCell
            cell.delegate = self
            cell.selectedBackgroundView = getClearView()
            return cell
            
        default:
            fatalError("Unexpected row index")
        }
    }
    
    //  Метод для обработки нажатий на ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Скрываем клавиатуру при выборе ячейки
        view.endEditing(true)
        
        // Убираем выделение ячейки
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true) // Скрывает клавиатуру
    }
    
    func getClearView() -> UIView {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.clear
        return selectedBackgroundView
    }
}
