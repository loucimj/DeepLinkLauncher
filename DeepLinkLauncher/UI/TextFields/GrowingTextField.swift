//
//  GrowingTextField.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 13/08/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class GrowingTextField: UIView {
    lazy var textView: UITextView = {
        let textView = UITextView(forAutoLayout: ())
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.textField
        textView.textColor = UIColor.textFieldTextColor
        return textView
    }()
    lazy var placeHolderLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.text = placeholderText
        label.font = UIFont.placeholder
        label.textColor = UIColor.placeholderText
        label.textAlignment = .left
        return label
    }()
    private var image: UIImage
    private var placeholderText: String
    private var textFieldHeightConstraint: NSLayoutConstraint?
    
    private lazy var containerView: UIView = {
        let view = UIView(forAutoLayout: ())
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.textFieldBackground
        return view
    }()
    private lazy var imageView: UIImageView = {
        let view = UIImageView(forAutoLayout: ())
        view.image = self.image
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    init(image: UIImage, placeholderText: String, defaultText: String) {
        self.image = image
        self.placeholderText = placeholderText
        super.init(frame: CGRect.zero)
        self.configureForAutoLayout()
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    private func setupViews() {
        containerView.addSubview(imageView)
        containerView.addSubview(placeHolderLabel)
        containerView.addSubview(textView)
        addSubview(containerView)

        imageView.autoSetDimensions(to: CGSize(width: 25, height: 25))
        imageView.autoPinEdge(.top, to: .top, of: containerView, withOffset: 12)
        imageView.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 16)

        placeHolderLabel.autoPinEdge(.leading, to: .trailing, of: imageView, withOffset: 16)
        placeHolderLabel.autoPinEdge(.top, to: .top, of: imageView, withOffset: -20)
        placeHolderLabel.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -12)
        placeHolderLabel.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: 8)

        textView.autoPinEdge(.top, to: .top, of: placeHolderLabel, withOffset: 22)
        textView.autoPinEdge(.leading, to: .leading, of: placeHolderLabel, withOffset: -4)
        textView.autoPinEdge(.trailing, to: .trailing, of: placeHolderLabel)
    
        textFieldHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 24)
        textFieldHeightConstraint?.isActive = true

        containerView.autoPinEdge(.bottom, to: .bottom, of: textView, withOffset: 12)
        containerView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}
