//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 14/10/2022.
//

import UIKit


class MovieDetailsViewController: UIViewController {
    
    var alreadyContained = false
    var isliked = false
    var totalNumberOfTvSeriesSeason: Int = 0
    var movieList: MovieList?
    var creator: [String] = [String]()
    var episode = [Episode]()
    let movieDetailsViewModel = MovieDetailsViewModel()
    var movieCast = [Cast]()
    var seasonNumber = 0 {
        didSet {
        }
    }
    var id: Int = 0
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieCreator: UILabel!
    @IBOutlet weak var mostRecentSeason: UILabel!
    @IBOutlet weak var seasonImage: UIImageView!
    @IBOutlet weak var movieCastCollectionView: UICollectionView!
    @IBOutlet weak var lastSeason: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var releasedDate: UILabel!
    
    @IBOutlet weak var averageRatings: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        unwrapDataNeededToDisPlayData()
        movieDetailsViewModel.movieId = self.id
        movieDetailsViewModel.getMovieDetailsByID()
        configureView()
        movieDetailsViewModel.closure = {
            self.movieCastCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
        setNavbarOpacity()
    }
    
    func configureView() {
        activityIndicator.startAnimating()
        movieDetailsViewModel.delegate = self
        configureCollectionView()
        lastSeason.text = "\(seasonNumber)"
        averageRatings.text = "\(movieList?.voteAverage ?? 0.0)"
        releasedDate.text = Date.getFormattedDate(string: movieList?.releaseDate ?? "", formatter: "yyyy-MM-dd")
        movieDescription.isEditable = false
        movieDescription.isScrollEnabled = true
    }
    
    func configureCollectionView() {
        movieCastCollectionView.register(MovieCastCollectionViewCell.self, forCellWithReuseIdentifier: MovieCastCollectionViewCell.identifier)
        movieCastCollectionView.delegate = self
        movieCastCollectionView.dataSource = self
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
            movieCreator.text = "Created by \(nameString)"
        } else {
            
        }
    }
    
    @IBAction func clickToViewSeason(_ sender: Any) {
        let seasonViewController = MovieSeasonViewController()
        seasonViewController.navigationController?.modalPresentationStyle = .pageSheet
        seasonViewController.navigationController?.modalTransitionStyle = .crossDissolve
        seasonViewController.season = self.movieDetailsViewModel.season
        seasonViewController.episode = self.movieDetailsViewModel.episodes
        seasonViewController.movieID = self.id
        navigationController?.present(seasonViewController, animated: true)
    }
    
    
    @IBAction func clickToFavorite(_ sender: UIButton) {
        
    }
    
    func setNavBar() {
        let backButton = UIBarButtonItem()
        backButton.tintColor = .white
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
   
}

extension MovieDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetailsViewModel.movieCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastCollectionViewCell.identifier, for: indexPath) as? MovieCastCollectionViewCell {
            
            cell.setUpCellWith(movieDetailsViewModel.movieCast[indexPath.item], season: movieDetailsViewModel.episodes)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionView.frame.size.height - padding, height: collectionView.frame.size.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 5, left: 5, bottom: 5, right: 5
        )
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}


extension MovieDetailsViewController: FetchedDataModelDelegate {
    
    func getCalledWhenSeasonApiHasBeenCompleted(seasonNumber: Int) {
        movieDetailsViewModel.getEpisdoeOfSeason(seasonNumber)
        DispatchQueue.main.async { [weak self] in
            self?.lastSeason.text = "Season \(self?.seasonNumber ?? 0)"
            self?.movieCastCollectionView.reloadData()
        }
        for number in movieDetailsViewModel.movieDetailsData {
            self.seasonNumber = number.numberOfSeasons ?? 0
        }
        self.episode = movieDetailsViewModel.episodes
        populateDetailsViewWithDataFromDetailsViewModel(model: movieDetailsViewModel.movieDetailsData)
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    
    func errorNotifier(_ error: Error) {
        displayError(error: error.localizedDescription)
    }
    
    func configureUIAfterNetworkCall() {
        
        
    }
    
    
}

