//
//  MainMenuViewCell.swift
//  HammerTest
//
//  Created by Paul Ive on 04.04.23.
//

import UIKit
import SnapKit

final class MainMenuViewCell: UICollectionViewCell {
    
    static let identifier = "MainMenuViewCell"
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.textColor = .label
        return nameLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 3
        
        return descriptionLabel
    }()
    
    private let priceButton: UIButton = {
        let button = UIButton(type: .system)
        
        var configuration = UIButton.Configuration.plain()
        configuration = .plain()
        configuration.baseForegroundColor = .systemPink
        configuration.buttonSize = .mini
        configuration.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        button.configuration = configuration
        button.layer.cornerRadius = 6
        button.layer.borderColor = .init(red: 0.99, green: 0.22, blue: 0.41, alpha: 1)
        button.layer.borderWidth = 1
        
        return button
    }()
    
    let divider: UIView = {
        let divider = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 1))
        divider.backgroundColor = .secondarySystemBackground
        return divider
    }()
    
    private let foodImage: UIImageView = {
        let foodImage = UIImageView()
        foodImage.clipsToBounds = true
        foodImage.layer.cornerRadius = 132 / 2
        foodImage.contentMode = .scaleToFill
        foodImage.backgroundColor = .none
        return foodImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withFood food: FoodElement) {
        nameLabel.text = food.name
        descriptionLabel.text = food.description
        priceButton.configuration?.title = "от " + String(food.price) + "₽ "
        foodImage.image = UIImage(named: "pizza")
    }
    
    private func setUpView() {
        contentView.addSubview(foodImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceButton)
        contentView.addSubview(divider)
    }
    
    private func setConstraints() {
        foodImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(24)
            make.leading.equalTo(contentView).offset(16)
            make.height.equalTo(132)
            make.width.equalTo(132)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(32)
            make.leading.equalTo(foodImage.snp.trailing).offset(32)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(foodImage.snp.trailing).offset(32)
            make.trailing.equalTo(contentView).offset(-16)
            make.bottom.equalTo(contentView).offset(-72)
        }
        
        priceButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-24)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.height.equalTo(32)
            make.width.equalTo(87)
        }
        
        divider.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.bottom.equalTo(contentView)
            make.height.equalTo(1)
        }
    }
}
