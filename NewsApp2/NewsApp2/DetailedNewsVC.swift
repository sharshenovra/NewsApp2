//
//  DetailedNewsVC.swift
//  NewsApp2
//
//  Created by Ruslan Sharshenov on 09.12.2021.
//

import Foundation
import SnapKit

class DetailedNewsVC: UIViewController {

    var firstView = UIView()
    var DetailedTitle = UILabel()
    var DetailedDescription = UILabel()
    var DetailedPhoto = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        view.addSubview(firstView)
        firstView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        firstView.addSubview(DetailedTitle)
        DetailedTitle.numberOfLines = 0
        DetailedTitle.adjustsFontSizeToFitWidth = true
        DetailedTitle.snp.makeConstraints {make in
            DetailedTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(30)
        }
        DetailedTitle.addSubview(DetailedDescription)
        DetailedDescription.numberOfLines = 0
        DetailedDescription.adjustsFontSizeToFitWidth = true
        DetailedDescription.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        DetailedDescription.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(DetailedTitle.snp.bottom).offset(30)
        }
        DetailedDescription.addSubview(DetailedPhoto)
        DetailedPhoto.layer.cornerRadius = 10
        DetailedPhoto.clipsToBounds = true
        DetailedPhoto.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.left.equalToSuperview()
            make.top.equalTo(DetailedDescription.snp.bottom).offset(20)
        }
        
    }
    
}
