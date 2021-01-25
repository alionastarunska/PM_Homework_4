//
//  LoadableViewController.swift
//  Homework_4
//
//  Created by Aliona Starunska on 25.01.2021.
//

import UIKit

protocol LoadableViewController {
    var activityView: UIActivityIndicatorView { get }
    func startLoading()
    func endLoading()
}

extension LoadableViewController {
    
    func startLoading() {
        activityView.startAnimating()
        activityView.superview?.isUserInteractionEnabled = false
    }
    
    func endLoading() {
        activityView.stopAnimating()
        activityView.superview?.isUserInteractionEnabled = true
    }
}
