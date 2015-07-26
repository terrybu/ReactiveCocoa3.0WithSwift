//
//  ViewController.swift
//  ReactiveCocoaSwiftPractice
//
//  Created by Terry Bu on 7/26/15.
//  Copyright (c) 2015 Terry Bu. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let textSignal:RACSignal = textField.rac_textSignal()
        textSignal.subscribeNext {
            (text: AnyObject!) -> Void in
            let textString = text as! String
            println(textString)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

