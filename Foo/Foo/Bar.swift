//
//  Bar.swift
//  Foo
//
//  Created by Daniel Eggert on 09/01/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit
import Foo_Private

@objc open class Bar: NSObject {
   
    @objc open func doSomething() -> String {
        // We can access Baz, which is public:
        let b = Baz()
        print("test B")
        b.doSomething()
        
        // We can also access Norf, even though it is not public:
        let n = Norf()
        print("test N")
        
        let q = Qux()
        print("test Q")
        
        return "Test String"
    }
}
