//
//  Loader.swift
//  MUNZUL
//
//  Created by Navdeep Singh on 18/03/24.
//
import UIKit

import Foundation
import NVActivityIndicatorView

protocol Loader {
    func startLoading()
    func stopLoading()
}

class GlobalLoader: Loader {

    static let shared = GlobalLoader() // Singleton instance

    private let activityIndicator: NVActivityIndicatorView

    private init() {
        // Use ballGridPulse style from NVActivityIndicatorView
        activityIndicator = NVActivityIndicatorView(frame: .zero, type: .ballGridPulse, color: .white, padding: nil)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let window = UIApplication.shared.windows.first {
                window.addSubview(self.activityIndicator)
                NSLayoutConstraint.activate([
                    self.activityIndicator.centerXAnchor.constraint(equalTo: window.centerXAnchor),
                    self.activityIndicator.centerYAnchor.constraint(equalTo: window.centerYAnchor)
                ])
                self.activityIndicator.startAnimating()
            }
        }
    }

    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }

}
