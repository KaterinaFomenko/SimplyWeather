//
//  CellBottom.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 22/09/2024.
//

import Foundation
import UIKit

class CellBottom: UITableViewCell  {
    
    // MARK: - Variables
    
    static let identifier = "CellBottom"
    weak var dataManager: DataManager?  
    
    // MARK: - UI Components
    
    private var viewFon: UIView = {
        let vf = UIView()
        vf.setupBlurEffect()
        vf.roundCorner()
        vf.backgroundColor = .clear
        return vf
    }()
    
    private let searchField: UITextField = {
        let field = UITextField()
        
        field.placeholder = "Search Location..."
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constant.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        
        field.smartQuotesType = .no // Отключение умных кавычек
        field.smartDashesType = .no // Отключение умных тире
        field.smartInsertDeleteType = .no
        field.autocorrectionType = .no
    
        return field
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system) // Use .system for standard button styling
        let buttonImage = UIImage(systemName: "location.fill")
        button.setImage(buttonImage, for: .normal)
        
        button.tintColor = .systemBlue
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc func buttonTapped() {
        print("Button tapped!")
        DataManager.shared.getCurrentLocation()
    }
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        searchField.delegate = self
        setupUI()

        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // MARK: - Methods
    
    private func setupUI() {
        
        contentView.addSubview(viewFon)
        viewFon.addSubview(searchField)
        viewFon.addSubview(actionButton)
        
        viewFon.translatesAutoresizingMaskIntoConstraints = false
        searchField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewFon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            viewFon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            viewFon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            viewFon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            searchField.centerYAnchor.constraint(equalTo: viewFon.centerYAnchor),
            
            searchField.heightAnchor.constraint(equalToConstant: 35),
            
            searchField.leadingAnchor.constraint(equalTo: viewFon.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: viewFon.trailingAnchor, constant: -80),
            
            actionButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            actionButton.leadingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: viewFon.trailingAnchor, constant: -20),
           
            actionButton.heightAnchor.constraint(equalToConstant: 35)
            ])
        
      //  viewFon.setGradientBackground(UIColor(hex: "5F9BDC"), UIColor(hex: "77AAD2"))
    }
    
//    override func layoutSubviews() {
//           super.layoutSubviews()
//           
//           // Обновляем размер градиентного слоя при изменении размеров ячейки
//           viewFon.layer.sublayers?.forEach { layer in
//               if layer is CAGradientLayer {
//                   layer.frame = viewFon.bounds
//               }
//           }
//       }
  
}

extension CellBottom: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("searchField \(searchField.text!)")
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter city"
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        if let nameCity = searchField.text {
            //dataManager?.loadData(nameCity: nameCity)
            
            // Можно использовать NotificationCenter, если нужно отправить уведомление
            let userInfo = ["CityName": nameCity]
            NotificationCenter.default.post(name: .sendCityNameNotify, object: nil, userInfo: userInfo)
        }
        searchField.text = ""
    }
}




