//
//  MovieDetailsVC.swift
//  SA
//
//  Created by максим  кондратьев  on 25.08.2021.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    enum Section { case main }

    var movie : String!
    var id : Int!
    var collectionView : UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Cast>!
    var actorsArray: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        fetchActors(for: id)
        configureDataSource()
        
        
       
    }
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    @objc func dismissVC(){
          dismiss(animated: true, completion: nil)
      }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCollumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ActorCell.self, forCellWithReuseIdentifier: ActorCell.reuseId)
    }
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Cast>(collectionView: collectionView, cellProvider: { (colView, indexPath, ouractor) -> UICollectionViewCell? in
            let cell = colView.dequeueReusableCell(withReuseIdentifier:  ActorCell.reuseId, for: indexPath) as! ActorCell
            cell.set(actor: ouractor)
            return cell
        })
    }
    func updateData(on newActors: [Cast]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Cast>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newActors)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
        }
        
    }
    func fetchActors(for id: Int) {
        NetworkManager.shared.getMoviesDetails(for: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.actorsArray.append(contentsOf: data)
                self.updateData(on: self.actorsArray)
            case .failure( _):
                self.presentAlertonMainThread(title: "smth", message: "smth", buttonTitle: "smth")
            }
            
        }
    }
}

extension MovieDetailsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        let actor = actorsArray[indexPath.item]
        let actorVC = ActorInformationVC()
        actorVC.id = actor.id

        let navC = UINavigationController(rootViewController: actorVC)
        present(navC, animated: true, completion: nil)
        
        
    }
}
