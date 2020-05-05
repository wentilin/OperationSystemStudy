//
//  BoundedBuffer.swift
//  OperationSystemStudy
//
//  Created by wentilin on 2020/5/5.
//  Copyright © 2020 wentilin. All rights reserved.
//

import Foundation

class BoundedBuffer<C> {
    private let mutex: DispatchSemaphore
    private let fullBuffers: DispatchSemaphore
    private let emptyBuffers: DispatchSemaphore
    private let capacity: Int
    
    private var buffers: [C] = []
    
    init(capacity: Int) {
        self.capacity = capacity
        mutex = .init(value: 1)
        fullBuffers = .init(value: 0)
        emptyBuffers = .init(value: capacity)
    }
    
    func deposite(_ item: C) {
        emptyBuffers.wait()
        
        mutex.wait()
        buffers.append(item)
        mutex.signal()
        
        fullBuffers.signal()
    }
    
    func remove() -> C {
        fullBuffers.wait()
        
        mutex.wait()
        let item = buffers.removeLast()
        mutex.signal()
        
        emptyBuffers.signal()
        return item
    }
}
