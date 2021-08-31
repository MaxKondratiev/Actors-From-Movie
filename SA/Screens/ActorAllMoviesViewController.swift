//
//  ActorAllMoviesViewController.swift
//  SA
//
//  Created by максим  кондратьев  on 26.08.2021.
//

import UIKit

class ActorAllMoviesViewController: UIViewController {

    enum Section { case main }
    
    var id: Int!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Credits>?
    var moviesArray : [Credits] = []
    
    //var delegate:  ActorInformationVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureCollectionView()
        configureDataSource()
        fetchAllMovies(for: id!)
        print("OUR LAST ID:\(id!)")
    }
    
    

    func configureCollectionView() {
        //we have to initialize colView first and use
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCollumnFlowLayout2(in: view))
        view.addSubview(collectionView)
        //collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(AllMoviesCell.self, forCellWithReuseIdentifier: AllMoviesCell.reuseID)
    }
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Credits>(collectionView: collectionView, cellProvider: { (colView, indexPath, ouractor) -> UICollectionViewCell? in
            let cell = colView.dequeueReusableCell(withReuseIdentifier:  AllMoviesCell.reuseID, for: indexPath) as! AllMoviesCell
            cell.sett(actor: ouractor)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Credits>()
        snapshot.appendSections([.main])
        snapshot.appendItems(moviesArray)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
    
    func fetchAllMovies(for id: Int) {
        NetworkManager.shared.getAllMoviesOfActor(for: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.moviesArray.append(contentsOf: data)
                self.updateData()
            case .failure( let error):
                print(error.localizedDescription)
                
            }
            
        }
    }

}
