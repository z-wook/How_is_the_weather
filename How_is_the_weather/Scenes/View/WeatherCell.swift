//
//  WeatherCell.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class WeatherCell: UICollectionViewCell {
    static let identifier = "WeatherCell"
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 위치"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "30 ℃"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    func configure() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WeatherCell {
    func setLayout() {
        [cityLabel, temperatureLabel].forEach {
            contentView.addSubview($0)
        }
        
        cityLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(16)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(-16)
        }
    }
}
