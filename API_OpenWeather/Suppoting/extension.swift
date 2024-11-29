//
//  extension.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 16/09/2024.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground(_ colorTop: UIColor, _ colorBottom: UIColor) {
        //let colorTop = UIColor(red: 33/255, green: 25/255, blue: 162/255, alpha: 1.0) // Темно-фиолетовый цвет (rgba(33,25,162,1))
        let colorMiddle = colorTop
        //let colorMiddle = UIColor(red: 17/255, green: 17/255, blue: 210/255, alpha: 1.0) // Синий цвет (rgba(17,17,210,1))
        //let colorBottom = UIColor(red: 0/255, green: 212/255, blue: 255/255, alpha: 1.0) // Светло-голубой (rgba(0,212,255,1))
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorMiddle.cgColor, colorBottom.cgColor] // Цвета градиента
        gradientLayer.locations = [0.25, 0.5, 0.98] // Позиции для каждого цвета
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)  // Начальная точка (сверху)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)    // Конечная точка (внизу)
        
        gradientLayer.frame = self.bounds  // Обязательно указываем размер слоя
        print(gradientLayer.frame)
        layer.insertSublayer(gradientLayer, at: 0) // Вставляем слой под все остальные
        //layer.insertSublayer(gradientLayer, below: self.layer)
    }
    
}

extension Float {
    func convertFarhToCelsium() -> Float {
        var celsium = (self - 32.0) / 1.8
        return celsium
    }
    
    func convertToString() -> String {
        return String(format: "%.0f", self)
    }

    func rounded(toPlaces places: Int) -> Float {
            let divisor = pow(10.0, Float(places))
            return (self * divisor).rounded() / divisor
        }
}

extension UIView {
    func setupBlurEffect() {
        // Создаем эффект размытия
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark) // Выберите стиль по вашему усмотрению
        // let blurEffect = UIBlurEffect(style: .extraLight)
       // let blurEffect = UIBlurEffect(style: .regular)
      
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Устанавливаем размеры для эффекта размытия
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //blurEffectView.backgroundColor = UIColor.black.withAlphaComponent(0.01)
        blurEffectView.tag = 101
        blurEffectView.alpha = 0.35
        
        //let overlayView = UIView(frame: bounds)
        //overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.1) // Затемнение

        
        // Добавляем эффект размытия на основной вид
        addSubview(blurEffectView)
        //addSubview(overlayView)
    }
    
    func roundCorner() {
        // Устанавливаем закругленные углы
        layer.cornerRadius = 12 
        layer.masksToBounds = true
    }
}

import Foundation

extension String {
    func extractHour() -> String? {
        // Создаем экземпляр DateFormatter
        let dateFormatter = DateFormatter()
        
        // Устанавливаем формат входной строки
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // Устанавливаем временную зону на UTC
      //  dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        // Преобразуем строку в Date
        if let date = dateFormatter.date(from: self) { // Используем self для текущей строки
            // Меняем формат на "HH" для извлечения часа
            dateFormatter.dateFormat = "HH"
            // Устанавливаем временную зону на текущую временную зону устройства
         //   dateFormatter.timeZone = TimeZone.current
            
            // Преобразуем Date обратно в строку с часом
            let hourString = dateFormatter.string(from: date)
            return hourString // Возвращаем строку с часом
        }
        return nil // Возвращаем nil, если преобразование не удалось
    }
}



