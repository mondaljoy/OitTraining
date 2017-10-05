//
//  UIView+Extention.swift
//  TableView
//
//  Created by JOY MONDAL on 9/4/17.
//  Copyright © 2017 OPTLPTP131. All rights reserved.
//

import UIKit
var loaderView: UIView?

extension UIView
{
    func displayLoader() {
        loaderView = UIView()
        loaderView?.frame = self.bounds
        loaderView?.backgroundColor = UIColor.gray
        loaderView?.alpha = 0.5
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.startAnimating()
        loaderView?.addSubview(activityIndicator)
        activityIndicator.center = (loaderView?.center)!
        
        self.addSubview(loaderView!)
        self.bringSubview(toFront: loaderView!)
    }
    
    func hideLoader() {
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
}

