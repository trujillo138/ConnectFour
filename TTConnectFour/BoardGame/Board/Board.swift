//
//  Board.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import UIKit

protocol BoardDelegate {
    
    func placeChipInColumn(column: Int) -> Int?
    
}

class Board: UIView, ColumnButtonDelegate {
    
    //MARK: Properties
    
    private var rows = 0
    
    private var columns = 0
    
    private var currentPlayer = 1
    
    var delegate: BoardDelegate?
    
    var squareSize: CGFloat {
        return CGFloat.minimum(bounds.width / CGFloat(columns), bounds.width / CGFloat(rows + 1))
    }
    
    var startingYCoor: CGFloat {
        return bounds.height - squareSize * 2
    }
    
    
    //MARK: Drawing
    
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        for i in 0..<columns {
            for j in 0..<rows {
                let xCoor = CGFloat(i) * squareSize
                let yCoor = startingYCoor - (CGFloat(j) * squareSize)
                let chipSlotOrigin = CGPoint(x: xCoor, y: yCoor)
                let chipSlotSize = CGSize(width: squareSize, height: squareSize)
                let chipSlotFrame = CGRect(origin: chipSlotOrigin, size: chipSlotSize)
                let chipSlotPath = UIBezierPath.init(ovalIn: chipSlotFrame)
                chipSlotPath.stroke()
            }
        }
    }
    
    func startGame(withColumns columns: Int, andRows rows: Int) {
        self.columns = columns
        self.rows = rows
        startCleanBoard()
    }
    
    private func startCleanBoard() {
        for view in subviews {
            view.removeFromSuperview()
        }
        placeButtons()
        currentPlayer = 1
        setNeedsDisplay()
    }
    
    private func placeButtons() {
        for i in 0 ..< columns {
            let buttonYCoor = startingYCoor + squareSize
            let buttonXCoor = CGFloat(i) * squareSize
            let frame = CGRect(x: buttonXCoor, y: buttonYCoor, width: squareSize, height: squareSize)
            let boardButton = BoardColumnButton(frame: frame)
            boardButton.delegate = self
            boardButton.column = i
            addSubview(boardButton)
        }
    }
    
    //MARK: Placing Chips
    
    func pressButtonForColumn(column: Int) {
        guard let row = delegate?.placeChipInColumn(column: column) else {
            return
        }
        placeChipIn(column: column, row: row)
        currentPlayer = currentPlayer == 1 ? 2 : 1
    }
    
    private func placeChipIn(column: Int, row: Int) {
        let xCoor = CGFloat(column) * squareSize
        let yCoor = startingYCoor - (CGFloat(row) * squareSize)
        let chipOrigin = CGPoint(x: xCoor, y: yCoor)
        let chipSize = CGSize(width: squareSize, height: squareSize)
        let chipFrame = CGRect(origin: chipOrigin, size: chipSize)
        let color = currentPlayer == 1 ? UIColor.red : UIColor.black
        let chip = BoardChip(frame: chipFrame, color: color)
        addSubview(chip)
    }
    
    //MARK: Setup
    
    private func setup() {
        backgroundColor = UIColor.clear
        isOpaque = false
        contentMode = .redraw
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
