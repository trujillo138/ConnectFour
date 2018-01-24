//
//  GameHistory.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import Foundation

struct GameHistory {
    
    //MARK: GameHistory
    
    var games: [GameBoard]
    
    //MARK: Game
    
    mutating func addGameToHistory(game: GameBoard) {
        games.append(game)
    }
    
}
