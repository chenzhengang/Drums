//
//  OscillatorViewController.swift
//  Drums
//
//  Created by Chun Kong on 2018/9/23.
//  Copyright © 2018年 AudioKit. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class OscillatorViewController: UIViewController {
    let oscillator = AKOscillator()
    override func viewDidLoad() {
        super.viewDidLoad()
        //震荡子 是AKNode子类  node是构成你的音频序列的主要元素 一个振荡子会创建一个重复的、或者周期性的无限延续的信号。
        oscillator.rampDuration = 0.2
        oscillator.frequency = 500
        AudioKit.output = oscillator
        try? AudioKit.start()
        
        // 3. Start the oscillator
        oscillator.start()
        AKPlaygroundLoop(every: 0.5) {
            self.oscillator.frequency =
                self.oscillator.frequency == 500 ? 100 : 500
        } 
        // Do any additional setup after loading the view.
    

        let item=UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem=item
    
}

    @objc func cancel(){
        oscillator.stop()
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
