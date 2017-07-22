//
//  Extentions.swift
//  CarouselApp
//
//  Created by José de Almeida Cavalcante Neto on 22/07/17.
//  Copyright © 2017 José de Almeida Cavalcante Neto. All rights reserved.
//


import UIKit
//import Firebase

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        
    }
    
}


extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, botton: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let botton = botton {
            self.bottomAnchor.constraint(equalTo: botton, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
}

extension UINavigationController {
    override open var preferredStatusBarStyle : UIStatusBarStyle {
        
        if let rootViewController = self.viewControllers.first {
            return rootViewController.preferredStatusBarStyle
        }
        return super.preferredStatusBarStyle
        
    }
}

extension UICollectionViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UICollectionViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension NSDate {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(NSDate().timeIntervalSince(self as Date))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else {
            quotient = secondsAgo / month
            unit = "month"
        }
        
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
        
    }
}
//
//extension FIRDatabase {
//    
//    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()){
//        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let userDictionary = snapshot.value as? [String: Any] else {return}
//            let user = User(uid: uid, dictionary: userDictionary)
//            
//            completion(user)
//            
//        }) {(err) in
//            print("Failed to fetch the user with UID, ", err)
//        }
//    }
//    
//    static func fetchFollowedUsersWithUID(uid: String, completion: @escaping ([String: Int]) -> ()) {
//        FIRDatabase.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            
//            guard let usersUIDs = snapshot.value as? [String: Int] else {
//                print("nil snapshot from Firebase: ", snapshot)
//                return
//            }
//            
//            completion(usersUIDs)
//            
//        }) { (err) in
//            print("Failed to fetch followed users")
//        }
//    }    
//}
//
