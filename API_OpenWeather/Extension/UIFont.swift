//
//  UIFont.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 02/11/2024.
//

import Foundation
import UIKit

extension UIFont {
    // label.font = UIFont.customFont(size: 50, weight: .bold)
    
    static func customFont(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let fontName = "Antipasto Pro"
        let baseFont = UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
        var fontDescriptor = baseFont.fontDescriptor
        
        if weight == .bold {
            fontDescriptor = fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor
        }
        return UIFont(descriptor: fontDescriptor, size: size)
    }
}
