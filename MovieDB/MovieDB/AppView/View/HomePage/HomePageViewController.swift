//
//  HomePageViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import UIKit
import Combine
import FittedSheets

class HomePageViewController: UIViewController {
    
    lazy var id: Int = 0
    lazy var movieTitle: String = ""
    var movieList: MovieList?
    weak var delegate: FetchedDataModelDelegate?
    let homePageViewModel = HomePageViewModel()

    @IBOutlet weak var homePageCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var listButton: UIButton = {
        var listButton = UIButton(frame: CGRect(x: -13, y: 0.0, width: 35, height: 35))
        listButton.setImage(UIImage(systemName: Constants.Images.homePageNavigationImage), for: .normal)
        listButton.tintColor = Constants.Colors.whiteColor
        listButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        listButton.addTarget(self, action: #selector(displayProfilePage), for: .touchUpInside)
        return listButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        homePageViewModel.delegate = self
        homePageViewModel.getPopularMoviesCategories()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentedControl.adjustFont()
        setUpNavigationBar()
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
    
    @objc func displayProfilePage() {
        view.layoutIfNeeded()
        let vc = BottomSheetViewControllerViewController()
        let sheetController = SheetViewController(controller: vc, sizes: [.percent(0.42)])
        sheetController.hasBlurBackground = false
        sheetController.gripColor = .clear
        sheetController.gripSize = CGSize(width: 50, height: 3)
        navigationController?.present(sheetController, animated: false)

    }
    
    func setDelegate() {
        homePageCollectionView.delegate = self
        homePageCollectionView.dataSource = self
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailViewController = MovieDetailsViewController()
        setUpCellWithSegmentedControlSelectedIndex(cell: nil, indexPath: indexPath)
        detailViewController.movieList = self.movieList
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension HomePageViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
          return  homePageViewModel.popularMovieCategories.count
        case 1:
            return homePageViewModel.top_ratingMovieCategories.count
        case 2:
            return homePageViewModel.airing_todayMovieCategories.count
        case 3:
            return homePageViewModel.on_the_airMovieCategories.count
        default:
            return 0
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(TVShowCollectionViewCell.self, for: indexPath)
            setUpCellWithSegmentedControlSelectedIndex(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func setUpCellWithSegmentedControlSelectedIndex(cell: TVShowCollectionViewCell?, indexPath: IndexPath) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell?.setUpCell(with: homePageViewModel.popularMovieCategories[indexPath.item])
            self.movieList = homePageViewModel.popularMovieCategories[indexPath.item]
        case 1:
            cell?.setUpCell(with: homePageViewModel.top_ratingMovieCategories[indexPath.item])
            self.movieList = homePageViewModel.top_ratingMovieCategories[indexPath.item]
        case 2:
            cell?.setUpCell(with: homePageViewModel.airing_todayMovieCategories[indexPath.item])
            self.movieList = homePageViewModel.airing_todayMovieCategories[indexPath.item]
        case 3:
            cell?.setUpCell(with: homePageViewModel.on_the_airMovieCategories[indexPath.item])
            self.movieList = homePageViewModel.on_the_airMovieCategories[indexPath.item]
        default:
            break
        }
    }
    
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    
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

extension HomePageViewController: FetchedDataModelDelegate {
    func getCalledWhenSeasonApiHasBeenCompleted(seasonNumber: Int) {
       
    }
    
    func errorNotifier(_ error: Error) {
        displayError(error: error.localizedDescription)
    }
    
    func configureUIAfterNetworkCall() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            self?.homePageCollectionView.reloadData()

        }
    }
    
    
}

