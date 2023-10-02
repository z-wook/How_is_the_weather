//
//  SearchView.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class SearchView: UIView {
    lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: "arrow.counterclockwise.circle"),
            for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "도시 또는 공항 검색"
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemCyan
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifier)
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .systemOrange
        view.hidesWhenStopped = true
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchView {
    func setLayout() {
        collectionView.addSubview(indicator)
        
        [reloadButton, searchBar, collectionView].forEach {
            self.addSubview($0)
        }
        
        indicator.snp.makeConstraints {
            $0.center.equalTo(collectionView)
        }
        
        reloadButton.snp.makeConstraints {
            $0.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.width.height.equalTo(50)
            $0.centerY.equalTo(searchBar)
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.trailing.equalTo(reloadButton.snp.leading)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(30)
            $0.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(100)
        }
    }
}
