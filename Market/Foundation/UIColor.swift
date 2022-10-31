//
//  UIColor.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import UIKit

extension UIColor {
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
}
