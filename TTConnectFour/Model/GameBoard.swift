//
//  BoardGame.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import Foundation

enum GameError: Error {
    case ColumnFull(message: String)
}

enum GameState {
    case inProgress
    case finished
}

struct GameBoard {
    
    //MARK: Properties
    
    var board: [[Chip?]]
    
    var columns: Int
    
    var rows: Int
    
    var players: [GamePlayer]
    
    var currentPlayer: GamePlayer
    
    var gameState: GameState
    
    private let winingAmount = 4
    
    //MARK: Initialization
    
    static func startGame(withColumns columns: Int, andRows rows: Int, nickNames: [String]) -> GameBoard {
        let board = [[Chip?]].init(repeating: [Chip?].init(repeating: nil, count: rows), count: columns)
        var players = [GamePlayer]()
        var playerNumber = 0
        for nickname in nickNames {
            playerNumber += 1
            players.append(GamePlayer(playerNumber: playerNumber, nickName: nickname))
        }
        return GameBoard(board: board, columns: columns, rows: rows, players : players)
    }
    
    init(board: [[Chip?]], columns: Int, rows: Int, players: [GamePlayer]) {
        self.board = board
        self.columns = columns
        self.rows = rows
        self.players = players
        self.currentPlayer = players[0]
        self.gameState = .inProgress
    }
    
    //MARK: Game
    
    //Returns the row where the chip fell for that column
    mutating func placeChip(atColumn column: Int) throws -> Int {
        guard board[column][rows - 1] == nil else {
            throw GameError.ColumnFull(message: "No more chips can be placed in that column")
        }
        currentPlayer.chipsPlayed += 1
        let row = placeChipInRow(forColumn: column)
        if checkIfPlayerWinsPlacingChip(inColumn: column, forRow: row) {
            finishGame()
        } else {
            moveToNextPlayer()
        }
        return row
    }
    
    private mutating func finishGame() {
        gameState = .finished
        players[currentPlayer.playerNumber - 1] = currentPlayer
        for (index, var player) in players.enumerated() {
            if player.playerNumber == currentPlayer.playerNumber {
                player.wonGame()
            } else {
                player.lostGame()
            }
            players[index] = player
        }
    }
    
    func didGameFinished() -> Bool {
        return gameState == .finished
    }
    
    private mutating func moveToNextPlayer() {
        players[currentPlayer.playerNumber - 1] = currentPlayer
        if currentPlayer.playerNumber == players.count {
            currentPlayer = players[0]
        } else {
            currentPlayer = players[currentPlayer.playerNumber]
        }
    }
    
    private mutating func placeChipInRow(forColumn column: Int) -> Int {
        var columnChips = board[column]
        for (index, chip) in columnChips.enumerated() {
            if chip == nil {
                columnChips[index] = Chip(playerNumber: currentPlayer.playerNumber)
                board[column] = columnChips
                return index
            }
        }
        return -1
    }
    
    private func checkIfPlayerWinsPlacingChip(inColumn column: Int, forRow row: Int) -> Bool {
        if checkIfPlayerWonHorizontally(inColumn: column, forRow: row) {
            return true
        } else if checkIfPlayerWonVertically(inColumn: column, forRow: row) {
            return true
        } else if checkIfPlayerWonInRightDiagonal(inColumn: column, forRow: row) {
            return true
        } else if checkIfPlayerWonInLeftDiagonal(inColumn: column, forRow: row) {
            return true
        }
        return false
    }
    
    private func checkIfPlayerWonHorizontally(inColumn column: Int, forRow row: Int) -> Bool {
        var numberOfPlayerChips = 1
        //Check left
        var i = column - 1
        while i >= 0 {
            guard let chip = board[i][row], chip.playerNumber == currentPlayer.playerNumber else {
                break
            }
            numberOfPlayerChips += 1
            i -= 1
        }
        //Check right
        i = column + 1
        while i < columns {
            guard let chip = board[i][row], chip.playerNumber == currentPlayer.playerNumber else {
                break
            }
            numberOfPlayerChips += 1
            i += 1
        }
        return numberOfPlayerChips >= winingAmount
    }
    
    private func checkIfPlayerWonVertically(inColumn column: Int, forRow row: Int) -> Bool {
        var numberOfPlayerChips = 1
        //Check left
        var  i = row - 1
        while i >= 0 {
            guard let chip = board[column][i], chip.playerNumber == currentPlayer.playerNumber else {
                break
            }
            numberOfPlayerChips += 1
            i -= 1
        }
        return numberOfPlayerChips >= winingAmount
    }
    
    private func checkIfPlayerWonInRightDiagonal(inColumn column: Int, forRow row: Int) -> Bool {
        var numberOfPlayerChips = 1
        //Check left
        var currentRow = row - 1
        var currentColumn = column - 1
        while currentRow >= 0 && currentColumn >= 0 {
            guard let chip = board[currentColumn][currentRow], chip.playerNumber == currentPlayer.playerNumber else {
                break
            }
            numberOfPlayerChips += 1
            currentColumn -= 1
            currentRow -= 1
        }
        //Check right
        currentColumn = column + 1
        currentRow = row + 1
        while currentColumn < columns && currentRow < rows {
            guard let chip = board[currentColumn][currentRow], chip.playerNumber == currentPlayer.playerNumber else {
                break
            }
            numberOfPlayerChips += 1
            currentColumn += 1
            currentRow += 1
        }
        return numberOfPlayerChips >= winingAmount
    }
    
    private func checkIfPlayerWonInLeftDiagonal(inColumn column: Int, forRow row: Int) -> Bool {
        var numberOfPlayerChips = 1
        //Check left
        var currentRow = row + 1
        var currentColumn = column - 1
        while currentRow < rows && currentColumn >= 0 {
            guard let chip = board[currentColumn][currentRow], chip.playerNumber == currentPlayer.playerNumber else {
                break
            }
            numberOfPlayerChips += 1
            currentColumn -= 1
            currentRow += 1
        }
        //Check right
        currentColumn = column + 1
        currentRow = row - 1
        while currentColumn < columns && currentRow >= 0 {
            guard let chip = board[currentColumn][currentRow], chip.playerNumber == currentPlayer.playerNumber else {
                break
            }
            numberOfPlayerChips += 1
            currentColumn += 1
            currentRow -= 1
        }
        return numberOfPlayerChips >= winingAmount
    }
    
}
