//
//  UIViewController+Extension.swift
//  GeevEntretienTest
//
//  Created by ELANKUMARAN Tharsan on 11/06/2020.
//  Copyright © 2020 ELANKUMARAN Tharsan. All rights reserved.
//

import UIKit

public extension UIViewController  {
    
    // MARK: - Instance
    static var instance : Self {
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: String(describing: self), bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return vc as! Self
    }
    
    static var instanceCS : CSControllerProtocol {
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: String(describing: self), bundle: bundle)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! CSControllerProtocol
        vc.setupCS()
        return vc
    }
    
    // MARK: - Alert
    enum AlertActionButton {
        case title(String)
        case titleWithStyle(String, UIAlertAction.Style)
        
        var titleAndStyle: (String, UIAlertAction.Style) {
            switch self {
            case .title(let title):
                return (title, .default)
            case .titleWithStyle(let title, let style):
                return (title, style)
            }
        }
    }
    
    /// - Parameters:
    ///   - title: title of the alert
    ///   - message: message/body of the alert
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this paramter is nil
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter is nil no button will be highlighted
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument
    func showAlert(title: String?, message: String?, buttons: [AlertActionButton]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttons ?? [AlertActionButton]()
        if allButtons.count == 0 {
            allButtons.append(.title("OK"))
        }

        for index in 0..<allButtons.count {
            let button = allButtons[index].titleAndStyle
            
            let action = UIAlertAction(title: button.0, style: button.1, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

