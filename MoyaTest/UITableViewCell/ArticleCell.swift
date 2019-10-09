//
//  ArticleCell.swift
//  MoyaTest
//
//  Created by 肖 怡豪 on 2019/10/08.
//  Copyright © 2019 肖 怡豪. All rights reserved.
//

import Foundation
import UIKit

class ArticleCell: UITableViewCell {
    var iconView: UIImageView!
    var titleView: UIView!
    var titleLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear
        configureSubviews()
        addSubviews()
        addConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(cellData: CellData) {
        iconView.image = UIImage(url: cellData.thumbnail)
        titleLabel.text = cellData.title
    }

    func addSubviews() {
        contentView.addSubview(iconView)
        contentView.addSubview(titleView)
        titleView.addSubview(titleLabel)
    }
    
    func configureSubviews() {
        
        iconView = UIImageView()
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        iconView.contentMode = .scaleToFill

        titleView = UIView()
        titleView.backgroundColor = .white
        titleView.clipsToBounds = true
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
    }

    func addConstraints() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 160),
            iconView.heightAnchor.constraint(equalToConstant: 120),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleView.topAnchor.constraint(equalTo: iconView.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -10),
        ])
    }
}

