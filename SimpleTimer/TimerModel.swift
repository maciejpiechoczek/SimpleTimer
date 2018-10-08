//
//  TimerModel.swift
//  SimpleTimer
//
//  Created by Maciej Piechoczek on 04/10/2018.
//  Copyright © 2018 McPie. All rights reserved.
//

import Foundation

public typealias Seconds = UInt
public typealias Centiseconds = UInt

struct TimerModel {
    var timeUnit = "sec"
    var timeSet: Seconds = 2
    var isRunning = false
}
