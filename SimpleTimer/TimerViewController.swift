//
//  TimerViewController.swift
//  SimpleTimer
//
//  Created by Maciej Piechoczek on 04/10/2018.
//  Copyright © 2018 McPie. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    let presenter: TimerViewPresenter // Protocol maybe?
    var mainView: TimerView { return view as! TimerView } // Force unwrapping! Protocol maybe?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return presenter.isRunning ? .lightContent : .default
    }
    
    init(with presenter: TimerViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = TimerView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.startStopAction = { [weak self] in self?.startStopAction() }
        mainView.valueChangedAction = { [weak self] sender in self?.valueChangedAction(sender) }
        presenter.updateStateAction = { [weak self] in self?.updateState() }
        presenter.refreshAction = { [weak self] time, percentage in self?.update(with: time, and: percentage) }
        presenter.finishedAction = { [weak self] time in self?.flashScreenAndUpdate(with: time) }
        
        mainView.knob.setValue(presenter.timeInSeconds)
        
        mainView.timeLabel.text = presenter.timeString
        mainView.timeUnitLabel.text = presenter.timeUnit
        mainView.startStopButton.setTitle(presenter.startStopButtonTitle, for: .normal)
    }
    
    private func startStopAction() {
        presenter.toggleTimer()
    }
    
    private func valueChangedAction(_ sender: Knob) {
        presenter.updateModelWith(sender.value)
    }
    
    private func updateState() {
        mainView.startStopButton.isEnabled = false
        mainView.knob.isEnabled = false
        
        UIView.animate(withDuration: 0.1, animations: {
            
            self.mainView.timeLabel.text = self.presenter.timeString
            self.mainView.knob.setValue(self.presenter.timeInSeconds)
            
            self.mainView.startStopButton.setTitle(self.presenter.startStopButtonTitle, for: .normal)
            self.mainView.startStopButton.backgroundColor = self.presenter.startStopButtonColor
            
            self.mainView.backgroundColor = self.presenter.backgroundColor
            self.mainView.knob.tintColor = self.presenter.knobColor
            self.mainView.knob.fretColor = self.presenter.backgroundColor
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: { completed in
            self.mainView.startStopButton.isEnabled = true
            self.mainView.knob.isEnabled = !self.presenter.isRunning
        })
    }
    
    private func update(with time: String, and percentage: Double) {
        mainView.timeLabel.text = time
        mainView.knob.setPercentage(percentage)
    }
    
    private func flashScreenAndUpdate(with time: String) {
        mainView.timeLabel.text = time
        mainView.startStopButton.isEnabled = false

        UIView.animate(withDuration: 0.2, animations: {
            self.mainView.startStopButton.backgroundColor = self.presenter.flashColor
            self.mainView.backgroundColor = self.presenter.flashColor
            self.mainView.knob.tintColor = self.presenter.flashColor
            self.mainView.knob.fretColor = self.presenter.flashColor
        }, completion: { completed in
            self.presenter.toggleTimer()
        })
    }
}
