//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 14/10/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var id: Int = 0
    lazy var _titles: String = ""
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieCreator: UILabel!
    @IBOutlet weak var mostRecentSeason: UILabel!
    @IBOutlet weak var seasonImage: UIImageView!
    @IBOutlet weak var averageMovieRating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
        setNavbarOpacity()
        configureView()
//        print(_titles)
        movieTitle.text = _titles
    }

    @IBAction func clickToViewSeason(_ sender: Any) {
    }
    
    @IBAction func clickToFavorite(_ sender: Any) {
    }
    
    func configureView() {
        movieDescription.isEditable = false
        movieDescription.isScrollEnabled = true
    }
    
    func loadViewWithDataFromEndpoint() {
        
    }
    
    func setNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        let textAttributes = [NSAttributedString.Key.foregroundColor:Constants.Colors.whiteColor ?? .white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
}
