//
//  SearchVC.swift
//  SA
//
//  Created by максим  кондратьев  on 23.08.2021.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let movieTF = TextFields()
    let actionGoButton = Buttons(backgroundColor: .systemOrange, title: "Go along")
    
    var isEntered: Bool {
        return !movieTF.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurelogoImageView()
        configureMovieTF()
        configureActionGoButton()
        dismissKeyboard()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    
    }
    //Dissmiss 
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    //Passing data using another VC
    @objc func pushMoviesVC() {
        
        guard isEntered else {
            print("Error")
            presentAlertonMainThread(title: "Empty String", message: "Please enter some movie", buttonTitle: "Got it!")
            return
        }
        let moviesVC = MoviesVC()
        moviesVC.movieName = movieTF.text
        moviesVC.title = movieTF.text
        navigationController?.pushViewController(moviesVC, animated: true)

    }
    
    // MARK:  CONFIGURATION
    func configurelogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "imdb")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureMovieTF() {
        view.addSubview(movieTF)
        movieTF.delegate = self
        movieTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieTF.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 70),
            movieTF.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            movieTF.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            movieTF.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureActionGoButton() {
        view.addSubview(actionGoButton)
        actionGoButton.addTarget(self, action: #selector(pushMoviesVC), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            actionGoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            actionGoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 100),
           actionGoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -100),
            
            actionGoButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushMoviesVC()
        return true
    }
}
