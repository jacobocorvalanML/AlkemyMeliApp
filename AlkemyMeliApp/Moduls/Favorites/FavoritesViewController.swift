//
//  FavoritesViewController.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 19/09/2022.
//

import UIKit
import Foundation

class FavoritesViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - Variables
    let defaults = UserDefaults.standard
    
    var productManager = ProductManager()
    var products: [String] = []
    var listOfFavorites: [MultigetElement] = []
    
    // MARK: - View
    private lazy var tableViewFavorites: UITableView = {
        
        let aTableView = UITableView()
        aTableView.translatesAutoresizingMaskIntoConstraints = false
        aTableView.backgroundColor = .white
        aTableView.register(TableViewCellMeli.self, forCellReuseIdentifier: KCellMelliId.id)
        view.addSubview(aTableView)
        aTableView.delegate = self
        aTableView.dataSource = self
        
        return aTableView
        
    }()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationStyle()
        setupConstraints()
    }

    // MARK: - ViewDidAppear
    
    // I show the ids saved in UserDefault and call the API
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        activeIndicator()
        
    }
    
    // MARK: - Update View Favorite
    
    func activeIndicator(){
        let container = UIView()
        container.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        let activeIndicator = UIActivityIndicatorView(style: .large)
        activeIndicator.center = self.view.center
        container.addSubview(activeIndicator)
        self.view.addSubview(container)
        
        if let ids = defaults.array(forKey: kUserD.uKey) as? [String] {
            
            if products != ids {
                activeIndicator.startAnimating()
                products = ids
                let idString = products.joined(separator: ",")
                
                productManager.fetchDetailsProducts(Categories: idString) { ids in
                
                self.listOfFavorites = ids
                    activeIndicator.stopAnimating()
                self.tableViewFavorites.reloadData()
                
                }
            }
        }
   }

    
    //MARK: SETUPS
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableViewFavorites.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewFavorites.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewFavorites.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewFavorites.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func navigationStyle(){
        
        view.backgroundColor = Kcolors.meliYellow
        navigationController?.navigationBar.standardAppearance.backgroundColor = Kcolors.meliYellow
        
        let fav = UIBarButtonItem(title: "Favoritos", style: .plain, target: .none, action: .none)
        navigationItem.leftBarButtonItem = fav
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let firstButton = UIBarButtonItem(image: Kicons.cart, style: .plain, target: self, action: nil)
        let mediumButtom = UIBarButtonItem(image: Kicons.mglass, style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [firstButton, mediumButtom]
        navigationItem.rightBarButtonItems?[0].tintColor = .black
        navigationItem.rightBarButtonItems?[1].tintColor = .black
        
    }
}

// MARK: - Extensions

extension FavoritesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listOfFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KCellMelliId.id, for: indexPath) as! TableViewCellMeli
        
        cell.titleLabel.text = self.listOfFavorites[indexPath.row].body.title
        cell.productImageView.loadFrom(URLAddres: self.listOfFavorites[indexPath.row].body.pictures.first?.secureURL ?? "" )
        cell.priceLabel.text = "$ \(String(Int(self.listOfFavorites[indexPath.row].body.price).formattedWithSeparator))"
        cell.extraDataLabel.text = self.listOfFavorites[indexPath.row].body.seller_address.city.name
        cell.adressLabel.text = self.listOfFavorites[indexPath.row].body.seller_address.state.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cv = DetailProductViewController()
        
        cv.titleLabelDetail.text = listOfFavorites[indexPath.row].body.title
        cv.imageProductDetail.loadFrom(URLAddres: listOfFavorites[indexPath.row].body.pictures.first?.secureURL ?? "")
//        cv.sellerLabelDetail.text = listOfFavorites[indexPath.row].body.seller_address.state.name
        cv.priceLabelProduct.text = "$ \(String(Int(self.listOfFavorites[indexPath.row].body.price).formattedWithSeparator))"
        cv.titleLabelDetailP.text = listOfFavorites[indexPath.row].body.title
        cv.idProductCurrent = listOfFavorites[indexPath.row].body.id
        
         let id = listOfFavorites[indexPath.row].body.id 
        
        productManager.fetchProductDetails(id: id) { description in
            cv.textDescriptionLabel.text = description.plainText
        }

        self.navigationController?.pushViewController(cv, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

          if editingStyle == .delete {
            
            let productDeleted = listOfFavorites[indexPath.row].body.id
            products = products.filter{$0 != productDeleted}
            self.listOfFavorites.remove(at: indexPath.row)
              
            self.tableViewFavorites.deleteRows(at: [indexPath], with: .automatic)
              
              defaults.set(products, forKey: kUserD.uKey)
          }
        }
}





