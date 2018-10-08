//
//  Knob.swift
//  SimpleTimer
//
//  Created by Maciej Piechoczek on 06/10/2018.
//  Copyright © 2018 McPie. All rights reserved.
//

import UIKit

class Knob: UIControl {

    private let renderer = KnobRenderer()
    
    private var minimumValue: UInt = 1
    private var maximumValue: UInt = 12
    
    private(set) var value: UInt = 0
    private(set) var percentage: Double = 0 {
        didSet {
            renderer.setPercentage(CGFloat(percentage))
        }
    }
    
    var sliderWidth: CGFloat {
        get { return renderer.sliderWidth }
        set { renderer.sliderWidth = newValue }
    }
    
    var pointerWidth: CGFloat {
        get { return renderer.pointerWidth }
        set { renderer.pointerWidth = newValue }
    }
    
    var pointerLength: CGFloat {
        get { return renderer.pointerLength }
        set { renderer.pointerLength = newValue }
    }
    
    var fretWidth: CGFloat {
        get { return renderer.fretWidth }
        set { renderer.fretWidth = newValue }
    }
    
    var fretLength: CGFloat {
        get { return renderer.fretLength }
        set { renderer.fretLength = newValue }
    }
    
    override var tintColor: UIColor? {
        didSet {
            if let tintColor = tintColor {
                renderer.tintColor = tintColor
            }
        }
    }
    
    var trackBackgroundColor: UIColor? {
        get { return renderer.trackBackgroundColor }
        set { renderer.trackBackgroundColor = newValue }
    }
    
    var fretColor: UIColor? {
        get { return renderer.fretColor }
        set { renderer.fretColor = newValue }
    }
    
    var isContinuous = true
    
    override var isEnabled: Bool {
        didSet {
            renderer.pointerLayer.isHidden = !isEnabled
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        renderer.updateBounds(bounds)
        renderer.fretsCount = Int(maximumValue)
        if let tintColor = tintColor {
            renderer.tintColor = tintColor
        }
        
        layer.addSublayer(renderer.backgroundLayer)
        layer.addSublayer(renderer.trackLayer)
        layer.addSublayer(renderer.pointerLayer)
        layer.addSublayer(renderer.fretsLayer)
        
        let gestureRecognizer = RotationGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        addGestureRecognizer(gestureRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        renderer.updateBounds(bounds)
    }
    
    func setValue(_ value: UInt, animated: Bool = false) {
        self.value = min(maximumValue, max(minimumValue, value))
        percentage = Double(self.value) / Double(maximumValue)
    }
    
    func setPercentage(_ percentage: Double, animated: Bool = false) {
        self.percentage = min(1, max(0, percentage))
        value = UInt(round(self.percentage * Double(maximumValue)))
    }
    
    @objc private func handleGesture(_ gesture: RotationGestureRecognizer) {
        
        let midPointAngle = (2 * CGFloat.pi + renderer.startAngle - renderer.endAngle) / 2 + renderer.endAngle
        
        var boundedAngle = gesture.touchAngle
        if boundedAngle > midPointAngle {
            boundedAngle -= 2 * CGFloat.pi
            
        } else if boundedAngle < (midPointAngle - 2 * CGFloat.pi) {
            boundedAngle -= 2 * CGFloat.pi
        }
        
        boundedAngle = min(renderer.endAngle, max(renderer.startAngle, boundedAngle))
        
        let angleRange = renderer.endAngle - renderer.startAngle
        let valueRange = maximumValue - minimumValue
        
        let floatValue = (boundedAngle - renderer.startAngle) / angleRange * CGFloat(valueRange) + CGFloat(minimumValue)
        setPercentage(Double(floatValue / CGFloat(maximumValue)))
        
        if isContinuous {
            sendActions(for: .valueChanged)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            sendActions(for: .valueChanged)
        }
    }
}
