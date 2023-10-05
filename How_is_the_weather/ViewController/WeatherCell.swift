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
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    private lazy var weatheImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        
        [cityLabel, descriptionLabel].forEach {
            view.addArrangedSubview($0)
        }
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .equalCentering
        
        [vStackView, weatheImageView, temperatureLabel].forEach {
            view.addArrangedSubview($0)
        }
        weatheImageView.snp.makeConstraints {
            $0.trailing.equalTo(temperatureLabel.snp.leading).offset(-10)
        }
        return view
    }()
    
    func configure(type: TemperatureType, info: WeatherInfo?) {
        guard let info = info,
              let id = info.id,
              let description = info.description,
              let temperature = info.temperature else { return }
        cityLabel.text = info.city
        descriptionLabel.text = description
        switch type {
        case .celsius:
            temperatureLabel.text = "\(Int(round(temperature))) °C"
        case .fahrenheit:
            temperatureLabel.text = "\(Int(round(temperature))) °F"
        }
        let image = WeatherType(weatherID: id)?.getIcon
        weatheImageView.image = image
        contentView.backgroundColor = .clear
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
        contentView.addSubview(hStackView)
        
        hStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
