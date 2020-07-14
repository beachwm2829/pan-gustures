//
//  ViewController.swift
//  pan-gustures
//
//  Created by macOS on 7/14/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func handlePan(_ gesture: UIPanGestureRecognizer) {
        // 1
        let translation = gesture.translation(in: view)

        // 2
        guard let gestureView = gesture.view else {
            return
        }

        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )

        // 3
        gesture.setTranslation(.zero, in: view)
     
        guard gesture.state == .ended else {
            return
        }
        // 1
        let velocity = gesture.velocity(in: view)
        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
        let slideMultiplier = magnitude / 200

        // 2
        let slideFactor = 0.1 * slideMultiplier
        // 3
        var finalPoint = CGPoint(
            x: gestureView.center.x + (velocity.x * slideFactor),
            y: gestureView.center.y + (velocity.y * slideFactor)
        )

        // 4
        finalPoint.x = min(max(finalPoint.x, 0), view.bounds.width)
        finalPoint.y = min(max(finalPoint.y, 0), view.bounds.height)

        // 5
        UIView.animate(
            withDuration: Double(slideFactor * 2),
            delay: 0,
            // 6
            options: .curveEaseOut,
            animations: {
                gestureView.center = finalPoint
        })
    }
    
    @IBAction func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let gestureView = gesture.view else {
          return
        }

        gestureView.transform = gestureView.transform.scaledBy(
          x: gesture.scale,
          y: gesture.scale
        )
        gesture.scale = 1

    }
    
    @IBAction func handleRotate(_ gesture: UIRotationGestureRecognizer) {
        guard let gestureView = gesture.view else {
          return
        }

        gestureView.transform = gestureView.transform.rotated(
          by: gesture.rotation
        )
        gesture.rotation = 0

    }

}

