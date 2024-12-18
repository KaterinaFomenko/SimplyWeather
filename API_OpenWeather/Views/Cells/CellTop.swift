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
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [imageViewCell])
        //vStack.backgroundColor = .green
        vStack.axis = .vertical
        vStack.distribution = .fill
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
    public func configureTopCell() {
        imageViewCell.image = UIImage(named: "kartin-papik3")
    }
    
    private func setupUI() {
        contentView.clipsToBounds = true
        contentView.addSubview(vStack)

        selectionStyle = .none

        vStack.translatesAutoresizingMaskIntoConstraints = false
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Ограничения для vStack
            vStack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            // Ограничения для imageViewCell
            imageViewCell.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            imageViewCell.heightAnchor.constraint(equalTo: imageViewCell.widthAnchor, multiplier: 2),
            imageViewCell.bottomAnchor.constraint(equalTo: vStack.bottomAnchor, constant: 0)

        ])
    }

}
