//
//  FretsLayer.swift
//  SimpleTimer
//
//  Created by Maciej Piechoczek on 07/10/2018.
//  Copyright © 2018 McPie. All rights reserved.
//

import UIKit

class FretsLayer: CAReplicatorLayer {
    
    private var replicatedLayer = DashLayer()
    
    override var instanceCount: Int {
        didSet {
            let angle = 2 * CGFloat.pi / CGFloat(instanceCount)
            instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        }
    }
    
    var lineWidth: CGFloat {
        get { return replicatedLayer.lineWidth }
        set { replicatedLayer.lineWidth = newValue }
    }
    
    var length: CGFloat {
        get { return replicatedLayer.length }
        set { replicatedLayer.length = newValue }
    }
    
    var arcWidth: CGFloat {
        get { return replicatedLayer.arcWidth }
        set { replicatedLayer.arcWidth = newValue }
    }
    
    var strokeColor: CGColor? {
        get { return replicatedLayer.strokeColor }
        set { replicatedLayer.strokeColor = newValue }
    }
    
    override init() {
        super.init()
        addSublayer(replicatedLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSublayer(replicatedLayer)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        addSublayer(replicatedLayer)
    }
    
    override var bounds: CGRect {
        didSet {
            let center = CGPoint(x: bounds.midX, y: bounds.midY)
            position = center
            
            replicatedLayer.bounds = bounds
        }
    }
}
