//
//  ActorInformationVC.swift
//  SA
//
//  Created by максим  кондратьев  on 26.08.2021.
//

import UIKit

class ActorInformationVC: UIViewController {

    
    var id: Int!
    let headerView = UIView()
//    let id: Int?
   //let actorInfo : ActorDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        configureViewController()
        layoutUI()
        //fetchActorInfo(for: id!)
        fetchData(for: id)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    @objc func dismissVC(){
          dismiss(animated: true, completion: nil)
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
            
            case .success(let data):
                DispatchQueue.main.async {
                    self.addVC(childVC: childActorInfoVC(actor: data), to: self.headerView )
                }
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
