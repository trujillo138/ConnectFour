//
//  Player.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import Foundation

enum PlayerState {
    case Won
    case Lost
    case Playing
}

struct GamePlayer {
    
    //MARK: Properties
    
    var playerNumber: Int
    
    var chipsPlayed: Int
    
    var state: PlayerState
    
    var nickName: String
    
    //MARK: Initializer
    
    init(playerNumber: Int, nickName: String) {
        self.playerNumber = playerNumber
        self.chipsPlayed = 0
        self.nickName = nickName
        self.state = .Playing
    }
    
    //MARK: Game
    
    mutating func increaseChipsPlayed() {
        chipsPlayed += 1
    }
    
    mutating func lostGame() {
        state = .Lost
    }
    
    mutating func wonGame() {
        state = .Won
    }
    
}
