//
//  SampleViewController.swift
//  Drums
//
//  Created by Chun Kong on 2018/9/23.
//  Copyright © 2018年 AudioKit. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class SampleViewController: UIViewController {

    var player:AKAudioPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        //载入了一个示例音频，创建了一个声音播放器，并设置它的循环播放这个声音。
        let file = try? AKAudioFile(readFileName: "climax-disco-part2.wav")
        player = try? AKAudioPlayer(file: file!)
        player!.looping = true
        AudioKit.output = player
        try? AudioKit.start()
        player!.play()
        
        let bitcrusher = AKBitCrusher(player!)
        //位深 一般16位(二进制数)  越低音质越低
        bitcrusher.bitDepth = 16
        //取样率 HZ 一般44100可以表现/2 22050  人耳是20-20000
        bitcrusher.sampleRate = 40000

        AudioKit.output = bitcrusher
//        let delay = AKDelay(player)
//        //延迟时间
//        delay.time = 0.1
//        //干湿混合值 1表示只有延迟的被输出
//        delay.dryWetMix = 1
//        let leftPan = AKPanner(player, pan: -1)
//        let rightPan = AKPanner(delay, pan: 1)
//        let mix = AKMixer(leftPan, rightPan)
//        AudioKit.output = mix
        let item=UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem=item
    
    }

    @objc func cancel(){
        player?.stop()
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
