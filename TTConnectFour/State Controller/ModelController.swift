//
//  ModelController.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import Foundation

class ModelController {
    
    var gameBoard: GameBoard?
    
    var gameHistory: GameHistory?
    
    func saveModel(game: GameBoard?, history: GameHistory?) {
        gameBoard = game
        gameHistory = history
    }
    
    func loadModel(completion: ((Bool) -> Void)) {
        gameHistory = GameHistory(games: [GameBoard]())
        gameBoard = nil
        completion(true)
    }
    
}
