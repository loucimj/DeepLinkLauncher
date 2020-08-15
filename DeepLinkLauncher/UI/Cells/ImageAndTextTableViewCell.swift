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

class ImageAndTextTableViewCell: UITableViewCell, Reusable {
    
    lazy var cellImageView: UIImageView = {
        let view = UIImageView(forAutoLayout: ())
        view.contentMode = .scaleAspectFill
        return view
    }()
    lazy var cellTitleLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.font = UIFont.cellTitle
        label.textColor = UIColor.textFieldTextColor
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews() {
        addSubview(cellImageView)
        addSubview(cellTitleLabel)
        cellImageView.autoSetDimensions(to: CGSize(width: 25, height: 25))
        cellImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 4)
        cellImageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 17)
        
        cellTitleLabel.autoPinEdge(.leading, to: .trailing, of: cellImageView, withOffset: 16)
        cellTitleLabel.autoPinEdge(.top, to: .top, of: cellImageView, withOffset: 2)
        cellTitleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: -12)
    }
    func configure(with item: ImageAndTextTableViewCellRepresentable) {
        cellImageView.image = item.cellImage
        cellTitleLabel.text = item.cellTitle
    }
}
