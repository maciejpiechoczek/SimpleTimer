//
//  ArcLayer.swift
//  SimpleTimer
//
//  Created by Maciej Piechoczek on 07/10/2018.
//  Copyright © 2018 McPie. All rights reserved.
//

import UIKit

class ArcLayer: CAShapeLayer {
    
    var percentage: CGFloat = 1 {
        didSet {
            percentage = min(1, max(0, percentage))
            buildLayer()
        }
    }
    
    override init() {
        super.init()
        fillColor = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fillColor = nil
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        fillColor = nil
    }
    
    override var bounds: CGRect {
        didSet {
            buildLayer()
        }
    }
    
    func buildLayer() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = bounds.midX - lineWidth/2
        let startAngle = 1.5 * CGFloat.pi
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        self.path = path.cgPath
        position = center
        
        strokeEnd = percentage
    }
}
