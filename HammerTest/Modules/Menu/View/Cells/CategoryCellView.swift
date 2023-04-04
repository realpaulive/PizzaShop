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
    
    let categoryButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ category: String, isPressed: Bool = false) {
        categoryButton.configuration?.title = category
        categoryButton.configuration?.baseForegroundColor = .systemPink
        switch isPressed {
        case true:
            categoryButton.configuration = .tinted()
        case false:
            categoryButton.configuration = .bordered()
        }
    }
    
    private func layout() {
        contentView.addSubview(categoryButton)
        categoryButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
            make.width.equalTo(70)
        }
    }
}
