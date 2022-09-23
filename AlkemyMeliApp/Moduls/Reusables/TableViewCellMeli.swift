//
//  TableViewCellMeli.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 15/09/2022.
//

import UIKit
import SwiftUI

class TableViewCellMeli: UITableViewCell {

     var productImageView: UIImageView = {

        let aImageView = UIImageView()
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        aImageView.contentMode = .scaleAspectFit
         aImageView.backgroundColor = Kcolors.meliGray
    
        return aImageView
    }()
    
    var bottonAddFav: UIButton = {
        let aButton = UIButton()
        
        aButton.backgroundColor = Kcolors.meliWhite
        aButton.translatesAutoresizingMaskIntoConstraints = false
        aButton.layer.cornerRadius = 15
        let icon = Kicons.heartPdf
        icon?.withTintColor(Kcolors.meliBlue!)
        aButton.setImage(icon, for: .normal)
        
        return aButton
    }()

      var detailsStackView: UIStackView = {
        let aStackView = UIStackView()
        aStackView.translatesAutoresizingMaskIntoConstraints = false
        aStackView.axis = .vertical
        aStackView.spacing = 0
        aStackView.distribution = .fillProportionally

        return aStackView
    }()

     var titleLabel: UILabel = {

        let aLabel = UILabel()
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.font = .systemFont(ofSize: 12)
        aLabel.numberOfLines = 0
        aLabel.textColor = .black
        return aLabel

    }()

     var priceLabel: UILabel = {

        let aPrice = UILabel()
        aPrice.translatesAutoresizingMaskIntoConstraints = false
        aPrice.font = .systemFont(ofSize: 24)
        aPrice.textColor = .black
        return aPrice
    }()

     var extraDataLabel: UILabel = {

        let aExtra = UILabel()
        aExtra.translatesAutoresizingMaskIntoConstraints = false
        aExtra.font = .systemFont(ofSize: 12)
        aExtra.numberOfLines = 0
        aExtra.textColor = .gray
        return aExtra
    }()

     var adressLabel: UILabel = {

        let aAdress = UILabel()
        aAdress.translatesAutoresizingMaskIntoConstraints = false
        aAdress.font = .systemFont(ofSize: 12)
        aAdress.textColor = .gray
        return aAdress
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(productImageView)
        productImageView.addSubview(bottonAddFav)
        addSubview(detailsStackView)

        [titleLabel,priceLabel,extraDataLabel,adressLabel].forEach{
            detailsStackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([

            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            productImageView.heightAnchor.constraint(equalToConstant: 140),
            productImageView.widthAnchor.constraint(equalToConstant: 140),
            
            bottonAddFav.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 5),
            bottonAddFav.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -5),
            bottonAddFav.heightAnchor.constraint(equalToConstant: 30),
            bottonAddFav.widthAnchor.constraint(equalToConstant: 30),
            

            detailsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            detailsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            detailsStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            detailsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






