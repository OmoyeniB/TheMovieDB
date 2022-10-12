//
//  ViewController.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 12/10/2022.
//

import UIKit

class ViewController: UIViewController {

    let height = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UIScreen.main.bounds.height)
    }

    @IBOutlet weak var adjustConstraintsIfNeeded: NSLayoutConstraint!
    

    func printFonts() {
        for family in UIFont.familyNames {
                    let sName: String = family as String
                    print("family: \(sName)")
                            
                    for name in UIFont.fontNames(forFamilyName: sName) {
                        print("name: \(name as String)")
                    }
                }
    }
}

