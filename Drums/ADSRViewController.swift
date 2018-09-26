//
//  ADSRViewController.swift
//  Drums
//
//  Created by Chun Kong on 2018/9/23.
//  Copyright © 2018年 AudioKit. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class ADSRViewController: UIViewController {
    let oscillator = AKOscillator()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //震荡子 是AKNode子类  node是构成你的音频序列的主要元素 一个振荡子会创建一个重复的、或者周期性的无限延续的信号。
        
        let envelope = AKAmplitudeEnvelope(oscillator)
        envelope.attackDuration = 0.01
        envelope.decayDuration = 0.1
        envelope.sustainLevel = 0.1
        envelope.releaseDuration = 0.3
        AudioKit.output = envelope
        try? AudioKit.start()
        oscillator.start()
        
        //重复播放停止
        AKPlaygroundLoop(every: 0.5) {
            if (envelope.isStarted) {
                envelope.stop()
            } else {
                envelope.start()
            }
        }
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
