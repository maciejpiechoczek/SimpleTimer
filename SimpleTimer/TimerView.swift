//
//  TimerView.swift
//  SimpleTimer
//
//  Created by Maciej Piechoczek on 04/10/2018.
//  Copyright © 2018 McPie. All rights reserved.
//

import UIKit

class TimerView: UIView {

    var startStopAction: (() -> Void)?
    var valueChangedAction: ((Knob) -> Void)?
    
    let knob: Knob = {
        let knob = Knob(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        knob.trackBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3000000119)
        knob.tintColor = #colorLiteral(red: 0.9330000281, green: 0.6750000119, blue: 0.3689999878, alpha: 1)
        knob.fretColor = #colorLiteral(red: 0.8590000272, green: 0.4160000086, blue: 0.3919999897, alpha: 1)
        knob.sliderWidth = 44
        knob.pointerWidth = 16
        knob.pointerLength = 50
        knob.fretWidth = 6
        knob.fretLength = 38
        
        knob.setValue(6)
        
        return knob
    }()
    
    let timeLabel: UILabel = {
        let timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        timeLabel.isUserInteractionEnabled = false
        timeLabel.textColor = .white
        timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 62.0, weight: .bold)
        return timeLabel
    }()
    
    let timeUnitLabel: UILabel = {
        let timeUnitLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        timeUnitLabel.isUserInteractionEnabled = false
        timeUnitLabel.textColor = .white
        timeUnitLabel.font = UIFont.systemFont(ofSize: 17.0)
        return timeUnitLabel
    }()
    
    let startStopButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
        button.setTitleColor(.clear, for: .highlighted)
        button.backgroundColor = #colorLiteral(red: 0.9330000281, green: 0.6750000119, blue: 0.3689999878, alpha: 1)
        button.layer.cornerRadius = 2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = #colorLiteral(red: 0.8590000272, green: 0.4160000086, blue: 0.3919999897, alpha: 1)
        setupViews()
        setupConstraints()
        addActions()
    }
    
    func setupViews() {
        addSubview(knob)
        addSubview(timeLabel)
        addSubview(timeUnitLabel)
        addSubview(startStopButton)
    }
    
    func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        setupKnobConstraints()
        setupTimeLabelConstraints()
        setupUnitLabelConstraints()
        setupButtonConstraints()
    }
    
    func addActions() {
        startStopButton.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        knob.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    @objc func toggleButton() {
        startStopAction?()
    }
    
    @objc func valueChanged(_ sender: Any) {
        guard let knob = sender as? Knob else { return }
        valueChangedAction?(knob)
    }
    
    private func setupKnobConstraints() {
        knob.translatesAutoresizingMaskIntoConstraints = false
        
        knob.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        knob.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 54).isActive = true
        knob.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        knob.heightAnchor.constraint(equalTo: knob.widthAnchor, multiplier: 1.0).isActive = true
    }
    
    private func setupTimeLabelConstraints() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.centerXAnchor.constraint(equalTo: knob.centerXAnchor, constant: 0).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: knob.centerYAnchor, constant: 0).isActive = true
    }
    
    private func setupUnitLabelConstraints() {
        timeUnitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeUnitLabel.leftAnchor.constraint(equalTo: timeLabel.rightAnchor).isActive = true
        timeUnitLabel.lastBaselineAnchor.constraint(equalTo: timeLabel.lastBaselineAnchor).isActive = true
    }
    
    private func setupButtonConstraints() {
        startStopButton.translatesAutoresizingMaskIntoConstraints = false
        
        startStopButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        startStopButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        startStopButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        startStopButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
