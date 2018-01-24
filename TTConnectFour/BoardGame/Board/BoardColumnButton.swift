//
//  BoardColumnButton.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/23/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import UIKit

protocol ColumnButtonDelegate {
    
    func pressButtonForColumn(column: Int)
    
}

class BoardColumnButton: UIView {

    //MARK: Properties
    
    var column = -1
    
    var delegate: ColumnButtonDelegate?
    
    //MARK: Drawing
    
    override func draw(_ rect: CGRect) {
        let buttonRect = bounds.insetBy(dx: 0.90, dy: 0.90)
        let buttonPath = UIBezierPath(roundedRect: buttonRect, cornerRadius: bounds.width * 0.05)
        UIColor.black.setStroke()
        buttonPath.lineWidth = bounds.width * 0.1
        buttonPath.stroke()
        UIColor.blue.setFill()
        buttonPath.fill()
    }
    
    //MARK: Setup
    
    private func setup() {
        backgroundColor = UIColor.clear
        contentMode = .redraw
        isOpaque = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnButton(tapGesture:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: Gestures
    
    @objc func tappedOnButton(tapGesture: UITapGestureRecognizer) {
        delegate?.pressButtonForColumn(column: column)
    }

}
