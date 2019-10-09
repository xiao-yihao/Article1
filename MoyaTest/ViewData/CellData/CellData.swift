//
//  CellData.swift
//  MoyaTest
//
//  Created by 肖 怡豪 on 2019/10/09.
//  Copyright © 2019 肖 怡豪. All rights reserved.
//

struct CellData {
    var type: String
    var movieName: String?
    var title: String
    var thumbnail: String
    
    init(item: Item) {
        self.type = item.type
        self.movieName = item.article.movie_cook_name
        self.title = item.article.title
        self.thumbnail = item.article.icon ?? ""
    }
}
