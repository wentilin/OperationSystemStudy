//
//  _BoundedBufferConditionImp.swift
//  OperationSystemStudy
//
//  Created by wentilin on 2020/5/5.
//  Copyright © 2020 wentilin. All rights reserved.
//

import Foundation

class _BoundedBufferConditionImp<C> {
    private let lock: NSLock
    private let notFull: NSCondition
    private let notEmpty: NSCondition
    private let capacity: Int
    private var count: Int
    private var buffers: [C] = []
    
    init(capacity: Int) {
        self.capacity = capacity
        count = 0
        lock = .init()
        notFull = .init()
        notEmpty = .init()
    }
        
    func deposite(_ item: C) {
        while count == capacity {
            notFull.wait()
        }
        
        lock.lock()
        
        buffers.append(item)
        count += 1
        notEmpty.signal()
        
        lock.unlock()
    }
    
    func remove() -> C {
        while count == 0 {
            notEmpty.wait()
        }
        
        lock.lock()
        
        let item = buffers.removeLast()
        count -= 1
        
        notFull.signal()
        
        lock.unlock()
        
        return item
    }
}
