//
//  TodayWeatherCell.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 13/09/2024.
//

import Foundation
import UIKit
import SDWebImage

// Weather Today

class TodayWeatherCell: UITableViewCell {
    // MARK: - Variables
    
    static let identifier = "CellTodayWeather"
    
    // MARK: - UI Components
    
    // ---line + descriptionLabel---
    
    private let descriptionLabel: UILabel = {
        UIElementFactory.createLabel(
            text: "Title",
            color: .white,
            font: UIFont.customFont(size: 25, weight: .regular))
    }()
    
    private lazy var line: UIView = {
        return UIElementFactory.createLine()
    }()
    
    private lazy var descriptionLineStack: UIStackView = {
        let vStack = UIElementFactory.createStackView(
            arrangedSubview: [descriptionLabel, line],
            axis: .vertical,
            spacing: 0,
            alignment: .fill
        )
        return vStack
    }()
    
    // ---today + cityLabel---
    
    
    private let todayLabel: UILabel = {
        let label = UIElementFactory.createLabel(
            text: "TODAY",
            color: .white,
            font: UIFont.customFont(size: 30, weight: .regular)
        )
       // label.backgroundColor = .red
        return label
    }()
    
    private let cityLabel: UILabel = {
        
        let label = UIElementFactory.createLabel(
            text: "Current Location",
            color: .white,
            font: UIFont.customFont(size: 40, weight: .bold)
        )
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        
        let maxWidth: CGFloat = UIScreen.main.bounds.width - 40  // Например, ширина экрана минус отступы
        let text = label.text ?? ""
        let font = label.font
        
        // Рассчитываем ширину текста
        let textSize = (text as NSString).boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: font?.lineHeight ?? 18),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font ?? UIFont.systemFont(ofSize: 17)],
            context: nil
        )
        
        // Устанавливаем ширину метки по рассчитанной ширине или максимальной ширине
        label.frame.size.width = min(textSize.width, maxWidth)
        
        return label
    }()
    
    private lazy var todayCityNameStack: UIStackView = {
        let vStack = UIElementFactory.createStackView(
            arrangedSubview: [todayLabel, cityLabel],
            axis: .horizontal,
            spacing: 50,
            alignment: .fill,
            distribution: .fill
        )
        // vStack.backgroundColor = .blue
        return vStack
    }()
    
    // ---temp + image---
    private let tempLabel: UILabel = {
        return UIElementFactory.createLabel(
            text: "Temp",
            color: .white,
            font: .systemFont(ofSize: 65, weight: .regular),
            alignment:  .left
        )
    }()
    
    private let imageChoice: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemYellow
        return iv
    }()
    
    private lazy var tempImageStack: UIStackView = {
        let vStack = UIElementFactory.createStackView(
            arrangedSubview: [tempLabel, imageChoice],
            axis: .horizontal,
            spacing: 0,
            alignment: .fill,
            distribution: .fillEqually
        )
        // vStack.backgroundColor = .blue
        return vStack
    }()
    
    // ---summary stack---
    private lazy var summaryStack: UIStackView = {
        let vStack = UIElementFactory.createStackView(
            arrangedSubview: [todayCityNameStack, tempImageStack],
            axis: .vertical,
            spacing: 10
        )
        // vStack.isLayoutMarginsRelativeArrangement = true
        // vStack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        return vStack
    }()
    
    private let blurEffectFonView: UIView = {
        let vf = UIView()
        vf.roundCorner()
        vf.backgroundColor = .clear
        vf.setupBlurEffect()
        vf.translatesAutoresizingMaskIntoConstraints = false
        return vf
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        setupUI()
        setupSizeImage(width: 80, height: 80)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func updateTempLabel(with temperature: String) {
        let baseFont = UIFont.systemFont(ofSize: 65, weight: .regular)
        let degreeFont = UIFont.systemFont(ofSize: 30, weight: .regular)
        
        let temperatureString = temperature
        let degreeString = " \u{00B0}С"
        
        let attributedText = NSMutableAttributedString(
            string: temperatureString,
            attributes: [.font: baseFont]
        )
        
        // Смещение на 30% от размера базового шрифта
        let degreeAttributes: [NSAttributedString.Key: Any] = [
               .font: degreeFont,
               .baselineOffset: baseFont.pointSize * 0.35
           ]

        let degreeAttributedString = NSAttributedString(string: degreeString, attributes: degreeAttributes)
        attributedText.append(degreeAttributedString)
        tempLabel.attributedText = attributedText
    }
    
    public func configureMiddleCell(with model: WeatherModel) {
        
        let convertTemp =  model.temp.convertFarhToCelsium()
        let temperatureString = convertTemp.convertToString()
        
        descriptionLabel.text = model.description.capitalized
        
        cityLabel.text = model.nameCity
        imageChoice.sd_setImage(with: model.logoURL, placeholderImage: UIImage(systemName: "questionmark"))
        
        updateTempLabel(with: temperatureString)
    }
    
    private func setupSizeImage(width: CGFloat, height: CGFloat) {
        imageChoice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageChoice.widthAnchor.constraint(equalToConstant: width),
            imageChoice.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setupUI() {
        
        contentView.clipsToBounds = true
        contentView.addSubview(blurEffectFonView)
        blurEffectFonView.addSubview(descriptionLineStack)
        blurEffectFonView.addSubview(summaryStack)
        
        NSLayoutConstraint.activate([
            blurEffectFonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            blurEffectFonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            blurEffectFonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            blurEffectFonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            summaryStack.topAnchor.constraint(equalTo: descriptionLineStack.bottomAnchor),
            summaryStack.bottomAnchor.constraint(equalTo: blurEffectFonView.bottomAnchor, constant: -10),
            summaryStack.leadingAnchor.constraint(equalTo: blurEffectFonView.leadingAnchor, constant: 20),
            summaryStack.trailingAnchor.constraint(equalTo: blurEffectFonView.trailingAnchor, constant: -10),
            
            descriptionLineStack.topAnchor.constraint(equalTo: blurEffectFonView.topAnchor, constant: 0),
            descriptionLineStack.bottomAnchor.constraint(equalTo: summaryStack.topAnchor, constant: -20),
            descriptionLineStack.leadingAnchor.constraint(equalTo: blurEffectFonView.leadingAnchor, constant: 20),
            descriptionLineStack.trailingAnchor.constraint(equalTo: blurEffectFonView.trailingAnchor, constant: -20),
            
            //cityLabel.trailingAnchor.constraint(equalTo: blurEffectFonView.trailingAnchor, constant: 10)
           
        ])
        
    blurEffectFonView.setGradientBackground(
        UIColor(hex: "518EDE"),
        UIColor(hex: "65A0DC")
    )
    }
   
}
    //    override func layoutSubviews() {
    //           super.layoutSubviews()
    //
    //           // Обновляем размер градиентного слоя при изменении размеров ячейки
    //                       blurEffectFonView.layer.sublayers?.forEach { layer in
    //               if layer is CAGradientLayer {
    //                   layer.frame = viewFon.bounds
    //               }
    //           }
    //       }
    

