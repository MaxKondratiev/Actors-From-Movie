//
//  MoviesVC.swift
//  SA
//
//  Created by максим  кондратьев  on 23.08.2021.
//

import UIKit

class MoviesVC: UIViewController {
    
    enum Section {
        case main
    }// enum for DiffableDataSource

    var movieName: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Moviesss>?
    var moviesArray : [Moviesss] = []
    var fillteredArray : [Moviesss] = []
    var page = 1
    var hasMoreItems = true
    var isSearching = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getMovies(movie: movieName, page: page)
        configureDataSource()
       
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: Confire ViewController
    func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = addButton
    }
    @objc func dismissVC() {
       
    }
    
    // MARK:  Confire Collection View and FLOW Layout
    func configureCollectionView() {
        //we have to initialize colView first and use
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCollumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self 
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Moviesss>(collectionView: collectionView, cellProvider: { (colView, indexPath, ourmovie ) -> UICollectionViewCell? in
            let cell = colView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: ourmovie)
            return cell
        })
    }
    func updateData(on movies: [Moviesss]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Moviesss>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
        }
        
    }
    // MARK:  SEARCH CONTROLLER
    
    func configureSearchController() {
        
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        // Delegate
        searchController.searchBar.placeholder = "Search for a name"
        navigationItem.searchController = searchController
       
        
    }
    
    // MARK:  NETWORK
    
    func getMovies(movie: String, page:Int) {
        showLoadingView()
        NetworkManager.shared.getMovies(for: movie, page: page) { [weak self] result in
            self?.dismissLoadingView()
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                    self.presentAlertonMainThread(title: "Smth get wrong", message: error.rawValue,
                                                  buttonTitle:  "ok")
            case .success(let returnedData):
                //Data from Network goes to moviesArray[]
                //if returnedData.count < 30 {self.hasMoreItems = false }
                self.moviesArray.append(contentsOf: returnedData)
                self.updateData(on: self.moviesArray)
             
            }
        }
    }
}
extension MoviesVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        print("offsetY:\(offsetY)")
        print("contentHeight: \(contentHeight)")
        print("height: \(height)")
        
//         PAGINATION
        if offsetY > contentHeight - height {

        //guard hasMoreItems else {return}
            print("Added more pages")
            page += 1
           getMovies(movie: movieName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? fillteredArray : moviesArray
        let movie = activeArray[indexPath.item]
        let destVC =  MovieDetailsVC()
        destVC.movie = movie.title
        destVC.id = movie.id
        let navC = UINavigationController(rootViewController: destVC)
        present(navC, animated: true, completion: nil)
    }
}

extension MoviesVC: UISearchResultsUpdating , UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filtertext = searchController.searchBar.text , !filtertext.isEmpty else {  return }
        
        isSearching = true
        print(filtertext)
        fillteredArray = moviesArray.filter{
            $0.title!.lowercased().contains(filtertext.lowercased())
        }
        updateData(on: fillteredArray)
        print(fillteredArray)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: moviesArray)
    }
}
