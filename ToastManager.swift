//
//  ToastManager.swift
//  DownloadManagerProject
//
//  Created by Vipin Sharma on 13/09/23.
//

import Foundation
import UIKit


class ToastManager {
    static let shared = ToastManager()
    
    private let toastDuration: TimeInterval = 3.0
    
    private init() { }
    
    func showToast(message: String, on view: UIView) {
        let toastLabel = UILabel()
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 15)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.numberOfLines = 0 // Allow multiple lines for long text
        
        // Calculate the maximum width for the toast
        let maxWidth = view.frame.size.width - 100
        let textSize = (message as NSString).boundingRect(
            with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: toastLabel.font ?? UIFont.systemFont(ofSize: 15)],
            context: nil
        )
        
        // Calculate the toast's frame based on text size
        let toastWidth = min(textSize.width + 20, maxWidth) // Limit width to screen width - 100
        let toastHeight = textSize.height + 20
        let xPosition = (view.frame.size.width - toastWidth) / 2
        let yPosition = view.frame.size.height + 20 // Start below the screen
        
        toastLabel.frame = CGRect(x: xPosition, y: yPosition, width: toastWidth, height: toastHeight)
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.3, animations: {
            toastLabel.alpha = 1.0
            toastLabel.frame.origin.y = view.frame.size.height - toastHeight - 100 // Move to desired position
        }) { _ in
            UIView.animate(withDuration: self.toastDuration, delay: 1.0, options: .curveEaseIn, animations: {
                toastLabel.alpha = 0.0
                toastLabel.frame.origin.y = view.frame.size.height + 20 // Move below the screen again
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
