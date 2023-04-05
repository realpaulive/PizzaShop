//
//  CategoryCellView.swift
//  HammerTest
//
//  Created by Paul Ive on 03.04.23.
//

import UIKit
import SnapKit

final class CategoryCellView: UICollectionViewCell {
    
    static let identifier = "CategoryCellView"
    
    let categoryButton: UIButton = {
        let button = UIButton(type: .system)
        
        var configuration = UIButton.Configuration.plain()
        configuration = .plain()
        configuration.baseForegroundColor = .systemPink
        configuration.buttonSize = .small
        configuration.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        button.configuration = configuration
        button.layer.cornerRadius = 16
        button.layer.borderColor = .init(red: 0.99, green: 0.22, blue: 0.41, alpha: 1)
        button.layer.borderWidth = 1
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ category: String) {
        categoryButton.setTitle(category, for: .normal)
    }
    
    private func setUpView() {
        contentView.addSubview(categoryButton)
    }
    
    private func setUpConstraints() {
        categoryButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.width.equalTo(90)
        }
    }
}
