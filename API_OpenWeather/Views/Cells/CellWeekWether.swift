//
//  CellWeekWether.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 28/09/2024.
//

import Foundation
import UIKit

enum DaysOfWeek: String, CaseIterable {
    case mon = "MON"
    case tue = "TUE"
    case wed = "WED"
    case thu = "THU"
    case fri = "FRI"
}

enum TempOfWeek: String, CaseIterable {
    case monTemp = "0.1"
    case tueTemp = "0.2"
    case wedTemp = "0.3"
    case thuTemp = "0.4"
    case friTemp = "0.5"
}

enum ImagesOfWeek: CaseIterable {
    case monImage
    case tueImage
    case wedImage
    case thuImage
    case friImage

    var imageForDay: UIImage? {
        switch self {
        case .monImage:
            return UIImage(systemName: "sun.max")
        case .tueImage:
            return UIImage(systemName: "sun.max")
        case .wedImage:
            return UIImage(systemName: "sun.max")
        case .thuImage:
            return UIImage(systemName: "sun.max")
        case .friImage:
            return UIImage(systemName: "sun.max")
        }
    }
}

class CellWeekWether: UITableViewCell {
    
    // MARK: - Variables
    
    static let identifier = "WeekWetherCell"
    
    private var daysLabels: [UILabel] = []
    private var tempsLabels: [UILabel] = []
    private var imagesForecast: [UIImageView] = []
    
    var currentDay = Date().formatted(.dateTime.weekday(.abbreviated)).uppercased() //THU
    
    // MARK: - UI Components
    private lazy var contentViewInScroll: UIView = {
        let contentView = UIView()
        contentView.setupBlurEffect()
        contentView.roundCorner()
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        setupLabels()
        setupTempsLabels()
        setupImagesOfWeek()
        layoutLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func configure(array: [ForecastModel]) {
        // Получаем пять дней недели
        
        let fiveDays = ForecastDataManager.shared.getFiveDays(currentDay)
        
        // Устанавливаем дни недели в labels
        for (i, day) in fiveDays.enumerated() {
            
            daysLabels[i].text = day
            
            if i < array.count {
                tempsLabels[i].text = array[i].temp.convertFarhToCelsium().convertToString() + "\u{00B0}"
                imagesForecast[i].image = UIImage(named: array[i].logoURL)
            }
        }
    }
    
    private func setupLabels() {
        for day in DaysOfWeek.allCases {
            let label = UILabel()
            label.textColor = .systemGray6
            label.textAlignment = .center
            label.font = UIFont.customFont(size: 25, weight: .regular)
            label.text = day.rawValue
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: 30),
                label.widthAnchor.constraint(equalToConstant: 50)
            ])
            daysLabels.append(label)
        }
    }
    
    private func setupTempsLabels() {
        for tempElement in TempOfWeek.allCases {
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 25, weight: .regular)
            label.text = tempElement.rawValue
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: 50),
                label.widthAnchor.constraint(equalToConstant: 50)
            ])
            tempsLabels.append(label)
        }
    }
    
    private func setupImagesOfWeek() {
        for imageCase in ImagesOfWeek.allCases {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = imageCase.imageForDay
            iv.tintColor = .white
            
            iv.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                iv.heightAnchor.constraint(equalToConstant: 60),
                iv.widthAnchor.constraint(equalToConstant: 80)
            ])
            imagesForecast.append(iv)
        }
    }
    
    private func layoutLabels() {
        
        let daysStackView = UIStackView(arrangedSubviews: daysLabels)
        // daysStackView.backgroundColor = .red
        daysStackView.axis = .horizontal
        daysStackView.spacing = 5
        daysStackView.distribution = .fillEqually
        daysStackView.alignment = .center
        
        let tempsStackView = UIStackView(arrangedSubviews: tempsLabels)
        //tempsStackView.backgroundColor = .purple
        tempsStackView.axis = .horizontal
        tempsStackView.spacing = 5
        tempsStackView.distribution = .fillEqually
        tempsStackView.alignment = .center
        
        let imageStackView = UIStackView(arrangedSubviews: imagesForecast)
        //imageStackView.backgroundColor = .green
        imageStackView.axis = .horizontal
        imageStackView.spacing = 5
        imageStackView.distribution = .fillEqually
        imageStackView.alignment = .center
        
        let mainStackView = UIStackView(arrangedSubviews: [daysStackView,  tempsStackView, imageStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .equalSpacing //.fillEqually
        
        contentViewInScroll.addSubview(mainStackView)
        contentView.addSubview(contentViewInScroll)
        
        contentViewInScroll.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            contentViewInScroll.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            contentViewInScroll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentViewInScroll.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentViewInScroll.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            mainStackView.topAnchor.constraint(equalTo: contentViewInScroll.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: contentViewInScroll.bottomAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: contentViewInScroll.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentViewInScroll.trailingAnchor, constant: -10)
        ])
    }
}

