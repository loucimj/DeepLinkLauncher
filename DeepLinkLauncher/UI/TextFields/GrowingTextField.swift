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
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.returnKeyType = UIReturnKeyType.go
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
    private var textFieldTopConstraint: NSLayoutConstraint?
    
    private enum State {
        case waiting
        case writing
    }
    private var isMultilineText: Bool {
        (textFieldHeightConstraint?.constant ?? 24) > 24
    }
    private var state: State {
        return textView.text.isEmpty ? .waiting : .writing
    }
    var text: String? {
        textView.text
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
        placeHolderLabel.autoPinEdge(.top, to: .top, of: imageView, withOffset: 2)
        placeHolderLabel.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -12)

        textView.autoPinEdge(.leading, to: .trailing, of: imageView, withOffset: 12)
        textView.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -12)
    
        textFieldHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 24)
        textFieldHeightConstraint?.isActive = true
        textFieldTopConstraint = textView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16)
        textFieldTopConstraint?.isActive = true
        
        containerView.bottomAnchor.constraint(greaterThanOrEqualTo: textView.bottomAnchor, constant: 12).isActive = true
        containerView.bottomAnchor.constraint(greaterThanOrEqualTo: placeHolderLabel.bottomAnchor, constant: 18).isActive = true
        containerView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    private func updateViewsStatus() {
        switch state {
        case .writing:
            placeHolderLabel.alpha = 0
            self.textFieldTopConstraint?.constant = isMultilineText ? 4 : 12
            self.layoutIfNeeded()
        case .waiting:
            placeHolderLabel.alpha = 1
            self.textFieldTopConstraint?.constant = 16
            self.layoutIfNeeded()
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
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
}
