//
//  KnobRenderer.swift
//  SimpleTimer
//
//  Created by Maciej Piechoczek on 07/10/2018.
//  Copyright © 2018 McPie. All rights reserved.
//

import UIKit

class KnobRenderer {

    var backgroundLayer = ArcLayer()
    var trackLayer = ArcLayer()
    var pointerLayer = DashLayer()
    var fretsLayer = FretsLayer()

    var sliderWidth: CGFloat = 0 {
        didSet {
            backgroundLayer.lineWidth = sliderWidth
            trackLayer.lineWidth = sliderWidth
            pointerLayer.arcWidth = sliderWidth
            fretsLayer.arcWidth = sliderWidth
        }
    }
    
    var pointerWidth: CGFloat = 0 {
        didSet {
            pointerLayer.lineWidth = pointerWidth
        }
    }
    
    var pointerLength: CGFloat = 0 {
        didSet {
            pointerLayer.length = pointerLength
        }
    }
    
    var fretWidth: CGFloat = 0 {
        didSet {
            fretsLayer.lineWidth = fretWidth
        }
    }
    
    var fretLength: CGFloat = 0 {
        didSet {
            fretsLayer.length = fretLength
        }
    }
    
    var fretsCount: Int = 0 {
        didSet {
            fretsLayer.instanceCount = fretsCount
            startAngle = (1.0 / CGFloat(fretsCount)) * 2 * CGFloat.pi
        }
    }
    
    var tintColor: UIColor? {
        didSet {
            trackLayer.strokeColor = tintColor?.cgColor
            pointerLayer.strokeColor = tintColor?.cgColor
        }
    }
    
    var trackBackgroundColor: UIColor? {
        didSet {
            backgroundLayer.strokeColor = trackBackgroundColor?.cgColor
        }
    }
    
    var fretColor: UIColor? {
        didSet {
            fretsLayer.strokeColor = fretColor?.cgColor
        }
    }
    
    var trackPercentage: CGFloat = 0 {
        didSet {
            trackPercentage = min(1, max(0, trackPercentage))
            trackLayer.percentage = trackPercentage
        }
    }
    
    var pointerPercentage: CGFloat = 0 {
        didSet {
            pointerPercentage = min(1, max(0, pointerPercentage))
            pointerLayer.percentage = pointerPercentage
        }
    }
    
    private(set) var startAngle: CGFloat = -0.5 * CGFloat.pi
    let endAngle: CGFloat = 1.5 * CGFloat.pi
    
    func setPercentage(_ percentage: CGFloat, animated: Bool = false) {
        trackPercentage = percentage
        
        let closestIntValue = UInt(round(percentage * CGFloat(fretsCount)))
        pointerPercentage = CGFloat(closestIntValue) / CGFloat(fretsCount)
    }
    
    func updateBounds(_ bounds: CGRect) {
        backgroundLayer.bounds = bounds
        trackLayer.bounds = bounds
        pointerLayer.bounds = bounds
        fretsLayer.bounds = bounds
    }
}
