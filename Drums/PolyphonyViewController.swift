//
//  PolyphonyViewController.swift
//  Drums
//
//  Created by Chun Kong on 2018/9/23.
//  Copyright © 2018年 AudioKit. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class PolyphonyViewController: UIViewController, AKKeyboardDelegate
{

    let bank = AKOscillatorBank()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioKit.output = bank
        try? AudioKit.start()
        let keyboard = AKKeyboardView(width: 440, height: 100)
        keyboard.frame = CGRect(x: 0, y: 100, width: 440, height: 100)
        keyboard.delegate = self
        //复音模式  多个音一起
        keyboard.polyphonicMode = true
        self.view.addSubview(keyboard)

        // Do any additional setup after loading the view.
    }
    
    func noteOn(note: MIDINoteNumber) {
        bank.play(noteNumber: note, velocity: 80)
    }
    
    func noteOff(note: MIDINoteNumber) {
        bank.stop(noteNumber: note)
    }


}
