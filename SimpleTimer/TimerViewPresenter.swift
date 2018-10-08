//
//  TimerViewPresenter.swift
//  SimpleTimer
//
//  Created by Maciej Piechoczek on 04/10/2018.
//  Copyright © 2018 McPie. All rights reserved.
//

import UIKit

class TimerViewPresenter {
    
    private var model = TimerModel()
    private var currentTime: Centiseconds = 0
    private var timer = Timer()
    
    var updateStateAction: (() -> Void)?
    var refreshAction: ((String, Double) -> Void)?
    var finishedAction: ((String) -> Void)?
    
    var isRunning: Bool {
        return model.isRunning
    }
    
    var timeInSeconds: UInt {
        return model.timeSet
    }
    
    var timeString: String {
        return stringFor(model.timeSet * 100)
    }
    
    var timeUnit: String {
        return model.timeUnit
    }
    
    var startStopButtonTitle: String {
        return model.isRunning ? "STOP" : "START"
    }
    
    var startStopButtonColor: UIColor {
        return model.isRunning ? #colorLiteral(red: 0.8590000272, green: 0.4160000086, blue: 0.3919999897, alpha: 1) : #colorLiteral(red: 0.9330000281, green: 0.6750000119, blue: 0.3689999878, alpha: 1)
    }

    var backgroundColor: UIColor {
        return model.isRunning ? #colorLiteral(red: 0.1609999985, green: 0.2080000043, blue: 0.2709999979, alpha: 1) : #colorLiteral(red: 0.8590000272, green: 0.4160000086, blue: 0.3919999897, alpha: 1)
    }
    
    var knobColor: UIColor {
        return #colorLiteral(red: 0.9330000281, green: 0.6750000119, blue: 0.3689999878, alpha: 1)
    }
    
    var flashColor: UIColor {
        return .white
    }
    
    func updateModelWith(_ newTime: Seconds) {
        guard newTime <= 12 else { return }
        
        model.timeSet = newTime
        updateStateAction?()
    }

    func toggleTimer() {
        model.isRunning = !model.isRunning
        
        if model.isRunning {
            currentTime = model.timeSet * 100
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(processTimer), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
        }
        updateStateAction?()
    }
    
    @objc func processTimer() {
        if currentTime > 0 {
            currentTime -= 1
            refreshAction?(stringFor(currentTime), percentageFor(currentTime))
        } else {
            timer.invalidate()
            finishedAction?(stringFor(currentTime))
        }
    }
    
    private func stringFor(_ timeInterval: Centiseconds) -> String {
        let seconds = timeInterval / 100
        let centiseconds = timeInterval % 100
        
        return String(format: "%02d:%02d", seconds, centiseconds)
    }
    
    private func percentageFor(_ timeInterval: Centiseconds) -> Double {
        return Double(timeInterval) / Double(12 * 100)
    }
}
