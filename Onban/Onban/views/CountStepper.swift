//
//  CountStepper.swift
//  Onban
//
//  Created by lauren.c on 2022/02/10.
//

import UIKit

protocol CountStepperDelegate {
    func didButtonUpTouched(_ self: CountStepper)
    func didButtonDownTouched(_ self: CountStepper)
}

class CountStepper: UIView {
    var count = 1
    var delegate: CountStepperDelegate?
    
    let label: UILabel = {
        let view = UILabel()
        view.font = defaultFont(.sansLight, size: 16)
        view.textAlignment = .center
        view.layer.borderWidth = 0.5
        view.layer.borderColor = defaultColor(.lightGray)?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buttonUp: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "button_up")
        button.setImage(image, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = defaultColor(.lightGray)?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buttonDown: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "button_down")
        button.setImage(image, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = defaultColor(.lightGray)?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
        label.text = String(count)
    }
    
    private func setupView() {
        addSubview(label)
        addSubview(buttonUp)
        addSubview(buttonDown)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            buttonUp.topAnchor.constraint(equalTo: label.topAnchor),
            buttonUp.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            buttonUp.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonUp.heightAnchor.constraint(equalTo: label.heightAnchor, multiplier: 0.5),
            buttonUp.widthAnchor.constraint(equalTo: label.widthAnchor, multiplier: 0.4),
            buttonDown.topAnchor.constraint(equalTo: buttonUp.bottomAnchor),
            buttonDown.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonDown.leadingAnchor.constraint(equalTo: buttonUp.leadingAnchor),
            buttonDown.heightAnchor.constraint(equalTo: label.heightAnchor, multiplier: 0.5)
        ])
        buttonUp.addTarget(self, action: #selector(buttonUpTouched), for: .touchUpInside)
        buttonDown.addTarget(self, action: #selector(buttonDownTouched), for: .touchUpInside)
    }
    
    @objc func buttonUpTouched() {
        count += 1
        label.text = String(count)
        delegate?.didButtonUpTouched(self)
    }
    @objc func buttonDownTouched() {
        guard count > 1 else {
            return
        }
        count -= 1
        label.text = String(count)
        delegate?.didButtonDownTouched(self)
    }
}
