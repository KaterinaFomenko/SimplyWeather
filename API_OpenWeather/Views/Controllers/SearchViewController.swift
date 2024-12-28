//
//  SearchViewController.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 17/12/2024.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, Logable {
    
    var logOn: Bool = true
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private var viewFon: UIView = {
        let view = UIView()
        view.setupBlurEffect()
        view.roundCorner()
        view.backgroundColor = .clear
        return view
    }()
    
    private let searchField: UITextField = {
        let field = UITextField()
        
        field.placeholder = "Search Location..."
        field.leftViewMode = .always
        
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constant.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        
        field.smartQuotesType = .no // Отключение умных кавычек
        field.smartDashesType = .no // Отключение умных тире
        field.smartInsertDeleteType = .no
        field.autocorrectionType = .no
        
        let locationButton = UIButton(type: .system)
        let image = UIImage(named: "blueLocation")
        locationButton.setImage(image, for: .normal)
        locationButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        locationButton.addTarget(self, action: #selector(currentLocation), for: .touchUpInside)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        locationButton.center = containerView.center
        containerView.addSubview(locationButton)
        
        field.leftView = containerView
        
        return field
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system) // Use .system for standard button styling
        let buttonImage = UIImage(systemName: "location.fill")
        button.setImage(buttonImage, for: .normal)
        
        button.tintColor = .systemBlue
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = Constant.cornerRadius
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let listTableView: UITableView = {
       let tableView = UITableView()
        tableView.isHidden = true
        //tableView.backgroundColor = .green
        return tableView
    }()
    
    // MARK: - Life Cycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .grayRain.withAlphaComponent(0.8)
        listTableView.delegate = self
        listTableView.dataSource = self
        searchField.delegate = self
        
        SearchDataManager.shared.searchVC = self  // for singlton
        
        loadRecentCities()
        updateCityHistory()
        
        setupUI()
        //setupGestureRecognizers()
    }
    
    func updateCityHistory() {
        listTableView.reloadData()
        //listTableView.isHidden = arrayRecentCities.isEmpty
        //listTableView.isHidden = SearchDataManager.shared.arrayRecentCities.isEmpty
    }
    // MARK: - Methods
    private func setupUI() {
        
        view.addSubview(viewFon)
        viewFon.addSubview(searchField)
        viewFon.addSubview(actionButton)
        view.addSubview(listTableView)
        
        setupConstraints()
        setupCellTableView()
    }
    
    private func setupConstraints() {
        viewFon.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewFon.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            viewFon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewFon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewFon.heightAnchor.constraint(equalToConstant: 80),
            
            searchField.centerYAnchor.constraint(equalTo: viewFon.centerYAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 35),
            searchField.leadingAnchor.constraint(equalTo: viewFon.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -10),
            
            actionButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 35),
            actionButton.trailingAnchor.constraint(equalTo: viewFon.trailingAnchor, constant: -20),
            actionButton.widthAnchor.constraint(equalToConstant: 40),
            
            listTableView.topAnchor.constraint(equalTo: viewFon.bottomAnchor, constant: 20),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            listTableView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // viewFon.setGradientBackground(UIColor(hex: "5F9BDC"), UIColor(hex: "77AAD2"))
    }
    
//    private func setupGestureRecognizers() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tapGesture)
//    }
    
    private func setupCellTableView() {
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
    }
    
    private func loadRecentCities() {
        if let savedCities = UserDefaults.standard.array(forKey: "RecentCities") as? [String] {
            SearchDataManager.shared.arrayRecentCities = savedCities
        }
    }
    
    
    // MARK: - Actions
    @objc private func currentLocation() {
        d.print("Button currentLocation tapped!", self)
        DataManager.shared.getCurrentLocation()
        dismiss(animated: true)
    }
    
    @objc private func buttonTapped() {
        d.print("Button OK tapped!", self)
        SearchDataManager.shared.requestByCityName(searchField)
    }
    
//    @objc private func dismissKeyboard() {
//           view.endEditing(true)
//    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        d.print("Return button pressed", self)
        //textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //listTableView.reloadData()
        listTableView.isHidden = false
       }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        d.print("textFieldShouldEndEditing", self)
        if textField.text?.isEmpty == true {
            textField.placeholder = "Enter city"
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        SearchDataManager.shared.requestByCityName(textField)
//        listTableView.isHidden = true
//        d.print("textFieldDidEndEditing", self)
//        guard let nameCity = textField.text, !nameCity.isEmpty else { return }
//        
//        if !SearchDataManager.shared.arrayRecentCities.contains(nameCity) {
//            SearchDataManager.shared.arrayRecentCities.insert(nameCity, at: 0)
//            if SearchDataManager.shared.arrayRecentCities.count > 9 {
//                SearchDataManager.shared.arrayRecentCities.removeLast()
//            }
//            
//            UserDefaults.standard.set(SearchDataManager.shared.arrayRecentCities, forKey: "RecentCities")
//            UserDefaults.standard.synchronize()
//        }
//        // dataManager?.loadData(nameCity: nameCity)
//        // Можно использовать NotificationCenter, если нужно отправить уведомление
//        let userInfo = ["CityName": nameCity]
//        NotificationCenter.default.post(name: .sendCityNameNotify, object: nil, userInfo: userInfo)
//        
//        searchField.text = ""
//        //dismiss(animated: true)
    }
     
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SearchDataManager.shared.getDisplayedCities().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        let city = SearchDataManager.shared.getDisplayedCities()
        cell.textLabel?.text = city[indexPath.row]
        //cell.textLabel?.text = SearchDataManager.shared.arrayRecentCities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        d.print("Delegat of tableView: didSelectRowAt", self)
        let selectCity = SearchDataManager.shared.getDisplayedCities()[indexPath.row]
        
        searchField.text = selectCity
        //listTableView.isHidden = true
        searchField.resignFirstResponder()
        //dismissKeyboard()
    }
}
