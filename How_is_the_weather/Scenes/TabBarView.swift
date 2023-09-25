//
//  TabBarView.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class TabBarView: UIView {
    lazy var sunBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "sun.haze"), for: .normal)
        button.tintColor = .systemRed
        return button
    }()
    
    lazy var globalBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    private lazy var buttnoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 30
        
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 위치 (수평, 수직)
        stack.layer.shadowOpacity = 0.5 // 그림자 투명도
        stack.layer.shadowRadius = 10 // 그림자 반경
        
        [sunBtn, globalBtn].forEach {
            stack.addArrangedSubview($0)
        }
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabBarView {
    private func setLayout() {
        self.addSubview(buttnoStackView)
        
        buttnoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
