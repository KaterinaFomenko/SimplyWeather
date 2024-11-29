//
//  CellMiddle.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 13/09/2024.
//

import Foundation
import UIKit
import SDWebImage

class CellMiddle: UITableViewCell {
    // MARK: - Variables
    
    static let identifier = "CellMiddle"
    
    // MARK: - UI Components
    
    private var viewFon: UIView = {
        let vf = UIView()
        vf.roundCorner()
        vf.backgroundColor = .clear
        vf.setupBlurEffect()
        return vf
    }()
    
    private lazy var vStackMain: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [vStackMainTop, vStackMainBottom])
       // vStack.backgroundColor = .systemPink
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.alignment = .center
        vStack.isLayoutMarginsRelativeArrangement = true
        vStack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 0)
        return vStack
    }()
    
    private lazy var vStackMainTop: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [descriptionLabel, line])
        //vStackMainBottom.backgroundColor = .systemPink
        vStack.axis = .vertical
        vStack.spacing = 20
        vStack.distribution = .equalSpacing
        vStack.alignment = .center
        vStack.isLayoutMarginsRelativeArrangement = true
        vStack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
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
    
    private lazy var vStackMainBottom: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [leftView, rightView])
        //vStackMainBottom.backgroundColor = .systemPink
        vStack.axis = .horizontal
        vStack.spacing = 20
        vStack.distribution = .fillEqually
        vStack.alignment = .center
        vStack.isLayoutMarginsRelativeArrangement = true
        vStack.layoutMargins = UIEdgeInsets(top: 20, left: 40, bottom: 0, right: 20)
        return vStack
    }()
    
    private var leftView: UIStackView = {
        let vStack = UIStackView()
      // vStackMainBottom.backgroundColor = .darkGray
        vStack.axis = .vertical
        vStack.spacing = 12
        vStack.distribution = .fill
        vStack.alignment = .leading
        return vStack
    }()
    
    private var rightView: UIStackView = {
        let vStack = UIStackView()
       // vStackMainBottom.backgroundColor = .lightGray
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.alignment = .center
        return vStack
    }()
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.customFont(size: 40, weight: .bold)
        label.text = "TODAY"
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.text = "Title"
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.text = "Title"
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.customFont(size: 25, weight: .regular)
        label.text = "Current Location"
        return label
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
    
    private func setupUI() {
        contentView.clipsToBounds = true
        contentView.addSubview(viewFon)
        viewFon.addSubview(vStackMain)
        vStackMain.addArrangedSubview(vStackMainTop)
        vStackMain.addArrangedSubview(vStackMainBottom)
        
        vStackMainTop.addArrangedSubview(descriptionLabel)
        vStackMainTop.addArrangedSubview(line)
        
        vStackMainBottom.addArrangedSubview(leftView)
        vStackMainBottom.addArrangedSubview(rightView)
        
        leftView.addArrangedSubview(todayLabel)
        leftView.addArrangedSubview(minTempLabel)
        leftView.addArrangedSubview(maxTempLabel)
        
        rightView.addArrangedSubview(cityLabel)
        rightView.addArrangedSubview(imageChoice)
        
        viewFon.translatesAutoresizingMaskIntoConstraints = false
        vStackMain.translatesAutoresizingMaskIntoConstraints = false
        vStackMainTop.translatesAutoresizingMaskIntoConstraints = false
        vStackMainBottom.translatesAutoresizingMaskIntoConstraints = false
        imageChoice.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
       
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewFon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            viewFon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            viewFon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            viewFon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            viewFon.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            vStackMain.topAnchor.constraint(equalTo: viewFon.topAnchor, constant: 0),
            vStackMain.bottomAnchor.constraint(equalTo: viewFon.bottomAnchor, constant: 0),
            vStackMain.leadingAnchor.constraint(equalTo: viewFon.leadingAnchor, constant: 0),
            vStackMain.trailingAnchor.constraint(equalTo: viewFon.trailingAnchor, constant: 0),
            
            vStackMainTop.topAnchor.constraint(equalTo: vStackMain.topAnchor),
            vStackMainTop.bottomAnchor.constraint(equalTo: vStackMainBottom.topAnchor, constant: 0),
            vStackMainTop.leadingAnchor.constraint(equalTo: vStackMain.leadingAnchor),
            vStackMainTop.trailingAnchor.constraint(equalTo: vStackMain.trailingAnchor),
            
            vStackMainBottom.topAnchor.constraint(equalTo: vStackMainTop.bottomAnchor),
            vStackMainBottom.bottomAnchor.constraint(equalTo: vStackMain.bottomAnchor),
            vStackMainBottom.leadingAnchor.constraint(equalTo: vStackMain.leadingAnchor),
            vStackMainBottom.trailingAnchor.constraint(equalTo: vStackMain.trailingAnchor),
            
            imageChoice.heightAnchor.constraint(equalToConstant: 100),
            imageChoice.widthAnchor.constraint(equalToConstant: 100),
            cityLabel.heightAnchor.constraint(equalToConstant: 30),
            //cityLabel.widthAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30),

            line.leadingAnchor.constraint(equalTo: vStackMainTop.leadingAnchor, constant: 20),
            line.trailingAnchor.constraint(equalTo: vStackMainTop.trailingAnchor, constant: -20),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10)
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
