//
//  PetersonMutex.swift
//  OperationSystemStudy
//
//  Created by wentilin on 2020/5/3.
//  Copyright © 2020 wentilin. All rights reserved.
//

import Foundation

//
//  PetersonMutex.swift
//  OperationSystem-study
//
//  Created by wentilin on 2020/5/3.
//  Copyright © 2020 wentilin. All rights reserved.
//

import Foundation

var turn: Int = 0
var flags: [Bool] = [false, false]

let sharedObject = SharedObject()

func procedure0() {
    turn = 1
    flags[0] = true
    
    while flags[1], turn == 1 {
        
    }
    
    // enter critical section
    sharedObject.proc = 0
    sharedObject.doSometing()
    
    
    flags[0] = false
    // leave critical section
}

func procedure1() {
    turn = 0
    flags[1] = true
    
    while flags[0], turn == 0 {
        
    }
    
    // enter critical section
    sharedObject.proc = 1
    sharedObject.doSometing()
    
    flags[1] = false
    // leave critical section
}

class SharedObject {
    var proc: Int = 0
    
    func doSometing() {
        print("proc \(proc) start processing")
        
        print("proc \(proc) end processing")
    }
}
