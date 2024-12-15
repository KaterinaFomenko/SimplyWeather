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
    
    private lazy var scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.showsHorizontalScrollIndicator = true
          //  scroll.contentSize = contentSize
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
    
    // StackView for descriptionLabel and line
    private lazy var vStackGeneral: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [descriptionLabel, vStackDescriptionLine])
       // vStack.backgroundColor = .systemPink
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.alignment = .center
        vStack.isLayoutMarginsRelativeArrangement = true
        vStack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0)
        return vStack
    }()
    
    // StackView for descriptionLabel and line
    private lazy var vStackDescriptionLine: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [descriptionLabel, line])
       // vStack.backgroundColor = .systemPink
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.alignment = .center
        vStack.isLayoutMarginsRelativeArrangement = true
        vStack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0)
        return vStack
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.customFont(size: 20, weight: .regular)
        label.text = "Title"
        return label
    }()
    
    private let line: UIView = {
       let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
//    private var contentSize: CGSize {
//        CGSize(width: contentView.frame.width , height: contentView.frame.height)
//    }
    
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
           
            if i < array.count { // Проверяем, что индекс не выходит за пределы массива температур
                tempsLabels[i].text = array[i].temp.convertFarhToCelsium().convertToString() + "\u{00B0}"
               
                imagesForecast[i].sd_setImage(with: array[i].logoURL, placeholderImage: UIImage(systemName: "questionmark"))
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
                label.heightAnchor.constraint(equalToConstant: 30), // Задание фиксированной высоты
                label.widthAnchor.constraint(equalToConstant: 50)  // Задание фиксированной ширины
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
                label.heightAnchor.constraint(equalToConstant: 50), // Задание фиксированной высоты
                label.widthAnchor.constraint(equalToConstant: 50)  // Задание фиксированной ширины
            ])
            tempsLabels.append(label)
        }
    }
    
    private func setupImagesOfWeek() {
        for imageCase in ImagesOfWeek.allCases {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            iv.image = imageCase.imageForDay
            iv.tintColor = .black

            iv.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                iv.heightAnchor.constraint(equalToConstant: 50), // Задание фиксированной высоты
                iv.widthAnchor.constraint(equalToConstant: 80)  // Задание фиксированной ширины
            ])

            imagesForecast.append(iv)
        }
    }

    private func layoutLabels() {
        
        let daysStackView = UIStackView(arrangedSubviews: daysLabels)
       // daysStackView.backgroundColor = .red
        daysStackView.axis = .horizontal
        daysStackView.spacing = 8
        daysStackView.distribution = .fillEqually
        daysStackView.alignment = .center
        
        let tempsStackView = UIStackView(arrangedSubviews: tempsLabels)
        //tempsStackView.backgroundColor = .purple
        tempsStackView.axis = .horizontal
        tempsStackView.spacing = 8
        tempsStackView.distribution = .fillEqually
        tempsStackView.alignment = .center
        
        let imageStackView = UIStackView(arrangedSubviews: imagesForecast)
        //imageStackView.backgroundColor = .green
        imageStackView.axis = .horizontal
        imageStackView.spacing = 8
        imageStackView.distribution = .fillEqually
        imageStackView.alignment = .center
        
        let mainStackView = UIStackView(arrangedSubviews: [daysStackView, imageStackView, tempsStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.distribution = .fillEqually
        
        contentViewInScroll.addSubview(mainStackView)
        contentView.addSubview(contentViewInScroll)
        
        contentViewInScroll.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
           
            contentViewInScroll.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentViewInScroll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentViewInScroll.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentViewInScroll.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Фиксация ширины контента
            
            mainStackView.topAnchor.constraint(equalTo: contentViewInScroll.topAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: contentViewInScroll.bottomAnchor, constant: 0),
            mainStackView.leadingAnchor.constraint(equalTo: contentViewInScroll.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentViewInScroll.trailingAnchor, constant: -20),
            
            mainStackView.heightAnchor.constraint(equalToConstant: 150)
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

