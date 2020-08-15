//
//  ImageAndTextCell.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 15/08/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

protocol ImageAndTextTableViewCellRepresentable {
    var cellImage: UIImage { get }
    var cellTitle: String { get }
}

class ImageAndTextTableViewCell: UITableViewCell {
    
    lazy var cellImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        
    }
    func configure(with: ImageAndTextTableViewCellRepresentable) {
        
    }
}
