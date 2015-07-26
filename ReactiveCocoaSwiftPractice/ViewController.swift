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
    
    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let textSignal:RACSignal = firstTextField.rac_textSignal()
        textSignal.subscribeNextAs { (text:String) -> () in
            println(text)
        }
        
        //A filter is a ‘gate’, filtering-out events which do not match the given condition
        let secondTextSignal = secondTextField.rac_textSignal()
        secondTextSignal
        .filterAs {
            (textString:NSString!) -> Bool in
                return textString.length > 3
        }.subscribeNextAs {
            (text:String) -> () in
            println(text)
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RACSignal {
    
    func subscribeNextAs<T>(nextClosure:(T) -> ()) -> () {
        self.subscribeNext {
        (next: AnyObject!) -> () in
            let nextAsT = next! as! T
            nextClosure(nextAsT)
        }
    }
    
    func filterAs<T>(nextClosure:(T!) -> Bool) -> (RACSignal) {
            return self.filter {
                (next: AnyObject!) -> Bool in
                if(next == nil){
                    return nextClosure(nil)
                }else{
                    let nextAsT = next as! T
                    return nextClosure(nextAsT)
                }
            }
    }
    
    func mapAs<T>(nextClosure:(T!) -> AnyObject!) -> (RACSignal) {
            return self.map {
                (next: AnyObject!) -> AnyObject! in
                if(next == nil){
                    return nextClosure(nil)
                }else{
                    let nextAsT = next as! T
                    return nextClosure(nextAsT)
                }
            }
    }
    
    
}

