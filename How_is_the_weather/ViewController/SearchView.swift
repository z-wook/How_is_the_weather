//
//  SearchView.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class SearchView: UIView {
    lazy var changeUnitBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: "arrow.left.arrow.right"),
            for: .normal)
        button.tintColor = .darkGray
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "도시 검색"
        view.backgroundColor = .clear
        view.backgroundImage = UIImage()
        view.searchTextField.layer.cornerRadius = 10
        view.searchTextField.layer.borderWidth = 2
        view.searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.gray
    ]
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        let attributedTitle = NSAttributedString(string: "당겨서 새로고침", attributes: attributes)
        refresh.attributedTitle = attributedTitle
        return refresh
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifier)
        view.layer.cornerRadius = 30
        view.refreshControl = refreshControl
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
        [changeUnitBtn, searchBar, collectionView].forEach {
            self.addSubview($0)
        }
        
        changeUnitBtn.snp.makeConstraints {
            $0.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.width.height.equalTo(50)
            $0.centerY.equalTo(searchBar)
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.trailing.equalTo(changeUnitBtn.snp.leading)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(30)
            $0.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(100)
        }
    }
}
