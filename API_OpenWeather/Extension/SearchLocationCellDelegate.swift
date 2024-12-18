//
//  SearchLocationCellDelegate.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 18/12/2024.
//

import Foundation

extension ViewController: SearchLocationCellDelegate {
    func didBeginEditingInCell(_ cell: SearchLocationCell) {
        let searchVC = SearchViewController()
        //searchVC.modalPresentationStyle = .pageSheet
        print("Delegat is working. Good gob!")
        present(searchVC, animated: true, completion: nil)
    }
}
