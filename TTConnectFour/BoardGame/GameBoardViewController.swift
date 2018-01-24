//
//  GameBoardViewController.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController, StateControllerHandler, BoardDelegate {
    
    //MARK: Properties
    
    var stateController: StateController?
    
    lazy var gameBoard: GameBoard? = stateController?.gameBoard
    
    private var player1Name = ""
    
    private var player2Name = ""
    
    private var numberOfRows = 6
    
    private let numberOfColumns = 7
    
    private var playersNicknames = [String]() {
        didSet {
            self.gameBoard = self.stateController?.startNewGame(withColumns: numberOfColumns, andRows: numberOfRows, playerNicknames: playersNicknames)
            self.board.startGame(withColumns: numberOfColumns, andRows: numberOfRows)
            self.determineButtonVisibility()
            self.showCurrentPlayer()
        }
    }
    
    //MARK: Outlets

    @IBOutlet private weak var player1Label: UILabel!
    
    @IBOutlet private weak var player2Label: UILabel!
    
    @IBOutlet private weak var board: Board! {
        didSet {
            board.delegate = self
        }
    }
    
    @IBOutlet private weak var startGameButton: UIButton!
    
    @IBOutlet private weak var buttonInstructions: UILabel!
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateProgress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineButtonVisibility()
    }
    
    private func determineButtonVisibility() {
        startGameButton.alpha = gameBoard == nil ? 1.0 : 0.0
        buttonInstructions.alpha = gameBoard == nil ? 0.0 : 1.0
    }
    
    //MARK: Game
    
    private func startNewGame() {
        askForPlayersNicknames()
    }
    
    private func updateProgress() {
        guard let game = gameBoard else {
            return
        }
        stateController?.update(game: game)
    }
    
    private func finishGame() {
        guard let playerName = gameBoard?.currentPlayer.nickName, let game = gameBoard else { return }
        showAlterWith(title: "Player Won!", message: "\(playerName) has won the match. Congratulations!")
        stateController?.finishedGame(gameBoard: game)
        gameBoard = stateController?.gameBoard
        determineButtonVisibility()
    }
    
    private func showCurrentPlayer() {
        guard let currentPlayerNickname = gameBoard?.currentPlayer.nickName else { return }
        if player1Label.text == currentPlayerNickname {
            player1Label.font = UIFont.boldSystemFont(ofSize: 25)
            player2Label.font = UIFont.systemFont(ofSize: 17)
        } else {
            player2Label.font = UIFont.boldSystemFont(ofSize: 25)
            player1Label.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    //MARK: Alerts
    
    private func askForPlayersNicknames() {
        var nickNames = [String]()
        let nickNameMessage = "Please enter your nicknmake"
        let alertControllerPlayer1 = UIAlertController(title: "Player 1", message: nickNameMessage, preferredStyle: .alert)
        alertControllerPlayer1.addTextField(configurationHandler: nil)
        alertControllerPlayer1.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            guard let firstNickname = alertControllerPlayer1.textFields?.first?.text, firstNickname != "" else {
                self.showAlterWith(title: "Uncomplete information", message: "You must enter at least one character")
                return
            }
            nickNames.append(firstNickname)
            alertControllerPlayer1.dismiss(animated: true, completion: nil)
            let alertControllerPlayer2 = UIAlertController(title: "Player 2", message: nickNameMessage, preferredStyle: .alert)
            alertControllerPlayer2.addTextField(configurationHandler: nil)
            alertControllerPlayer2.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
                guard let secondNickName = alertControllerPlayer2.textFields?.first?.text, secondNickName != "" else {
                    self.showAlterWith(title: "Uncomplete information", message: "You must enter at least one character")
                    return
                }
                nickNames.append(secondNickName)
                alertControllerPlayer2.dismiss(animated: true, completion: nil)
                self.player1Label.text = firstNickname
                self.player2Label.text = secondNickName
                self.playersNicknames = nickNames
            }))
            self.present(alertControllerPlayer2, animated: true, completion: nil)
        }))
        present(alertControllerPlayer1, animated: true, completion: nil)
    }
    
    private func showAlterWith(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Actions
    
    @IBAction private func tappedStartGameButton(_ sender: Any) {
        startNewGame()
    }
    
    //MARK: Board delegate
    
    func placeChipInColumn(column: Int) -> Int? {
        do {
            let row = try gameBoard?.placeChip(atColumn: column)
            if gameBoard?.didGameFinished() == true {
                finishGame()
            }
            showCurrentPlayer()
            return row
        } catch GameError.ColumnFull(let message) {
            showAlterWith(title: "Column full", message: message)
        } catch {
            showAlterWith(title: "Unknow error", message: "An unknown error ocurred, please try again")
        }
        return nil
    }

}
