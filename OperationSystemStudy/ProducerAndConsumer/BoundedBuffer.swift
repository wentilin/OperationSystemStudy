//
//  BoundedBuffer.swift
//  OperationSystemStudy
//
//  Created by wentilin on 2020/5/5.
//  Copyright © 2020 wentilin. All rights reserved.
//

import Foundation

class BoundedBuffer<C> {
    private let _boundedBufferImp: _BoundedBufferConditionImp<C>
    
    init(capacity: Int) {
        _boundedBufferImp = .init(capacity: capacity)
    }
    
    func deposite(_ item: C) {
        _boundedBufferImp.deposite(item)
    }
    
    func remove() -> C {
        return _boundedBufferImp.remove()
    }
}
