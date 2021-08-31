//
//  ActorInformationVC.swift
//  SA
//
//  Created by максим  кондратьев  on 26.08.2021.
//

import UIKit

//protocol ActorInformationVCDelegate: class {
//    func didTap(for actor:ActorDetails)
//}

class ActorInformationVC: UIViewController {

    
    var id: Int!
    let headerView = UIView()
    
    var completion: ((Int)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureViewController()
        layoutUI()
        //fetchActorInfo(for: id!)
        fetchData(for: id)
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem?.title = "credits"
        navigationItem.rightBarButtonItem = doneButton
        navigationController?.navigationBar.prefersLargeTitles = true
       
        
        
    }
    @objc func dismissVC(){
          let vc = ActorAllMoviesViewController()
        vc.id = self.id
        present(vc, animated: true, completion: nil)
      }
    
    func layoutUI() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
        headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        headerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //containerView is our headerView
       
    func addVC(childVC: UIViewController,to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    func fetchData(for id: Int) {
        NetworkManager.shared.getActorInfo(for: id) { (result) in
            switch result {
            
            case .success(let actor):
                DispatchQueue.main.async {
                    //DELEGATE to childActorInfoVC
                    let  delVC = childActorInfoVC(actor: actor)
                    //delVC.delegate = self
                    self.addVC(childVC: delVC, to: self.headerView )
                    //
                    //self.completion?(actor.id)
                    self.title = actor.name
                    
                    print("\(actor.id ) ++ \(actor.name)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

//extension ActorInformationVC : ActorInformationVCDelegate {
//
//    func didTap(for actor: ActorDetails) {
//
//        let vc = ActorAllMoviesViewController()
//        present(vc, animated: true, completion: nil)
//        vc.id = actor.id
//        print("TUT \(actor.id)")
//    }
    
    
    
    
    



