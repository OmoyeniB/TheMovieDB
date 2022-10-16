//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 14/10/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var totalNumberOfTvSeriesSeason: Int = 0
    var movieList: MovieList?
    var creator: [String] = [String]()
    var episode = [Episode]()
    let movieDetailsViewModel = MovieDetailsViewModel()
    var id: Int = 0
    //    var seasonNumber: Int = 1
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
        unwrapDataNeededToDisPlayData()
        movieDetailsViewModel.movieId = self.id
        movieDetailsViewModel.getMovieDetailsByID()
        movieDetailsViewModel.delegate = self
        movieTitle.text = _titles
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
        setNavbarOpacity()
        configureView()
    }
    
    func unwrapDataNeededToDisPlayData() {
        if let movieList = movieList {
            populateDetailsViewWithDataFromPresentingViewController(data: movieList)
        }
    }
    
    func populateDetailsViewWithDataFromPresentingViewController(data: MovieList) {
        self.id = data.id ?? 0
        DispatchQueue.main.async {
            self.movieTitle.text = data.name
            self.movieDescription.text = data.overview
            self.view.downloadImage(with: data.imageURL, images: self.movieImage)
            self.view.downloadImage(with: data.imageURL, images: self.seasonImage)
        }
    }
    
    func populateDetailsViewWithDataFromDetailsViewModel(model: [MovieSeason]) {
        var creator = [CreatedBy]()
        for data in model {
            totalNumberOfTvSeriesSeason = data.numberOfSeasons ?? 0
            creator = data.createdBy
        }
        
        if creator.count > 0 {
            for creators in creator {
                self.creator.append(creators.name)
            }
            let nameString = self.creator.joined(separator: ", ")
            movieCreator.text = nameString
        } else {
            
        }
    }
    
    @IBAction func clickToViewSeason(_ sender: Any) {
        let seasonViewController = MovieSeasonViewController()
        seasonViewController.navigationController?.modalPresentationStyle = .pageSheet
        seasonViewController.navigationController?.modalTransitionStyle = .crossDissolve
        seasonViewController.seasonNumber = self.totalNumberOfTvSeriesSeason
        seasonViewController.movieID = self.id
//        seasonViewController.episode = self.episode
        navigationController?.present(seasonViewController, animated: true)
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


extension MovieDetailsViewController: FetchedDataModelDelegate {
    
    func errorNotifier(_ error: Error) {
        displayError(error: error.localizedDescription)
    }
    
    func configureUIAfterNetworkCall() {
//        print(movieDetailsViewModel.movieDetailsData, "*****")
        populateDetailsViewWithDataFromDetailsViewModel(model: movieDetailsViewModel.movieDetailsData)
        
        /*
         do something after network call is made
         */
    }
    
    
}
