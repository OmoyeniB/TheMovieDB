//
//  UICollectionViewGenericDelegate.swift
//  MovieDB
//
//  Created by Sharon Omoyeni Babatunde on 13/10/2022.
//

import UIKit

protocol ResuseableView {
    static var identifier: String { get }
}

extension ResuseableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ResuseableView {}
extension UITableViewHeaderFooterView: ResuseableView {}
extension UICollectionReusableView : ResuseableView {}

protocol NibLoadable {
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadable {}
extension UITableViewHeaderFooterView: NibLoadable {}
extension UICollectionReusableView: NibLoadable {}

extension UICollectionView {
    func register<T: UICollectionReusableView>(_ : T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionReusableView>(_ : T.Type, ofKind kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }
    
    func registerNib<T: UICollectionReusableView>(_ : T.Type) {
        let reuseIdentifer = T.identifier
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: reuseIdentifer)
    }
    
    func registerNib<T: UICollectionReusableView>(_ : T.Type, ofKind kind: String) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ : T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier,
                                           for: indexPath) as? T else {
                                            fatalError("Please verify cell identifier \(T.identifier)")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(_ : T.Type, ofKind kind: String, for indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: T.identifier,
                                                for: indexPath) as? T
    }
}
