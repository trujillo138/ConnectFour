//
//  GameHistoryDataSource.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/23/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import UIKit

class GameHistoryDataSource: NSObject, UITableViewDataSource {
    
    //MARK: Properties
    
    private var history: GameHistory?
    
    private var historyCellIdentififer = ""
    
    //MARK: Initializer
    
    init(gameHistory: GameHistory?, cellIdentifier: String) {
        history = gameHistory
        historyCellIdentififer = cellIdentifier
        super.init()
    }
    
    func updateHistory(history: GameHistory?) {
        self.history = history
    }
    
    //MARK: TableView Data source
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: historyCellIdentififer) as? GameHistoryTableViewCell,
                let game = history?.games[indexPath.row] else {
            return UITableViewCell()
        }
        let model = GameHistoryCellModel(game: game)
        model.setGameValues(inCell: cell)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history?.games.count ?? 0
    }
}
