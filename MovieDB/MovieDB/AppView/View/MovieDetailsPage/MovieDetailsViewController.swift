//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 14/10/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var alreadyContained = false
    let persistence = MovieDBersistenceStore()
    var isliked = false
    var totalNumberOfTvSeriesSeason: Int = 0
    var movieList: MovieList?
    var creator: [String] = [String]()
    var episode = [Episode]()
    let movieDetailsViewModel = MovieDetailsViewModel()
    var favoritedItem = [RealmFavoritedModelObjects]() {
        didSet {
            
        }
    }
    var mockTrial = [Int]()
    var persistedData = [RealmFavoritedModelObjects]()
    var copyOfFavoriteItem: RealmFavoritedModelObjects?
    var movieCast = [Cast]()
    var id: Int = 0
    lazy var _titles: String = ""
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieCreator: UILabel!
    @IBOutlet weak var mostRecentSeason: UILabel!
    @IBOutlet weak var seasonImage: UIImageView!
    @IBOutlet weak var movieCastCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var averageMovieRating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unwrapDataNeededToDisPlayData()
        movieDetailsViewModel.movieId = self.id
        movieDetailsViewModel.getMovieDetailsByID()
        configureView()
        self.favoritedItem = FetchFavoritedDataFromRealm().data
        self.persistedData = FetchFavoritedDataFromRealm().data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
        setNavbarOpacity()
    }
    
    func configureCollectionView() {
        movieCastCollectionView.register(MovieCastCollectionViewCell.self, forCellWithReuseIdentifier: MovieCastCollectionViewCell.identifier)
        //        movieCastCollectionView.registerNib(MovieCastCollectionViewCell.self)
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
        seasonViewController.seasonNumber = self.totalNumberOfTvSeriesSeason
        seasonViewController.movieID = self.id
        navigationController?.present(seasonViewController, animated: true)
    }
    
    // moviList
    /*
     if favoritedItem .contains movilist.item ... remove it
     */
    
    func addToFavorite(sender: UIButton) {
        
        if mockTrial.contains(where: {$0 == movieList?.id}) {
            self.mockTrial.removeAll(where: { $0 == movieList?.id})
            sender.tintColor = .gray
            print("remove")
        } else {
            mockTrial.append(movieList?.id ?? 0)
            print("added")
            sender.tintColor = .red
        }
        
        copyOfFavoriteItem = saveItemToRealm()
//        if favoritedItem.contains(where: { $0.isLiked == copyOfFavoriteItem?.isLiked }) {
//            RealmPersistenceHandler.addToIsFavorite(favoritedState: saveItemToRealm())
//            print("remove")
//        } else {
////            copyOfFavoriteItem = saveItemToRealm()
//            RealmPersistenceHandler.addToIsFavorite(favoritedState: saveItemToRealm())
//            print("added")
//        }
//
//        self.persistedData = FetchFavoritedDataFromRealm().data
    }
    
    func saveItemToRealm() -> RealmFavoritedModelObjects {
        if let movieList = movieList {
            let modelToRealmObject = RealmFavoritedModelObjects()
            modelToRealmObject.id = movieList.id ?? 0
            modelToRealmObject.image = movieList.posterPath ?? ""
            modelToRealmObject.averageRatings = movieList.voteAverage ?? 0.0
            modelToRealmObject.date_Aired = movieList.releaseDate ?? ""
//            modelToRealmObject.isLiked = false
            persistence.save(items: modelToRealmObject)
            return modelToRealmObject
        }
       return RealmFavoritedModelObjects()
    }
    
    @IBAction func clickToFavorite(_ sender: UIButton) {
        addToFavorite(sender: sender)
    }
    
    func configureView() {
        activityIndicator.startAnimating()
        movieDetailsViewModel.delegate = self
        configureCollectionView()
        movieDescription.isEditable = false
        movieDescription.isScrollEnabled = true
        
    }
    
    func setNavBar() {
        let backButton = UIBarButtonItem()
        backButton.tintColor = .white
        //        backButton.setTit
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(movieDetailsViewModel.movieCast.count, "Yaaaaahhhh")
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastCollectionViewCell.identifier, for: indexPath) as? MovieCastCollectionViewCell? {
            //                cell?.actorName.text = self.movieDetailsViewModel.movieCast[indexPath.item].name
            
            return cell ?? UICollectionViewCell()
        }
        //        cell.textLabel?.text = movieDetailsViewModel.movieCast[indexPath.item].name
        //        cell?.setUpCellWith(movieDetailsViewModel.movieCast[indexPath.item])
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionView.frame.size.height / 1.7)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 5, left: 5, bottom: 5, right: 5
        )
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}


extension MovieDetailsViewController: FetchedDataModelDelegate {
    
    func getCalledWhenSeasonApiHasBeenCompleted(seasonNumber: Int) {
        movieDetailsViewModel.getSeriesEpisodeById_SeasonNumber()
        movieCast = movieDetailsViewModel.movieCast
        movieCastCollectionView.delegate = self
        movieCastCollectionView.dataSource = self
    }
    
    
    func errorNotifier(_ error: Error) {
        displayError(error: error.localizedDescription)
    }
    
    func configureUIAfterNetworkCall() {
        populateDetailsViewWithDataFromDetailsViewModel(model: movieDetailsViewModel.movieDetailsData)
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        movieCastCollectionView.reloadData()
        //        DispatchQueue.main.async {
        //            self.movieCastCollectionView.reloadData()
        //        }
    }
    
    
}

