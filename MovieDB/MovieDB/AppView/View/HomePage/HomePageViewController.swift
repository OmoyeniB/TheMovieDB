//
//  HomePageViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import UIKit

class HomePageViewController: UIViewController {
    
    lazy var twoDArray = [[MovieList]]()

    lazy var popularMovieCategories = [MovieList]()
    lazy var top_ratingMovieCategories = [MovieList]()
    lazy var airing_todayMovieCategories = [MovieList]()
    lazy var on_the_airMovieCategories = [MovieList]()
    lazy var allMovieCategoryList = [[MovieList]]()
    let homePageViewModel = HomePageViewModel()
    
    @IBOutlet weak var homePageCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var listButton: UIButton = {
        var listButton = UIButton(frame: CGRect(x: -13, y: 0.0, width: 35, height: 35))
        listButton.setImage(UIImage(systemName: Constants.Images.homePageNavigationImage), for: .normal)
        listButton.tintColor = Constants.Colors.whiteColor
        listButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return listButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homePageViewModel.getPopularMoviesCategories()
        homePageViewModel.getTopRatingMovieCategories()
        homePageViewModel.getAiring_todayMovieCategories()
        homePageViewModel.geton_the_airMovieCategories()
        setUpNavigationBar()
        twoDArray = [homePageViewModel.popularMovieCategories, homePageViewModel.top_ratingMovieCategories, homePageViewModel.airing_todayMovieCategories, homePageViewModel.on_the_airMovieCategories]
        setDelegate()
        print(twoDArray)
    }
    
    @IBAction func segmentedControlValueDidChange(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
          _ = homePageViewModel.popularMovieCategories
        case 1:
            _ = homePageViewModel.top_ratingMovieCategories
        case 2:
            _ = homePageViewModel.airing_todayMovieCategories
        case 3:
            _ = homePageViewModel.on_the_airMovieCategories
        default:
            break
        }
        DispatchQueue.main.async { [weak self] in
            self?.homePageCollectionView.reloadData()
        }
    }
    
    func setDelegate() {
        homePageCollectionView.delegate = self
        homePageCollectionView.registerNib(TVShowCollectionViewCell.self)
    }
    
    func setUpNavigationBar() {
        title = setUpNavigationTitle(text: "TV Shows")
        let textAttributes = [NSAttributedString.Key.foregroundColor:Constants.Colors.whiteColor ?? .white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        let rightNavItem = addCustomButtonInNavigationBar(button: listButton)
        self.navigationItem.rightBarButtonItem = rightNavItem
    }
    
    
}

extension HomePageViewController: UICollectionViewDelegate {
    
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionView.frame.size.height / 2)
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


