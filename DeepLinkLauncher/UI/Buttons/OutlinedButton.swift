//
//  OutlinedButton.swift
//  DeepLinkLauncher
//
//  Created by Javier Loucim on 13/08/2020.
//  Copyright © 2020 Javier Loucim. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class OutlinedButton: UIView {
    
    enum Style {
        case normal
        case destructive
        
        var color: UIColor {
            switch self {
            case .normal:
                return UIColor.accent
            case .destructive:
                return UIColor.destructive
            }
        }
    }
    
    private lazy var buttonView: UIView = {
        let view = UIView(forAutoLayout: ())
        view.layer.cornerRadius = 8
        view.layer.borderColor = self.style.color.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    private lazy var labelView: UIView = {
        let label = UILabel()
        label.text = self.text
        label.textColor = self.style.color
        label.textAlignment = .center
        label.font = UIFont.button
        return label
    }()
    private var callback: (()->())
    private var text: String
    private var style: Style
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    init(text: String, style: Style = .normal, callback: @escaping ()->() ) {
        self.text = text
        self.callback = callback
        self.style = style
        super.init(frame: CGRect.zero)
        self.configureForAutoLayout()
        setupViews()
        setupActions()
    }
    
    private func setupViews() {
        buttonView.addSubview(labelView)
        addSubview(buttonView)
        labelView.autoPinEdgesToSuperviewEdges()
        buttonView.autoPinEdgesToSuperviewEdges()
        self.autoSetDimension(.height, toSize: 52)
    }
    private func setupActions() {
        labelView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(triggerAction)))
    }
    @objc private func triggerAction() {
        callback()
    }
}
