//
//  UIColor.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 10/10/2024.
//

import Foundation
import UIKit

extension UIColor {
    //color = UIColor(hex: "#3498db")
    // Инициализатор для создания UIColor из шестнадцатеричного значения
    convenience init(hex: String) {
        // Удаляем символы '#' и пробелы
        let r, g, b: CGFloat
        
        var hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if hexColor.hasPrefix("#") {
            hexColor.remove(at: hexColor.startIndex)
        }
        
        // Проверка длины строки
        var rgb: UInt64 = 0
        Scanner(string: hexColor).scanHexInt64(&rgb)
        
        switch hexColor.count {
        case 3: // Формат #RGB
            r = CGFloat((rgb >> 8) & 0xFF) / 255.0
            g = CGFloat((rgb >> 4) & 0xFF) / 255.0
            b = CGFloat(rgb & 0xFF) / 255.0
        case 6: // Формат #RRGGBB
            r = CGFloat((rgb >> 16) & 0xFF) / 255.0
            g = CGFloat((rgb >> 8) & 0xFF) / 255.0
            b = CGFloat(rgb & 0xFF) / 255.0
        default:
            r = 0
            g = 0
            b = 0
        }
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    static var owBlue: UIColor {
       return UIColor(hex: "#5699E1")
    }
    
    static var owBackgroundBlue1: UIColor {
       return UIColor(hex: "#518EDE")
    }
    
    static var grayRain: UIColor {
        return UIColor(hex: "#5C7586")
    }
   
    
}


