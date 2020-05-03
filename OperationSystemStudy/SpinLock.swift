//
//  SpinLock.swift
//  OperationSystemStudy
//
//  Created by wentilin on 2020/5/3.
//  Copyright © 2020 wentilin. All rights reserved.
//

import Foundation

class SpinLock {
    private var value: Bool = false
    
    func lock() {
        while _testAndSet(value: &value) {
            
        }
    }
    
    func unlock() {
        value = false
    }
}

// cpu提供的原子性操作
private func _testAndSet(value: inout Bool) -> Bool {
    let old = value
    value = true
    return old
}

private func _exchange(value1: inout Bool, value2: inout Bool) {
    let temp = value1
    value1 = value2
    value2 = temp
}
