//
//  SearchView.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class SearchView: UIView {
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
        [searchBar, collectionView].forEach {
            self.addSubview($0)
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(30)
            $0.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(100)
        }
    }
}
