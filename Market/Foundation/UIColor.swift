//
//  UIColor.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import UIKit

extension UIColor {
    
    public class var appColor: UIColor {
        return UIColor(red: 216.0/255.0, green: 100.0/255.0, blue: 43.0/255.0, alpha: 1.0)
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
}
