//
//  GameHistoryTableViewCell.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/23/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import UIKit

class GameHistoryTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet fileprivate weak var player1NameLabel: UILabel!
    
    @IBOutlet fileprivate weak var player1StatusLabel: UILabel!
    
    @IBOutlet fileprivate weak var player1ChipsLabel: UILabel!
    
    @IBOutlet fileprivate weak var player2NameLabel: UILabel!
    
    @IBOutlet fileprivate weak var player2StatusLabel: UILabel!
    
    @IBOutlet fileprivate weak var player2ChipsLabel: UILabel!
}

class GameHistoryCellModel {
    
    //MARK: Properties
    
    private var gameBoard: GameBoard
    
    init(game: GameBoard) {
        gameBoard = game
    }
    
    func setGameValues(inCell cell: GameHistoryTableViewCell) {
        guard gameBoard.players.count >= 2 else { return }
        let player1 = gameBoard.players[0]
        cell.player1NameLabel.text = player1.nickName
        cell.player1StatusLabel.text = player1.state == .Won ? "Won!" : "Lost!"
        cell.player1ChipsLabel.text = "Played \(player1.chipsPlayed) chips"
        let player2 = gameBoard.players[1]
        cell.player2NameLabel.text = player2.nickName
        cell.player2StatusLabel.text = player2.state == .Won ? "Won!" : "Lost!"
        cell.player2ChipsLabel.text = "Played \(player2.chipsPlayed) chips"
        
    }
    
}
