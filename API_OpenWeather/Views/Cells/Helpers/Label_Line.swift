//
//  Label_Line.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 30/11/2024.
//

import Foundation
import UIKit

class UIElementFactory {
    
    static func createStackView(
        arrangedSubview: [UIView],
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat,
        alignment: UIStackView.Alignment = .fill,
        distribution:  UIStackView.Distribution = .fill)
    -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubview)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    static func createLabel(
        text: String,
        color: UIColor,
        font: UIFont = .systemFont(ofSize: 20),
        alignment: NSTextAlignment = .center
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = font
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createLine(color: UIColor = .white, height: CGFloat = 1) -> UIView {
        let line = UIView()
        line.backgroundColor = color
        line.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            line.heightAnchor.constraint(equalToConstant: height)
        ])
        return line
    }
    
    static func createImageView(image: UIImage? = nil, tintColor: UIColor = .black, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = tintColor
        imageView.contentMode = contentMode
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
}



