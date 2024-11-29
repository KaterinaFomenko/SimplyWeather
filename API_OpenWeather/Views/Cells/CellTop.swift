//
//  CellTop.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 13/09/2024.
//

import Foundation
import UIKit

class CellTop: UITableViewCell {
    
    // MARK: - Variables
   static let identifier = "CellTop"
    
    // MARK: - UI Components
    // stack labels + image
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [gorStack, imageViewCell])
        vStack.backgroundColor = .clear
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing
        vStack.alignment = .center
        return vStack
    }()
    
    // stack labels
    private lazy var gorStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [labelLeft, labelRight])
  //    vStackMainBottom.backgroundColor = .clear
        vStack.axis = .horizontal
        vStack.spacing = 5
        vStack.distribution = .fillEqually
        vStack.alignment = .center
        return vStack
    }()
    
    private let imageViewCell: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "sun.rain")
        iv.tintColor = .label
        return iv
    }()
   
    private let labelLeft: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.customFont(size: 60, weight: .bold)
        label.text = "Left Title"
        return label
    }()
    
    private let labelRight: UILabel = {
        let label = UILabel()
        label.textColor = .systemYellow
        label.textAlignment = .center
        label.font = UIFont(name: "SF Compact Rounded", size: 50)
        label.text = "Right Title"
        return label
    }()
    
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       // contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    public func configureTopCell() {
        imageViewCell.image = UIImage(named: "forecast-simple")
        labelLeft.text = "Simply"
        labelRight.text = "Weather"
    }
    
    private func setupUI() {
        contentView.clipsToBounds = true
        contentView.addSubview(vStack)
        
        selectionStyle = .none
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        gorStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            gorStack.heightAnchor.constraint(equalToConstant: 70),
            
            imageViewCell.topAnchor.constraint(equalTo: gorStack.bottomAnchor),
            imageViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageViewCell.bottomAnchor.constraint(equalTo: vStack.bottomAnchor),
            imageViewCell.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            // Соотношение сторон (можно менять под нужные пропорции)
            imageViewCell.heightAnchor.constraint(equalTo: imageViewCell.widthAnchor, multiplier: 0.4)
        ])
        
        
    }
}
