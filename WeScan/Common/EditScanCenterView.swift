//
//  EditScanCenterView.swift
//  WeScan
//
//  Created by Esraa Eid on 24/07/2021.
//  Copyright © 2021 WeTransfer. All rights reserved.
//


import UIKit
import CoreImage

/// A UIView used by corners of a quadrilateral that is aware of its position.
final class EditScanCenterView: UIView {
    
    let position: CenterPosition
    
    /// The image to display when the corner view is highlighted.
    private var image: UIImage?
    private(set) var isHighlighted = false
    
    private lazy var circleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.white.cgColor
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 1.0
        return layer
    }()

    /// Set stroke color of coner layer
    public var strokeColor: CGColor? {
        didSet {
            circleLayer.strokeColor = strokeColor
        }
    }
    
    init(frame: CGRect, position: CenterPosition) {
        self.position = position
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        layer.addSublayer(circleLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 6.0
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let bezierPath = UIBezierPath(ovalIn: rect.insetBy(dx: circleLayer.lineWidth, dy: circleLayer.lineWidth))
        circleLayer.frame = rect
        circleLayer.path = bezierPath.cgPath
        image?.draw(in: rect)
    }
    
    func highlightWithImage(_ image: UIImage) {
        isHighlighted = true
        self.image = image
        self.setNeedsDisplay()
    }
    
    func reset() {
        isHighlighted = false
        image = nil
        setNeedsDisplay()
    }
    
}
