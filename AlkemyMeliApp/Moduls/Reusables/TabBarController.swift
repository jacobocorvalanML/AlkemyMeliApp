//
//  TabBarController.swift
//  AlkemyMeliApp
//
//  Created by Jacobo Ezequiel Corvalan on 19/09/2022.
//

import UIKit

class TabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        
    }
    
    func setupTabBarController(){
        
        let vc1 = UINavigationController(rootViewController: SearchViewController())
        let vc2 = UINavigationController(rootViewController: FavoritesViewController())
        let vc3 = UINavigationController(rootViewController: MyShoppingViewController())
        let vc4 = UINavigationController(rootViewController: NotificationsViewController())
        let vc5 = UINavigationController(rootViewController: OthersViewController())
        
        self.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        
        guard let items = tabBar.items else {return}
        
        items[0].title = "Inicio"
        items[0].image = UIImage(systemName: "house")
        items[1].title = "Favoritos"
        items[1].image = UIImage(systemName: "star")
        items[2].title = "Mis Compras"
        items[2].image = UIImage(named: "icon.Shopp")
        items[3].title = "Notificaciones"
        items[3].image = UIImage(systemName: "bell")
        items[4].title = "Más"
        items[4].image = UIImage(named: "more")
        
        
        
        
    }
}
