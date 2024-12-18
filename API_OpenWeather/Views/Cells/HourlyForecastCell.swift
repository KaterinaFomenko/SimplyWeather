//
//  CellHourlнWeather.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 30/10/2024.
//

import Foundation
import UIKit

enum HoursMock: String, CaseIterable {
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

enum TempOfHoursMock: String, CaseIterable {
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

enum ImagesOfHoursMock: CaseIterable {
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

class HourlyForecastCell: UITableViewCell, Logable {
    var logOn: Bool = false
    
    // MARK: - Variables
    
    static let identifier = "HourlyForecastCell"
    
    private var hoursLabels: [UILabel] = []
    private var tempsOneLabels: [UILabel] = []
    private var imagesOneForecast: [UIImageView] = []
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        
        let label = UIElementFactory.createLabel(
            text: "Hourly Forecast",
            color: .white,
            font: UIFont.customFont(size: 25, weight: .regular)
        )
        //label.textAlignment = .center
            return label
    }()
    
    private let line: UIView = {
        return UIElementFactory.createLine()
    }()
    
    private lazy var titleLineStack: UIStackView = {
        let vStack = UIElementFactory.createStackView(
            arrangedSubview: [titleLabel, line],
            axis: .vertical,
            spacing: 20,
            alignment: .fill
        )
        return vStack
    }()
    
    private var hoursStackView: UIStackView {
        return UIElementFactory.createStackView(
            arrangedSubview: hoursLabels,
            axis: .horizontal,
            spacing: 8,
            alignment: .center,
            distribution: .fillEqually
        )
    }
    
    private var tempsStackView: UIStackView {
        return UIElementFactory.createStackView(
            arrangedSubview: tempsOneLabels,
            axis: .horizontal,
            spacing: 8,
            alignment: .center,
            distribution: .fillEqually
        )
    }
    
    private var imageStackView: UIStackView {
        return UIElementFactory.createStackView(
            arrangedSubview: imagesOneForecast,
            axis: .horizontal,
            spacing: 8,
            alignment: .center,
            distribution: .fillEqually
        )
    }
    
    private lazy var summaryStackView: UIStackView = {
        let stack = UIElementFactory.createStackView(
            arrangedSubview: [hoursStackView, tempsStackView, imageStackView],
            axis: .vertical,
            spacing: 0,
            alignment: .fill,
            distribution: .fillEqually
        )
       // stack.backgroundColor = .systemPink
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.bouncesVertically = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var blurEffectFonView: UIView = {
            let contentView = UIView()
            contentView.setupBlurEffect()
            contentView.roundCorner()
            contentView.translatesAutoresizingMaskIntoConstraints = false
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
        d.print("!!! arrayHours count: \(array.count) ", self)
//        let testArray = [
//            ForecastModel(id: 804, temp: 55.36, dataTxt: "2024-10-31 12:00:00"),
//            ForecastModel(id: 804, temp: 54.99, dataTxt: "2024-10-31 15:00:00")
//        ]
        
        // Получаем 16 часов в двух днях
        let hoursTwoDays = ForecastDataManager.shared.hoursForecastArray
            
        // Устанавливаем дни недели в labels
        for (i, hour) in hoursTwoDays.enumerated() {
            
            d.print("+++Значение \(hour)", self)
            if i < hoursLabels.count { // Проверяем, что индекс не выходит за пределы массива температур
                
                hoursLabels[i].text = array[i].dataTxt.extractHour()
                d.print("!!! hoursLabels[i] : \(hoursLabels[i].text ?? "")", self)
                
                tempsOneLabels[i].text = array[i].temp.convertFarhToCelsium().rounded().convertToString() + "\u{00B0}"
                
                imagesOneForecast[i].sd_setImage(with: array[i].logoURL, placeholderImage: UIImage(systemName: "questionmark"))
            }
        }
    }
    
    private func setupLabels() {
        hoursLabels.removeAll()
        for hour in HoursMock.allCases {
            let label = UILabel()
            label.textColor = .systemGray6
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.text = hour.rawValue
            
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: 30),
                label.widthAnchor.constraint(equalToConstant: 50)
            ])
            
            hoursLabels.append(label)
        }
    }
    
    private func setupTempsLabels() {
        tempsOneLabels.removeAll()
        for tempElement in TempOfHoursMock.allCases {
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
            tempsOneLabels.append(label)
        }
    }
    
    private func setupImagesOfDay() {
        imagesOneForecast.removeAll()
        for imageCase in ImagesOfHoursMock.allCases {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = imageCase.imageForDay
            iv.tintColor = .black
            
            iv.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                iv.heightAnchor.constraint(equalToConstant: 50), // Задание фиксированной высоты
                iv.widthAnchor.constraint(equalToConstant: 80)  // Задание фиксированной ширины
            ])
            
            imagesOneForecast.append(iv)
        }
    }
    
    private func layoutLabels() {
        
        contentView.addSubview(blurEffectFonView)
        blurEffectFonView.addSubview(titleLineStack)
        blurEffectFonView.addSubview(scrollView)
        scrollView.addSubview(summaryStackView)
        
        NSLayoutConstraint.activate([
            //backgroundColor = .systemPink
            summaryStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            summaryStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            summaryStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            summaryStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            
            titleLineStack.topAnchor.constraint(equalTo: blurEffectFonView.topAnchor, constant: 20),
            titleLineStack.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: -10),
            titleLineStack.leadingAnchor.constraint(equalTo: blurEffectFonView.leadingAnchor, constant: 20),
            titleLineStack.trailingAnchor.constraint(equalTo: blurEffectFonView.trailingAnchor, constant: -20),
            
            //backgroundColor = .brown
            scrollView.topAnchor.constraint(equalTo: titleLineStack.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: blurEffectFonView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: blurEffectFonView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: blurEffectFonView.trailingAnchor),
            
            blurEffectFonView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurEffectFonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            blurEffectFonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            blurEffectFonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Обновляем размер градиентного слоя при изменении размеров ячейки
        blurEffectFonView.layer.sublayers?.forEach { layer in
            if layer is CAGradientLayer {
                layer.frame = blurEffectFonView.bounds
            }
        }
    }
}
