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
        textView.delegate = self
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
    private enum State {
        case waiting
        case writing
    }
    private var state: State {
        return textView.text.isEmpty ? .waiting : .writing
    }
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
        view.tintColor = UIColor.placeholderText
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
        placeHolderLabel.autoPinEdge(.top, to: .top, of: containerView, withOffset: -8)
        placeHolderLabel.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -12)
        placeHolderLabel.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: 8)

        textView.autoPinEdge(.top, to: .top, of: containerView, withOffset: 16)
        textView.autoPinEdge(.leading, to: .trailing, of: imageView, withOffset: 12)
        textView.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -12)
    
        textFieldHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 24)
        textFieldHeightConstraint?.isActive = true

        containerView.autoPinEdge(.bottom, to: .bottom, of: textView, withOffset: 12)
        containerView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    private func updateViewsStatus() {
        switch state {
        case .writing:
            placeHolderLabel.isHidden = true
        case .waiting:
            placeHolderLabel.isHidden = false
        }
    }
    private func updateHeightConstraint() {
        var size = CGSize.zero
        if state == .writing {
            size = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
            if size.height < 37 {
                size.height = 24
            }
        } else {
            size.height = 24
        }
        self.textFieldHeightConstraint?.constant = size.height
        self.layoutIfNeeded()
    }
}

extension GrowingTextField: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateViewsStatus()
        updateHeightConstraint()
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
