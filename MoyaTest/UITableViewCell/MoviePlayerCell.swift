//
//  MoviePlayerCell.swift
//  MoyaTest
//
//  Created by 肖 怡豪 on 2019/10/08.
//  Copyright © 2019 肖 怡豪. All rights reserved.
//

import UIKit
import AVKit

class MoviePlayerCell: UITableViewCell {
    var thumbnailImageView = UIImageView()
    var titleLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear
        
        addSubviews()
        configureSubviews()
        addConstraints()
    }

    func set(cellData: CellData) {
        thumbnailImageView.image = UIImage(url: cellData.thumbnail)
        titleLabel.text = cellData.movieName
    }

    func addSubviews() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
    }

    func configureSubviews() {
        titleLabel.textColor = .white
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20)
        
        thumbnailImageView.clipsToBounds = true
    }
    
    func addConstraints() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -30)
        ])
    }
    
}

