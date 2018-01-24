//
//  BoardChip.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/23/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import UIKit

class BoardChip: UIView {

    //MARK: Properties
    
    var color: UIColor?
    
    //MARK: Drawing
    
    override func draw(_ rect: CGRect) {
        let circleRect = bounds.insetBy(dx: 0.95, dy: 0.95)
        let circlePath = UIBezierPath(ovalIn: circleRect)
        color?.setFill()
        circlePath.fill()
        UIColor.black.setStroke()
        circlePath.lineWidth = bounds.width * 0.025
        circlePath.stroke()
    }
    
    //MARK: Setup
    
    private func setup() {
        isOpaque = false
        contentMode = .redraw
        backgroundColor = UIColor.clear
    }
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.color = color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

}
