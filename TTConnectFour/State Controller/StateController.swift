//
//  StateController.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import Foundation

protocol StateControllerHandler {
    var stateController: StateController? { get set }
}

class StateController {
    
    //MARK: Properties
    
    lazy var gameBoard: GameBoard? = modelController.gameBoard
    
    var history: GameHistory? {
        return modelController.gameHistory
    }
    
    lazy var modelController: ModelController = ModelController()
    
    //MARK: Loading and saving
    
    func save() {
        modelController.saveModel(game: gameBoard, history: history)
    }
    
    func load(completion: @escaping ((Bool) -> Void)) {
        modelController.loadModel(completion: completion)
    }
    
    //MARK: Control model
    
    func finishedGame(gameBoard: GameBoard) {
        update(game: gameBoard)
        modelController.addGameToHistory(game: gameBoard)
        self.gameBoard = nil
    }
    
    func update(game: GameBoard) {
        gameBoard = game
    }
    
    func startNewGame(withColumns columns: Int, andRows rows: Int, playerNicknames nickNames: [String]) -> GameBoard? {
        gameBoard = GameBoard.startGame(withColumns: columns, andRows: rows, nickNames: nickNames)
        return gameBoard
    }
    
}
