//
//  ViewController.swift
//  MoyaTest
//
//  Created by 肖 怡豪 on 2019/10/03.
//  Copyright © 2019 肖 怡豪. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    let tableView = UITableView()
    var dataSource: [CellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubViews()
        configueSubViews()
        addConstraints()
        requestAPI()
    }
}

private extension ViewController {
    func configueSubViews() {
        tableView.registerCell(type: MoviePlayerCell.self)
        tableView.registerCell(type: ArticleCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .groupTableViewBackground
    }
    
    func addSubViews() {
        view.addSubview(tableView)
    }
    
    func addConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func requestAPI() {
        ArticleService().articlesList { [weak self] (resultEntity, error) in
            guard let self = self else { return }
            if let _ = error {
                // エラー処理
            } else {
                self.applyData(resultEntity: resultEntity)
                self.tableView.reloadData()
            }
        }
    }
    
    func applyData(resultEntity: ResultEntity?) {
        self.dataSource = resultEntity?.data.compactMap({ (item) -> CellData in
            return CellData(item: item)
        }) ?? []
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellData = dataSource[safe: indexPath.row] else { return UITableViewCell() }
        if cellData.type == "movies" {
            let cell = tableView.dequeueCell(type: MoviePlayerCell.self, for: indexPath)
            cell.set(cellData: cellData)
            return cell
        } else {
            let cell = tableView.dequeueCell(type: ArticleCell.self, for: indexPath)
            cell.set(cellData: cellData)
            return cell
        }

    }
}
