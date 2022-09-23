//
//  DetailProductViewController.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 16/09/2022.
//

import UIKit


class DetailProductViewController: UIViewController {

    //MARK: - Variables
    var idProductCurrent: String?
    var idFavorites: [String] = []
    
    //instanciar UserDefault
    let defaults = UserDefaults.standard
    
    // MARK: - CREATION OF VIEWS
    
    private lazy var scrollView: UIScrollView = {
       let aScrollView = UIScrollView()
        aScrollView.translatesAutoresizingMaskIntoConstraints = false
        aScrollView.backgroundColor = .white
        return aScrollView
    }()
    
    private lazy var contentView: UIView = {
        let aContentView = UIView()
        aContentView.translatesAutoresizingMaskIntoConstraints = false
        aContentView.backgroundColor = .white
        return aContentView
    }()
    
    lazy var deliverToContent: UIButton = {
        let aButton = UIButton()
        aButton.translatesAutoresizingMaskIntoConstraints = false
        aButton.setTitle("  Enviar a Nombre de Usuario - Dirección >                    ", for: .normal)
        aButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        aButton.setTitleColor(Kcolors.meliTextSecondary, for: .normal)
        aButton.contentHorizontalAlignment = .center
        aButton.backgroundColor = Kcolors.meliYellow
        aButton.translatesAutoresizingMaskIntoConstraints = false
        aButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let icon = Kicons.location
        aButton.setImage(icon, for: .normal)
        
        return aButton
    }()
    
     lazy var titleLabelDetail: UILabel = {
        let aTitleDetail = UILabel()
        aTitleDetail.translatesAutoresizingMaskIntoConstraints = false
        aTitleDetail.text = ""
        aTitleDetail.font = .systemFont(ofSize: 14)
        aTitleDetail.numberOfLines = 0
        aTitleDetail.textColor = .gray
        return aTitleDetail
    }()
    
     lazy var titleLabelDetailP: UILabel = {
        let aTitleDetail = UILabel()
        aTitleDetail.translatesAutoresizingMaskIntoConstraints = false
        aTitleDetail.text =  ""
        aTitleDetail.font = .systemFont(ofSize: 18)
         aTitleDetail.numberOfLines = 0
        aTitleDetail.textColor = .black
        return aTitleDetail
    }()
    
     lazy var sellerLabelDetail: UILabel = {
        let aTitleDetail = UILabel()
        aTitleDetail.translatesAutoresizingMaskIntoConstraints = false
         
         let text = NSMutableAttributedString()
         text.append(NSAttributedString(string: "Vendedor con", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]));
         text.append(NSAttributedString(string: " identidad verificada", attributes: [NSAttributedString.Key.foregroundColor: Kcolors.meliBlue!]))
         aTitleDetail.attributedText = text
        aTitleDetail.font = .systemFont(ofSize: 14)
        return aTitleDetail
    }()
    
     var imageProductDetail: UIImageView = {
        let aImageProduct = UIImageView()
        aImageProduct.translatesAutoresizingMaskIntoConstraints = false
        aImageProduct.contentMode = .scaleAspectFit
  
        return aImageProduct
    }()
    
     lazy var priceLabelProduct: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.text = ""
         priceLabel.font = .systemFont(ofSize: 28, weight: .regular)
        
        return priceLabel
    }()
    
    private lazy var preguntarButton: UIButton = {
        let aButton = UIButton()
        aButton.setTitle("  Whatsapp", for: .normal)
        aButton.backgroundColor = Kcolors.meliBlue
        aButton.translatesAutoresizingMaskIntoConstraints = false
        aButton.layer.cornerRadius = 12
        let icon = Kicons.clip
        icon?.withTintColor(Kcolors.meliBlue!)
        aButton.setImage(icon, for: .normal)
        
        return aButton
    }()
    
    private lazy var whatsappButton: UIButton = {
        let aButton = UIButton()
        aButton.translatesAutoresizingMaskIntoConstraints = false
        aButton.setTitle("Preguntar", for: .normal)
        aButton.backgroundColor = Kcolors.meliBlue
        aButton.layer.cornerRadius = 12
        
        return aButton
    }()
    

    private lazy var favoriteButton: UIButton = {
        let aButton = UIButton()
        var config = UIButton.Configuration.filled()
        aButton.setTitle("  Compartir", for: .normal)
        aButton.translatesAutoresizingMaskIntoConstraints = false
        aButton.setTitleColor(Kcolors.meliBlue, for: .normal)
        let icon = Kicons.share
        icon?.withTintColor(Kcolors.meliBlue!)
        aButton.setImage(icon, for: .normal)
        
        return aButton
    }()
    
    private lazy var compartirButtom: UIButton = {
        let aButton = UIButton()
        aButton.setTitle(" Agregar Favoritos", for: .normal)
        
        aButton.translatesAutoresizingMaskIntoConstraints = false
        aButton.setTitleColor(Kcolors.meliBlue, for: .normal)
        let icon = Kicons.heart
        icon?.withTintColor(Kcolors.meliBlue!)
        aButton.setImage(icon, for: .normal)
        aButton.addTarget(self, action: #selector(addIdFavorite), for: .touchUpInside)
        
        
        return aButton
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let aDescription = UILabel()
        aDescription.translatesAutoresizingMaskIntoConstraints = false
        aDescription.text = "Descripción"
        aDescription.font = .systemFont(ofSize: 19)
        
        return aDescription
    }()
    
     lazy var textDescriptionLabel: UILabel = {
       let aTextLabel = UILabel()
        aTextLabel.translatesAutoresizingMaskIntoConstraints = false
        aTextLabel.numberOfLines = 0
        aTextLabel.textColor = Kcolors.meliTextSecondary
        aTextLabel.text = ""
         aTextLabel.font = .systemFont(ofSize: 15)
        return aTextLabel
    }()
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
        setupNavigation()
    }
    
    // MARK: Setups
    
    private func setupNavigation(){
        navigationController?.navigationBar.barTintColor = Kcolors.meliYellow
        view.backgroundColor = Kcolors.meliYellow
        
        let leftButton = UIBarButtonItem(image: Kicons.arrow, style: .plain, target: self, action: #selector(backButtonAction))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let firstButton = UIBarButtonItem(image: Kicons.cart, style: .plain, target: self, action: nil)
        let mediumButtom = UIBarButtonItem(image: Kicons.mglass, style: .plain, target: self, action: nil)
        let rightButtom = UIBarButtonItem(image: Kicons.heart, style: .plain, target: self, action: #selector(addIdFavorite))
        navigationItem.rightBarButtonItems = [firstButton, mediumButtom, rightButtom]
        navigationItem.rightBarButtonItems?[0].tintColor = .black
        navigationItem.rightBarButtonItems?[1].tintColor = .black
        navigationItem.rightBarButtonItems?[2].tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Kcolors.meliYellow
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func setupView(){
        view.addSubview(scrollView)
        view.addSubview(deliverToContent)
        scrollView.addSubview(contentView)
        
        [titleLabelDetail,titleLabelDetailP,sellerLabelDetail,imageProductDetail,priceLabelProduct,descriptionLabel,textDescriptionLabel, whatsappButton, preguntarButton, compartirButtom, favoriteButton].forEach{
            contentView.addSubview($0)
        }
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            deliverToContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            deliverToContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            deliverToContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: deliverToContent.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabelDetail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabelDetail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabelDetail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            titleLabelDetailP.topAnchor.constraint(equalTo: titleLabelDetail.bottomAnchor, constant: 8),
            titleLabelDetailP.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabelDetailP.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            sellerLabelDetail.topAnchor.constraint(equalTo: titleLabelDetailP.bottomAnchor, constant: 8),
            sellerLabelDetail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            sellerLabelDetail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            imageProductDetail.topAnchor.constraint(equalTo: sellerLabelDetail.bottomAnchor, constant: 15),
            imageProductDetail.heightAnchor.constraint(equalToConstant: 250),
            imageProductDetail.widthAnchor.constraint(equalToConstant: 250),
            imageProductDetail.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            priceLabelProduct.topAnchor.constraint(equalTo: imageProductDetail.bottomAnchor, constant:  10),
            priceLabelProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            priceLabelProduct.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            whatsappButton.topAnchor.constraint(equalTo: priceLabelProduct.bottomAnchor, constant: 10),
            whatsappButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            whatsappButton.heightAnchor.constraint(equalToConstant: 40),
            whatsappButton.widthAnchor.constraint(equalToConstant: 170),
            
            preguntarButton.topAnchor.constraint(equalTo: priceLabelProduct.bottomAnchor, constant: 10),
            preguntarButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            preguntarButton.heightAnchor.constraint(equalToConstant: 40),
            preguntarButton.widthAnchor.constraint(equalToConstant: 170),
            
            compartirButtom.topAnchor.constraint(equalTo: whatsappButton.bottomAnchor, constant: 15),
            compartirButtom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            compartirButtom.heightAnchor.constraint(equalToConstant: 40),
            compartirButtom.widthAnchor.constraint(equalToConstant: 170),
            
            favoriteButton.topAnchor.constraint(equalTo: preguntarButton.bottomAnchor, constant: 15),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40),
            favoriteButton.widthAnchor.constraint(equalToConstant: 170),
            
            descriptionLabel.topAnchor.constraint(equalTo: compartirButtom.bottomAnchor, constant: 40),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            textDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            textDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            textDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            textDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
        
    }
    
    // MARK: FUNCTIONS BUTTONS
    
    @objc func addIdFavorite(){
        if let ids = defaults.array(forKey: kUserD.uKey) as? [String] {
            
            idFavorites = ids
            navigationItem.rightBarButtonItems?[2].tintColor = Kcolors.meliYellow
        }
        idFavorites.append(idProductCurrent!)
        defaults.set(idFavorites, forKey: kUserD.uKey)
        
        
        
    }
    
    @objc func backButtonAction(){
        navigationController?.popViewController(animated:true)
    }
    

}


