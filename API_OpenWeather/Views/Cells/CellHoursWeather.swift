//
//  CellHourlнWeather.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 30/10/2024.
//

import Foundation
import UIKit

enum Hours: String, CaseIterable {
    case hour0 = "00"
    case hour3 = "03"
    case hour6 = "06"
    case hour9 = "09"
    case hour12 = "12"
    case hour15 = "15"
    case hour16 = "18"
    case hour17 = "21"
    case hour00 = "000"
    case hour03 = "003"
    case hour06 = "006"
    case hour09 = "009"
    case hour012 = "012"
    case hour015 = "015"
    case hour018 = "018"
    case hour021 = "021"
}

enum TempOfHours: String, CaseIterable {
    case hour0 = "00"
    case hour3 = "03"
    case hour6 = "06"
    case hour9 = "09"
    case hour12 = "12"
    case hour15 = "15"
    case hour16 = "18"
    case hour17 = "21"
    case hour00 = "000"
    case hour03 = "003"
    case hour06 = "006"
    case hour09 = "009"
    case hour012 = "012"
    case hour015 = "015"
    case hour018 = "018"
    case hour021 = "021"
}

enum ImagesOfHours: CaseIterable {
    case mon1Image
    case mon2Image
    case mon3Image
    case mon4Image
    case mon5Image
    case mon6Image
    case mon7Image
    case mon8Image
    case mon9Image
    case mon10Image
    case mon11Image
    case mon12Image
    case mon13Image
    case mon14Image
    case mon15Image
    case mon16Image
    
    var imageForDay: UIImage? {
        switch self {
        case .mon1Image:
            return UIImage(systemName: "sun.max")
        case .mon2Image:
            return UIImage(systemName: "sun.max")
        case .mon3Image:
            return UIImage(systemName: "sun.max")
        case .mon4Image:
            return UIImage(systemName: "sun.max")
        case .mon5Image:
            return UIImage(systemName: "sun.max")
        case .mon6Image:
            return UIImage(systemName: "sun.max")
        case .mon7Image:
            return UIImage(systemName: "sun.max")
        case .mon8Image:
            return UIImage(systemName: "sun.max")
        case .mon9Image:
            return UIImage(systemName: "sun.max")
        case .mon10Image:
            return UIImage(systemName: "sun.max")
        case .mon11Image:
            return UIImage(systemName: "sun.max")
        case .mon12Image:
            return UIImage(systemName: "sun.max")
        case .mon13Image:
            return UIImage(systemName: "sun.max")
        case .mon14Image:
            return UIImage(systemName: "sun.max")
        case .mon15Image:
            return UIImage(systemName: "sun.max")
        case .mon16Image:
            return UIImage(systemName: "sun.max")
        }
    }
}

class CellHoursWeather: UITableViewCell {
    
    // MARK: - Variables
    
    static let identifier = "CellHoursWeather"
    
    private var hoursLabels: [UILabel] = []
    private var tempsOneLabels: [UILabel] = []
    private var imagesOneForecast: [UIImageView] = []
    
    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        // scroll.showsHorizontalScrollIndicator = true
        // scroll.contentSize = contentSize
        scroll.backgroundColor = .clear
        return scroll
    }()
    
    private lazy var contentViewInScroll: UIView = {
        let contentView = UIView()
        contentView.setupBlurEffect()
        contentView.roundCorner()
        //   contentView.frame.size = contentSize
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        setupLabels()
        setupTempsLabels()
        setupImagesOfDay()
        layoutLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func configure(array: [ForecastModel]) {
        print("!!! arrayHours count: \(array.count) ")
        let testArray = [
            ForecastModel(id: 804, temp: 55.36, dataTxt: "2024-10-31 12:00:00"),
            ForecastModel(id: 804, temp: 54.99, dataTxt: "2024-10-31 15:00:00")
        ]
        
        // Получаем 16 часов в двух днях
        let hoursTwoDays = ForecastDataManager.shared.hoursForecastArray
        // ??? hoursTwoDays.enumerated заменить на array: [ForecastModel
        // Устанавливаем дни недели в labels
        for (i, hour) in hoursTwoDays.enumerated() {
            
            print("+++HOUR==== \(hour)")
            if i < hoursLabels.count { // Проверяем, что индекс не выходит за пределы массива температур
                
                hoursLabels[i].text = array[i].dataTxt.extractHour()
                print("!!! hoursLabels[i] : \(hoursLabels[i].text ?? "")")
                
                tempsOneLabels[i].text = array[i].temp.convertFarhToCelsium().rounded().convertToString() + "\u{00B0}"
                
                imagesOneForecast[i].sd_setImage(with: array[i].logoURL, placeholderImage: UIImage(systemName: "questionmark"))
            }
        }
    }
    
    private func setupLabels() {
        for day in Hours.allCases {
            let label = UILabel()
            label.textColor = .systemGray6
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.text = day.rawValue
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: 30), // Задание фиксированной высоты
                label.widthAnchor.constraint(equalToConstant: 50)  // Задание фиксированной ширины
            ])
            hoursLabels.append(label)
        }
    }
    
    private func setupTempsLabels() {
        for tempElement in TempOfHours.allCases {
            let label = UILabel()
            label.textColor = .white
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 25, weight: .regular)
            label.text = tempElement.rawValue
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: 50), // Задание фиксированной высоты
                label.widthAnchor.constraint(equalToConstant: 50)  // Задание фиксированной ширины
            ])
            tempsOneLabels.append(label)
        }
    }
    
    private func setupImagesOfDay() {
        for imageCase in ImagesOfHours.allCases {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = imageCase.imageForDay
            iv.tintColor = .black
            
            iv.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                iv.heightAnchor.constraint(equalToConstant: 50), // Задание фиксированной высоты
//                iv.widthAnchor.constraint(equalToConstant: 80)  // Задание фиксированной ширины
//            ])
            
            imagesOneForecast.append(iv)
        }
    }
    
    private func layoutLabels() {
        let hoursStackView = UIStackView(arrangedSubviews: hoursLabels)
        hoursStackView.axis = .horizontal
        hoursStackView.spacing = 8
        hoursStackView.distribution = .fillEqually
        hoursStackView.alignment = .center
        
        let tempsStackView = UIStackView(arrangedSubviews: tempsOneLabels)
        tempsStackView.axis = .horizontal
        tempsStackView.spacing = 8
        tempsStackView.distribution = .fillEqually
        tempsStackView.alignment = .center
        
        let imageStackView = UIStackView(arrangedSubviews: imagesOneForecast)
        imageStackView.axis = .horizontal
        imageStackView.spacing = 8
        imageStackView.distribution = .fillEqually
        imageStackView.alignment = .center
        
        let mainStackView = UIStackView(arrangedSubviews: [hoursStackView, imageStackView, tempsStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .fillEqually
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentViewInScroll)
        contentViewInScroll.addSubview(mainStackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentViewInScroll.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            contentViewInScroll.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentViewInScroll.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentViewInScroll.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentViewInScroll.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            mainStackView.topAnchor.constraint(equalTo: contentViewInScroll.topAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: contentViewInScroll.bottomAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: contentViewInScroll.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentViewInScroll.trailingAnchor, constant: -20),
            
            mainStackView.heightAnchor.constraint(equalToConstant: 150) // 200
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Обновляем размер градиентного слоя при изменении размеров ячейки
        contentViewInScroll.layer.sublayers?.forEach { layer in
            if layer is CAGradientLayer {
                layer.frame = contentViewInScroll.bounds
            }
        }
    }
}
