//
//  FavoritesVC.swift
//  SA
//
//  Created by максим  кондратьев  on 23.08.2021.
//

import UIKit

class FavoritesVC: UIViewController {

    let tableView = UITableView()
    var favorites: [ActorDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureTableView()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame =  view.bounds
        tableView.rowHeight = 100
         tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseId)
    }
    
    func fetchFavorites(){
        PersistanceManager.retrieveFavorites { [weak self] (result) in
            
            switch result {
            
            case .success(let fav):
                if fav.isEmpty {
                    self?.presentAlertonMainThread(title: "EMPTY STATE", message: "EMPTY STATE", buttonTitle: "ok")
                } else {
                    self?.favorites = fav
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }

                }
            
            case .failure(let error):
                    self?.presentAlertonMainThread(title: "something get wrong", message: error.rawValue , buttonTitle: "ok")
            }
        }
    }
}
extension FavoritesVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseId) as! FavoritesCell
        let  favoriteFollower = favorites[indexPath.row]
        cell.set(fav: favoriteFollower)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  favoriteFollower = favorites[indexPath.row]
        let destVC = ActorAllMoviesViewController()
        destVC.id = favoriteFollower.id
        //destVC.title = favoriteFollower.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        PersistanceManager.updateWith(favorite: favorite, actionType: .remove) { error  in
            guard let error = error else {return}
            self.presentAlertonMainThread(title: "Smth get wrong", message: error.rawValue, buttonTitle: "OK")
        }
    }
    
    
}
