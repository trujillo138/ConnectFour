//
//  GameHistoryViewController.swift
//  TTConnectFour
//
//  Created by Tomas Trujillo on 1/22/18.
//  Copyright © 2018 TOMApps. All rights reserved.
//

import UIKit

class GameHistoryViewController: UIViewController, StateControllerHandler, UITableViewDelegate {
    
    //MARK: Properties
    
    var stateController: StateController?
    
    var dataSource: GameHistoryDataSource?
    
    let historyCellIdentifier = "GameHistoryTableViewCell"
    
    //MARK: Outlets
    
    @IBOutlet private weak var historyTableView: UITableView!
    
    //MARK: Viewcontroller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = GameHistoryDataSource(gameHistory: stateController?.history, cellIdentifier: historyCellIdentifier)
        historyTableView.register(UINib.init(nibName: "GameHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: historyCellIdentifier)
        historyTableView.delegate = self
        historyTableView.dataSource = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource?.updateHistory(history: stateController?.history)
        historyTableView.reloadData()
    }
    
    //MARK: TableviewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
