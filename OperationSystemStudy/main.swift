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
