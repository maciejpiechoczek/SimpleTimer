//
//  DashLayer.swift
//  SimpleTimer
//
//  Created by Maciej Piechoczek on 07/10/2018.
//  Copyright © 2018 McPie. All rights reserved.
//

import UIKit

class DashLayer: CAShapeLayer {
    
    var length: CGFloat = 0 {
        didSet {
            verticalInset = (arcWidth - length)/2
            buildLayer()
        }
    }
    
    var arcWidth: CGFloat = 0 {
        didSet {
            verticalInset = (arcWidth - length)/2
            buildLayer()
        }
    }
    
    private var verticalInset: CGFloat = 0
    
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
        let minY = bounds.midY - bounds.midX
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: center.x, y: minY + verticalInset))
        path.addLine(to: CGPoint(x: center.x, y: minY + length + verticalInset))
        
        self.path = path.cgPath
        position = center
        
        let angle = percentage * 2 * CGFloat.pi
        transform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
    }
}
