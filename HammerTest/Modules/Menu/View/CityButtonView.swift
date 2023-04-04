//
//  CityButton.swift
//  HammerTest
//
//  Created by Paul Ive on 03.04.23.
//

import Foundation
import UIKit
import SnapKit

extension MenuViewController {
    func createCuntomBarButtonItem (city: String, selector: Selector) -> UIBarButtonItem {
        
        var container = AttributeContainer()
        container.font = .systemFont(ofSize: 17, weight: .medium)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString(city, attributes: container)
        configuration.titleAlignment = .leading
        configuration.image = UIImage(systemName: "chevron.down")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8
        configuration.preferredSymbolConfigurationForImage = .init(pointSize: 14, weight: .medium)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        configuration.baseForegroundColor = .label

        
        let button = UIButton(type: .system)
        button.configuration = configuration
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        
        return barButtonItem
    }
}

