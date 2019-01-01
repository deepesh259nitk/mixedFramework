//
//  ViewController.swift
//  ExampleApp
//
//  Created by ITRMG on 2018-30-12.
//  Copyright © 2018 djrecker. All rights reserved.
//

import UIKit
import Foo

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testBaz = Baz()
        print(testBaz.doSomething())
        
        let testBar = Bar()
        print(testBar.doSomething())
        
    }

}

