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
    private var arrayDisplayedCities: [String] = {
        SearchDataManager.shared.getDisplayedCities()
    }()
    
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
        let button = UIButton(type: .system)
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
        tableView.roundCorner()
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
        configureDelegates()
        configureView()
        loadRecentCities()
        
        setupUI()
    }
    
    func configureView() {
        view.backgroundColor = .grayRain.withAlphaComponent(0.8)
    }
    
    func configureDelegates() {
        SearchDataManager.shared.searchVC = self  // for singlton
        listTableView.delegate = self
        listTableView.dataSource = self
        searchField.delegate = self
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
    }
    
    private func setupCellTableView() {
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
    }
    
    // Читаем данные из UserDefaults
    private func loadRecentCities() {
        listTableView.isHidden = false
        
        arrayDisplayedCities = UserSaving.getRecentCities()
        print("Читаем данные из UserDefaults from DisplayedCities: \(arrayDisplayedCities)")
        
        /*
         if let savedCities = UserDefaults.standard.array(forKey: "RecentCities") as? [String] {
         arrayDisplayedCities = savedCities
         print("Читаем данные из UserDefaults from DisplayedCities: \(savedCities)")
         }
         */
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
        dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //
    //        d.print("Return button pressed", self)
    //        //textField.resignFirstResponder()
    //        return true
    //    }
    
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        //listTableView.reloadData()
    //        listTableView.isHidden = false
    //       }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        d.print("textFieldShouldEndEditing", self)
        if textField.text?.isEmpty == true {
            textField.placeholder = "Enter city"
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        SearchDataManager.shared.requestByCityName(textField)
        //  listTableView.reloadData() ???
    }
    
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Count of arrayDisplayedCities: \(arrayDisplayedCities.count)")
        print("arrayDisplayedCities: \(arrayDisplayedCities)")
        return arrayDisplayedCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = arrayDisplayedCities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectCity = arrayDisplayedCities[indexPath.row]
        searchField.text = selectCity
        searchField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        // Удаляем город из массива
        let cityRemove = arrayDisplayedCities[indexPath.row]
        arrayDisplayedCities.remove(at: indexPath.row)
        print ("remote city: \(cityRemove)")
        
        UserSaving.saveRecentCities(arrayDisplayedCities)
        print("Saved array new arrayDisplayedCities \(arrayDisplayedCities)")
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        print("After deletion: \(arrayDisplayedCities)")
    }
}

