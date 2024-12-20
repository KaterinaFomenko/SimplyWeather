//
//  SearchViewController.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 17/12/2024.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, Logable  {
    var logOn: Bool = true
    
    // MARK: - Variables
    weak var dataManager: DataManager?
    
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
        locationButton.addTarget(nil, action: #selector(currentLocation), for: .touchUpInside)
        
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
    
    // MARK: - Life Cycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        searchField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        
        view.addSubview(viewFon)
        viewFon.addSubview(searchField)
        viewFon.addSubview(actionButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        viewFon.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            actionButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        // viewFon.setGradientBackground(UIColor(hex: "5F9BDC"), UIColor(hex: "77AAD2"))
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @objc private func currentLocation() {
        d.print("Button currentLocation tapped!", self)
        DataManager.shared.getCurrentLocation()
        dismiss(animated: true)
    }
    
    @objc private func buttonTapped() {
        d.print("Button OK tapped!", self)
        textFieldDidEndEditing(searchField)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        d.print("searchField \(searchField.text!)", self)
        d.print("Return button pressed", self)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        d.print("textFieldShouldEndEditing", self)
        if textField.text?.isEmpty == true {
            textField.placeholder = "Enter city"
            d.print("Empty text", self)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.returnKeyType = .search
        } else {
            textField.returnKeyType = .done
        }
        textField.reloadInputViews() // Обновляем клавиатуру для применения изменений
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        d.print("textFieldDidEndEditing", self)
        if let nameCity = searchField.text {
            //dataManager?.loadData(nameCity: nameCity)
            
            // Можно использовать NotificationCenter, если нужно отправить уведомление
            let userInfo = ["CityName": nameCity]
            NotificationCenter.default.post(name: .sendCityNameNotify, object: nil, userInfo: userInfo)
        }
        searchField.text = ""
        dismiss(animated: true)
    }
}
