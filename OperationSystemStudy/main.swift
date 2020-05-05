//
//  main.swift
//  OperationSystemStudy
//
//  Created by wentilin on 2020/5/3.
//  Copyright © 2020 wentilin. All rights reserved.
//

import Foundation

let queue = OperationQueue()
queue.maxConcurrentOperationCount = 2
queue.addOperation {
    procedure0()
}

queue.addOperation {
    procedure1()
}

queue.waitUntilAllOperationsAreFinished()


queue.maxConcurrentOperationCount = 10

print("----------test spin lock------------")

//let test = SpinLockTest()
//queue.addOperation {
//    for _ in 0..<100 {
//        test.increase()
//    }
//}
//
//queue.addOperation {
//    for _ in 0..<100 {
//        test.decrease()
//    }
//}
//
//queue.waitUntilAllOperationsAreFinished()

// value must be 0
//print("value: \(test.value)")

class SpinLockTest {
    var value: Int = 0
    private let lock: SpinLock = .init()

    func increase() {
        lock.lock()
        value += 1
        lock.unlock()
    }
    
    func decrease() {
        lock.lock()
        value -= 1
        lock.unlock()
    }
}

print("----------test bounded buffer------------")
let boundedBuffer = BoundedBuffer<Int>(capacity: 10)

queue.addOperation {
    for i in 0..<10 {
        boundedBuffer.deposite(i)
        print("deposite item(\(i))")
    }
}

queue.addOperation {
    for _ in 0..<10 {
        let item = boundedBuffer.remove()
        print("remove item(\(item))")
    }
}

queue.waitUntilAllOperationsAreFinished()


print("----------test writer first monitor------------")

let monitor = WriterFirstMonitor()
// writers
for i in 0..<10 {
    queue.addOperation {
        monitor.write(i)
        print("monitor write item(\(i))")
    }
}

// readers
for _ in 0..<10 {
    queue.addOperation {
        print("monitor read item(\(monitor.read()))")
    }
}

queue.waitUntilAllOperationsAreFinished()


