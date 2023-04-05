//
//  BannerCellView.swift
//  HammerTest
//
//  Created by Paul Ive on 03.04.23.
//

import UIKit
import SnapKit

final class BannerCellView: UICollectionViewCell {
    
    static let identifier = "BannerCellView"
    
    private var bannerImageView: UIImageView = {
        let bannerImageView = UIImageView()
        bannerImageView.contentMode = .scaleToFill
        return bannerImageView
    }()
    
    func setUpCell(whithImage image: UIImage) {
        bannerImageView.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.contentView.addSubview(bannerImageView)
    }
    
    private func setConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
    }
}
