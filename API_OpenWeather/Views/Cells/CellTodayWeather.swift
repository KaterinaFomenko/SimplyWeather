//
//  CellTodayWeather.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 13/09/2024.
//

import Foundation
import UIKit
import SDWebImage

// Weather Today

class CellTodayWeather: UITableViewCell {
    // MARK: - Variables
    
    static let identifier = "CellTodayWeather"
    
    // MARK: - UI Components
    
    private let viewFon: UIView = {
        let vf = UIView()
        vf.roundCorner()
        vf.backgroundColor = .clear
        vf.setupBlurEffect()
        vf.translatesAutoresizingMaskIntoConstraints = false
        return vf
    }()
    
    private lazy var vStackMainTop: UIStackView = {
        let vStack = UIElementFactory.createStackView(
            arrangedSubview: [descriptionLabel, line],
            axis: .vertical,
            spacing: 0,
            alignment: .fill
        )
        //vStack.backgroundColor = .yellow
        return vStack
    }()
    
    private lazy var vStackMainBottom: UIStackView = {
        let vStack = UIElementFactory.createStackView(
            arrangedSubview: [leftView, rightView],
            axis: .horizontal,
            spacing: 20,
            alignment: .fill,
            distributon: .fillEqually
        )
        // vStack.backgroundColor = .blue
        return vStack
    }()
    
    private lazy var vStackMain: UIStackView = {
        let vStack = UIElementFactory.createStackView(
            arrangedSubview: [vStackMainTop, vStackMainBottom],
            axis: .vertical,
            spacing: 20
        )
        vStack.isLayoutMarginsRelativeArrangement = true
        vStack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        return vStack
    }()
    
    private let descriptionLabel: UILabel = {
        UIElementFactory.createLabel(
            text: "Title",
            color: .white,
            font: UIFont.customFont(size: 25, weight: .regular))
    }()
    
    private lazy var line: UIView = {
        return UIElementFactory.createLine()
    }()
    
    private let todayLabel: UILabel = {
        return UIElementFactory.createLabel(
            text: "TODAY",
            color: .white,
            font: UIFont.customFont(size: 40, weight: .bold)
        )
    }()
    
    private let minTempLabel: UILabel = {
        return UIElementFactory.createLabel(
            text: "Min",
            color: .white,
            font: .systemFont(ofSize: 25, weight: .regular)
        )
    }()
    
    private let maxTempLabel: UILabel = {
        return UIElementFactory.createLabel(
            text: "Max",
            color: .white,
            font: .systemFont(ofSize: 25, weight: .regular)
        )
    }()
    
    private lazy var leftView: UIStackView = {
        let vStack = UIElementFactory.createStackView(
            arrangedSubview: [todayLabel, minTempLabel, maxTempLabel],
            axis: .vertical,
            spacing: 12,
            alignment: .leading
        )
        //  vStack.backgroundColor = .brown
        return vStack
    }()
    
    private lazy var rightView: UIStackView = {
        let vStack = UIElementFactory.createStackView(
            arrangedSubview: [cityLabel, imageChoice],
            axis: .vertical,
            spacing: 12,
            alignment: .center
        )
        //  vStack.backgroundColor = .lightGray
        return vStack
        
    }()
    
    private let cityLabel: UILabel = {
        return UIElementFactory.createLabel(
            text: "Current Location",
            color: .white,
            font: UIFont.customFont(size: 30, weight: .regular)
        )
    }()
    
    private let imageChoice: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemYellow
        return iv
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
    public func configureMiddleCell(with model: WeatherModel) {
        
        descriptionLabel.text = model.description.capitalized
        
        let convertMin = model.tempMin.convertFarhToCelsium()
        let convertMax = model.tempMax.convertFarhToCelsium()
        
        minTempLabel.text = "min " + convertMin.convertToString() + " \u{00B0}С"
        maxTempLabel.text = "max " + convertMax.convertToString() + " \u{00B0}С"
        
        cityLabel.text = model.nameCity
        imageChoice.sd_setImage(with: model.logoURL, placeholderImage: UIImage(systemName: "questionmark"))
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
        contentView.addSubview(viewFon)
        viewFon.addSubview(vStackMain)
        
        NSLayoutConstraint.activate([
            viewFon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            viewFon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            viewFon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            viewFon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            vStackMain.topAnchor.constraint(equalTo: viewFon.topAnchor),
            vStackMain.bottomAnchor.constraint(equalTo: viewFon.bottomAnchor),
            vStackMain.leadingAnchor.constraint(equalTo: viewFon.leadingAnchor),
            vStackMain.trailingAnchor.constraint(equalTo: viewFon.trailingAnchor)
        ])
        
        viewFon.setGradientBackground(UIColor(hex: "518EDE"), UIColor(hex: "65A0DC"))
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
