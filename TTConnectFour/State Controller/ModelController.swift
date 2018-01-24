//
//  ModelController.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import Foundation
import Firebase

class ModelController {
    
    //MARK: Properties
    
    var gameBoard: GameBoard?
    
    var gameHistory: GameHistory?
    
    var databaseReference: DatabaseReference!
    
    //MARK: Writing data
    
    func addGameToHistory(game: GameBoard) {
        gameHistory?.addGameToHistory(game: game)
    }
    
    //MARK: Model Loading and Saving
    
    func saveModel(game: GameBoard?, history: GameHistory?) {
        gameBoard = game
        gameHistory = history
    }
    
    func loadModel(completion: @escaping ((Bool) -> Void)) {
        refFireBaseDatabase()
        gameBoard = nil
        loadHistory(completion: completion)
    }
    
    private func loadHistory(completion: @escaping ((Bool) -> Void)) {
        
        databaseReference.child("games").observeSingleEvent(of: .value) { snapshot in
            var games = [GameBoard]()
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                self.gameHistory = GameHistory(games: games)
                completion(true)
                return
            }
            for child in children {
                guard let game = GameBoard.getGameFrom(firebaseChild: child.value) else {
                    continue
                }
                games.append(game)
            }
            self.gameHistory = GameHistory(games: games)
            completion(true)
        }
    }
    
    private func refFireBaseDatabase() {
        databaseReference = Database.database().reference()
    }
    
}
