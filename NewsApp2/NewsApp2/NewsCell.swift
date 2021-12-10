//
//  NewsCell.swift
//  NewsApp2
//
//  Created by Ruslan Sharshenov on 08.12.2021.
//

import UIKit
import SnapKit

class NewsCell: UITableViewCell {
    
    var newsTitle = UILabel()
    var newsDescriptions = UILabel()
    var newsImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(newsTitle)
        newsTitle.snp.makeConstraints {make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(frame.height)
        }
        newsTitle.addSubview(newsDescriptions)
        newsDescriptions.snp.makeConstraints{make in
            make.top.equalTo(newsTitle.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview()
            make.height.equalTo(frame.height)
        }
        newsDescriptions.addSubview(newsImage)
        newsImage.snp.makeConstraints{ make in
            make.top.equalTo(newsTitle.snp.bottom).offset(20)
        }
        configureImageView()
        configureNewsTitle()
        configureNewsDescriptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        newsImage.layer.cornerRadius = 10
        newsImage.clipsToBounds = true
    }
    func configureNewsTitle() {
        newsTitle.numberOfLines = 0
        newsTitle.adjustsFontSizeToFitWidth = true
        newsTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    func configureNewsDescriptions() {
        newsDescriptions.numberOfLines = 0
        newsDescriptions.adjustsFontSizeToFitWidth = true
        newsDescriptions.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    }
