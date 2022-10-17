//
//  ViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 12/10/2022.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    let height = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        adjustDistanceBetweenImageIfScreenIsSmall()
    }
    
    @IBOutlet weak var adjustConstraintsIfNeeded: NSLayoutConstraint!
    @IBAction func clickToLogin(_ sender: Any) {
        let vc3 = HomePageViewController(nibName: "HomePageViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: vc3)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    func adjustDistanceBetweenImageIfScreenIsSmall() {
        
        DispatchQueue.main.async {
            if UIScreen.main.bounds.height >= 720 {
                self.view.layoutIfNeeded()
//                self.adjustConstraintsIfNeeded.constant = 82
            } else {
//                self.adjustConstraintsIfNeeded.constant = 19
            }
        }
    }
    
    
}

