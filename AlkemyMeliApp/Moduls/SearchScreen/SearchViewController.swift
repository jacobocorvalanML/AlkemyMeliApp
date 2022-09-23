//
//  ViewController.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 14/09/2022.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UITableViewDataSource {
    
    var productManagaer = ProductManager()
    var listOfProducts: [MultigetElement] = []

    private lazy var searchBar: UISearchBar = {
       
        let aSearchBar = UISearchBar()
        aSearchBar.translatesAutoresizingMaskIntoConstraints = false
        aSearchBar.backgroundColor = Kcolors.meliYellow
        aSearchBar.barTintColor = Kcolors.meliYellow
        aSearchBar.searchTextField.backgroundColor = .white
        aSearchBar.delegate = self
        aSearchBar.placeholder = "Buscar en Mercado Libre"
        aSearchBar.searchTextField.layer.shadowRadius = 1
        aSearchBar.searchTextField.layer.shadowColor = UIColor.black.cgColor
        aSearchBar.searchTextField.layer.shadowOpacity = 0.2
        aSearchBar.searchTextField.layer.shadowOffset = CGSize(width:0, height:1)
        aSearchBar.searchTextField.layer.masksToBounds = false
        
        view.addSubview(aSearchBar)
        
        return aSearchBar
    }()
    
    private lazy var tableViewProducts: UITableView = {
        
        let aTableView = UITableView()
        aTableView.translatesAutoresizingMaskIntoConstraints = false
        aTableView.backgroundColor = .white
        aTableView.register(TableViewCellMeli.self, forCellReuseIdentifier: "TableViewCellMeli")
        view.addSubview(aTableView)
        aTableView.delegate = self
        aTableView.dataSource = self
        
        return aTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        setupConstraints()
    }
    
    private func setupNavigation(){
        view.backgroundColor = Kcolors.meliYellow
        navigationController?.navigationBar.backgroundColor = Kcolors.meliYellow
        let rightButton = UIBarButtonItem(image: Kicons.cart, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        let leftButton = UIBarButtonItem(image: Kicons.arrow, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
   private func setupView(){
        self.navigationItem.titleView = searchBar
        navigationController?.navigationBar.standardAppearance.backgroundColor = Kcolors.meliYellow
    }
    
   private func setupConstraints(){
        NSLayoutConstraint.activate([
            tableViewProducts.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewProducts.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewProducts.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewProducts.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}

extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        productManagaer.fetchCategory(category: searchText) { category in
            guard let categoryId = category.first?.categoryID else {return}
            self.productManagaer.fetchTopTwenty(categoryProduct: categoryId) { categories in
                self.productManagaer.fetchDetailsProducts(Categories: categories) { products in
                    
                    self.listOfProducts = products
                    self.tableViewProducts.reloadData()
                }
            }
        } failure: { error in
            print(error ?? "")
        }
    }
}

extension SearchViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellMeli", for: indexPath) as! TableViewCellMeli
        cell.titleLabel.text = listOfProducts[indexPath.row].body.title
        cell.productImageView.loadFrom(URLAddres: listOfProducts[indexPath.row].body.pictures.first?.secureURL ?? "" )
        cell.priceLabel.text = "$ \(String(Int(self.listOfProducts[indexPath.row].body.price).formattedWithSeparator))"
        cell.extraDataLabel.text = listOfProducts[indexPath.row].body.seller_address.city.name
        cell.adressLabel.text = listOfProducts[indexPath.row].body.seller_address.state.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cv = DetailProductViewController()
        
        cv.titleLabelDetail.text = listOfProducts[indexPath.row].body.title
        cv.imageProductDetail.loadFrom(URLAddres: listOfProducts[indexPath.row].body.pictures.first?.secureURL ?? "")

        cv.priceLabelProduct.text = "$ \(String(Int(self.listOfProducts[indexPath.row].body.price).formattedWithSeparator))"
        cv.titleLabelDetailP.text = listOfProducts[indexPath.row].body.title
        cv.idProductCurrent = listOfProducts[indexPath.row].body.id
        
        let id = listOfProducts[indexPath.row].body.id
        
        productManagaer.fetchProductDetails(id: id) { description in
            cv.textDescriptionLabel.text = description.plainText
        }

        self.navigationController?.pushViewController(cv, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        154
    }
}


