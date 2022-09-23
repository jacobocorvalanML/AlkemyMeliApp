//
//  Extensions.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 21/09/2022.
//

import UIKit

// To Decoder image
extension UIImageView{
    func loadFrom(URLAddres: String){
        guard let url = URL(string: URLAddres) else {return}
        
        DispatchQueue.main.async { [weak self] in
            if let imagenData = try? Data(contentsOf: url){
                if let loadedImege = UIImage(data: imagenData){
                    self?.image = loadedImege
                }
            }
        }
    }
}

// To format number

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "." }
}
