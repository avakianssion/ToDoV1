//
//  ScaleSegue.swift
//  ToDoV1
//
//  Created by Studio on 7/6/18.
//  Copyright © 2018 Son Avakian. All rights reserved.
//

import UIKit

class ScaleSegue: UIStoryboardSegue {
    
    override func perform() {
        scale()
    }
    func scale () {
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: {success in
            fromViewController.present(toViewController, animated: false, completion: nil)
        })
        
    }
    
}
