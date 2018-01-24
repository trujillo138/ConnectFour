//
//  GameBoard+Firebase.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/24/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import Foundation

extension GameBoard {
    static func getGameFrom(firebaseChild child: Any?) -> GameBoard? {
        guard let gameDict = child as? NSDictionary, let player1Dict = gameDict["player1"] as? NSDictionary,
                let player2Dict = gameDict["player2"] as? NSDictionary,
                let player1 = GamePlayer.getPlayerFrom(firebaseDictionary: player1Dict, playerNumber: 1),
                let player2 = GamePlayer.getPlayerFrom(firebaseDictionary: player2Dict, playerNumber: 2)
            else { return nil }
        let game = GameBoard(players: [player1, player2])
        return game
    }
}

extension GamePlayer {
    static func getPlayerFrom(firebaseDictionary: NSDictionary, playerNumber: Int) -> GamePlayer? {
        guard let nickname = firebaseDictionary["nickname"] as? String,
                let chipsPlayed = firebaseDictionary["chipsPlayed"] as? Int,
            let state = firebaseDictionary["state"] as? Int, let playerState = PlayerState(rawValue: state) else { return nil}
        var player = GamePlayer(playerNumber: playerNumber, nickName: nickname)
        player.chipsPlayed = chipsPlayed
        player.state = playerState
        return player
    }
}
