//
//  AdditiveViewController.swift
//  Drums
//
//  Created by Chun Kong on 2018/9/23.
//  Copyright © 2018年 AudioKit. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class AdditiveViewController: UIViewController {
    
    var oscillators:[AKOscillator]!
    
    override func viewDidLoad() {
        //这个数字是标注键盘上的中音 C 的音频。将其他数字乘以这个值，这就是“和声”。
        let frequencies = (1...5).map { $0 * 261.63 }
        //再次进行一个 map 操作，以创建多个振荡器。
        oscillators = frequencies.map {
            createAndStartOscillator(frequency: $0)
        }
        let mixer = AKMixer()
        oscillators.forEach {
            mixer.connect(input: $0)
        }

        let envelope = AKAmplitudeEnvelope(mixer)
        envelope.attackDuration = 0.01
        envelope.decayDuration = 0.1
        envelope.sustainLevel = 0.1
        envelope.releaseDuration = 0.3
        
        AudioKit.output = envelope
        try? AudioKit.start()
        //似乎需要在AudioKit.start之后再start振荡器  否则没有声音
        oscillators.forEach {
            $0.start()
        }
        
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
        oscillators?.forEach {
            $0.stop()
            print($0.frequency)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
 
    //用来创建多个振荡器
    func createAndStartOscillator(frequency: Double) -> AKOscillator {
        let oscillator = AKOscillator()
        oscillator.frequency = frequency
        //oscillator.start()
        return oscillator
    }
}
