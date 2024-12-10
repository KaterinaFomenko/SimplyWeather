//
//  CellTop.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 13/09/2024.
//

import Foundation
import UIKit

// Title, image

class CellTop: UITableViewCell {
    
    // MARK: - Variables
   static let identifier = "CellTop"
    
    // MARK: - UI Components
    // stack labels + image
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [imageViewCell])
        vStack.backgroundColor = .clear
        vStack.axis = .vertical
        vStack.distribution = .fill
        //vStack.alignment = .center
        return vStack
    }()
    
    // stack labels
    private lazy var titlesStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [labelLeft, labelRight])
  //    vStackMainBottom.backgroundColor = .clear
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.distribution = .equalSpacing
        vStack.alignment = .leading
        return vStack
    }()
    
    private let imageViewCell: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "sun.rain")
        iv.tintColor = .label
        return iv
    }()
   
    private let labelLeft: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.customFont(size: 60, weight: .black)
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
        imageViewCell.image = UIImage(named: "kartin-papik3")
        labelLeft.text = "Weather"
        labelRight.text = "Forecast"
    }
    
    private func setupUI() {
        contentView.clipsToBounds = true
        contentView.addSubview(vStack)

        selectionStyle = .none

        vStack.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        titlesStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Ограничения для vStack
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            // Ограничения для imageViewCell
            imageViewCell.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageViewCell.heightAnchor.constraint(equalTo: imageViewCell.widthAnchor, multiplier: 0.25),

            // Ограничения для titlesStack
            titlesStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
