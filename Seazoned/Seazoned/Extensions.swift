//
//  Extension.swift
// BanBan
//
//  Created by Tanay Bhattacharjee.
//  Copyright © 2017 Tanay Bhattacharjee All rights reserved.

import UIKit

extension UILabel{
    
    // Set lebel height according to text.
    
    func setHeight()-> CGFloat{
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }

    
}
extension UITableViewCell {
    func setTransparent() {
        let bgView: UIView = UIView()
        bgView.backgroundColor = .clear        
        self.backgroundView = bgView
        self.backgroundColor = .clear
    }
}
extension String{
//    func convertHtml() -> NSAttributedString{
////        guard let data = data(using: .utf8) else { return NSAttributedString() }
////        do{
////            return try
//////            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
////        }catch{
////            return NSAttributedString()
////        }
//    }
}



extension UIViewController {
    
    func hideKeyboardOnTapOutside() {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard1))
        view.addGestureRecognizer(tap)
    }
    
    // Hide Keyboard
    @objc func dismissKeyboard1(){
        view.endEditing(true)
    }
    
   
    
    
    
    
}

extension Int {
    
    func generateRandomDigits(_ digitNumber: Int) -> String {
        var number = ""
        for i in 0..<digitNumber {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
}
