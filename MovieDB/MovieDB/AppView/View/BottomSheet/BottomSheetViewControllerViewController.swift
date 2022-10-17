//
//  ProfileViewControllerViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 16/10/2022.
//

import UIKit

class BottomSheetViewControllerViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!
    
    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(BottomSheetTableViewCell.self, forNib: false)
        trimTableviewHeader(profileTableView)
    }
    
    func handleDelegatePerformance(_ indexPath: IndexPath) {
        
        switch indexPath.row {
        case 1:
            let vc3 = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: vc3)
            navController.modalPresentationStyle = .formSheet
            self.present(navController, animated: true, completion: nil)
        case 2:
            weak var presentVc = self.presentingViewController
            self.dismiss(animated: true, completion: {
                let vc = ProfileViewController()
                vc.modalPresentationStyle = .custom
                vc.modalTransitionStyle = .crossDissolve
                presentVc?.present(vc, animated: true, completion: nil)
            })
        case 3:
            self.dismiss(animated: true)
        default:
            break
        }
    }
    
    func setUpCell(cell: UITableViewCell?, indexPath: IndexPath) {
        if let cell = cell {
            cell.textLabel?.text = profileViewModel.displayProfileItem[indexPath.row].title
            cell.textLabel?.textAlignment = .center
            if indexPath.row == 0 {
                cell.textLabel?.textColor = Constants.Colors.slateGreyColor
                cell.textLabel?.font = UIFont(name: Constants.Fonts.sf_pro_medium, size: 13)
            } else if indexPath.row == 1 ||  indexPath.row == 3  {
                cell.textLabel?.textColor = Constants.Colors.deepskyblueColor
                cell.textLabel?.font = UIFont(name: Constants.Fonts.sf_pro_regular, size: 20)
            } else {
                cell.textLabel?.textColor = Constants.Colors.coralColor
                cell.textLabel?.font = UIFont(name: Constants.Fonts.sf_pro_regular, size: 20)
            }
           
        }
    }
}

extension BottomSheetViewControllerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileViewModel.displayProfileItem.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReuseableCell(BottomSheetTableViewCell.self, at: indexPath)
        cell?.contentView.backgroundColor = Constants.Colors.almostBlackColor
        setUpCell(cell: cell, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

extension BottomSheetViewControllerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       handleDelegatePerformance(indexPath)
    }
}

