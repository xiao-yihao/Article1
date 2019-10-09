//
//  ViewController.swift
//  MoyaTest
//
//  Created by 肖 怡豪 on 2019/10/03.
//  Copyright © 2019 肖 怡豪. All rights reserved.
//

import UIKit
import Moya
import RxMoya
import RxSwift
import SwiftyJSON


let articleProvider = MoyaProvider<ArticleService>()

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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let videoCell = cell as? MoviePlayerCell else { return };
        videoCell.playerView.player?.pause();
        videoCell.thumbnailImageView.isHidden = false
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
        tableView.backgroundColor = .systemGray5
              
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

        articleProvider.rx.request(.articles).subscribe { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .success(let response):
                let data = response.data
                let resultEntity = try? JSONDecoder().decode(ResultEntity.self, from: data)
                self.applyData(resultEntity: resultEntity)
                self.tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
                break
                
            }

        }.disposed(by: disposeBag)
        
    }
    
    func applyData(resultEntity: ResultEntity?) {
        self.dataSource = resultEntity?.data.compactMap({ (item) -> CellData in
            return CellData(item: item)
        }) ?? []
    }
}
