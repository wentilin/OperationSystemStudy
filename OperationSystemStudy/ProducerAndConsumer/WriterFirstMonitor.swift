//
//  Monitor.swift
//  OperationSystemStudy
//
//  Created by wentilin on 2020/5/5.
//  Copyright © 2020 wentilin. All rights reserved.
//

import Foundation

class WriterFirstMonitor {
    private var activeReaders: Int = 0
    private var activeWriters: Int = 0
    private var waitingReaders: Int = 0
    private var waitingWriters: Int = 0
    
    private let okToReadCondition: NSCondition
    private let okToWriteCondition: NSCondition
    
    private let lock: NSLock
    
    private var value: Int = 0
    
    init() {
        okToReadCondition = .init()
        okToWriteCondition = .init()
        lock = .init()
    }
    
    func read() -> Int {
        startRead()
        
        let item = value
        
        endRead()
        
        return item
    }
    
    func write(_ value: Int) {
        startWrite()
        
        self.value = value
        
        endWrite()
    }
    
    
    private func startRead() {
        lock.lock()
        
        // 等待在写操作或等待写操作完成，体现了写优先
        while (activeWriters + waitingWriters) > 0 {
            waitingReaders += 1
            okToReadCondition.wait()
            waitingReaders -= 1
        }
        
        activeReaders += 1
        lock.unlock()
    }
    
    private func endRead() {
        lock.lock()
    
        activeReaders -= 1

        // 当没有在读操作且有等待写操作时，通知可以写了
        if activeReaders == 0, waitingWriters > 0 {
            okToWriteCondition.signal()
        }
        
        lock.unlock()
    }
    
    private func startWrite() {
        lock.lock()
        
        // 没有在读和在写操作后才可开始读操作
        while activeWriters + activeReaders > 0 {
            waitingWriters += 1
            okToWriteCondition.wait()
            waitingWriters -= 1
        }
        
        activeWriters += 1
        lock.unlock()
    }
    
    private func endWrite() {
        lock.lock()
        
        activeWriters -= 1
        
        // 写优先
        if waitingWriters > 0 {
            okToWriteCondition.signal()
        } else if waitingReaders > 0 {
            // 所有等待读操作都可以执行，不堵塞
            okToReadCondition.broadcast()
        }
        
        lock.unlock()
    }
}
