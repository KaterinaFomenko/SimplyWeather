//
//  SearchLocationCell.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 22/09/2024.
//

import Foundation
import UIKit

protocol SearchLocationCellDelegate: AnyObject {
    func didBeginEditingInCell(_ cell: SearchLocationCell)
}

class SearchLocationCell: UITableViewCell, Logable  {
    var logOn: Bool = false
    weak var delegate:  SearchLocationCellDelegate?
    
    // MARK: - Variables
    static let identifier = "SearchLocationCell"
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
        
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constant.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        
        field.smartQuotesType = .no // Отключение умных кавычек
        field.smartDashesType = .no // Отключение умных тире
        field.smartInsertDeleteType = .no
        field.autocorrectionType = .no
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
    
    @objc private func currentLocation() {
        DataManager.shared.getCurrentLocation()
    }
    
    @objc func buttonTapped() {
        d.print("Button tapped!", self)
        textFieldDidEndEditing(searchField)
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
            searchField.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -10),
            
            actionButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 35),
            actionButton.trailingAnchor.constraint(equalTo: viewFon.trailingAnchor, constant: -20),
            actionButton.widthAnchor.constraint(equalToConstant: 40)
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

extension SearchLocationCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.didBeginEditingInCell(self) // Переход на следующий экран
        return false // Возвращаем false, чтобы клавиатура не отображалась
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        d.print("textFieldDidEndEditing", self)
        if let nameCity = textField.text, !nameCity.isEmpty {
            //1) на прямую передать
            //dataManager?.loadData(nameCity: nameCity)
            
            //2) NotificationCenter
            NotificationCenter.default.post(
                name: .sendCityNameNotify,
                object: nil,
                userInfo: ["CityName": nameCity]
            )
        }
        searchField.text = ""
    }
}







