//
//  MusicController.swift
//  Shafeer Meditation App
//
//  Created by Shafeer Puthalan on 16/04/19.
//  Copyright © 2019 Shafeer Puthalan. All rights reserved.
//

import UIKit
import Lottie
import Kingfisher
import AVFoundation


class MusicController: UIViewController {
    
    @IBOutlet weak var musicImage: UIImageView!
  
    @IBOutlet weak var musicProgress: UISlider!

    let playerItem : AVPlayerItem? = nil
    var documentId = String()
    var player: AVPlayer?
    var isPlaying = Bool()
    fileprivate let seekDuration: Float64 = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Music"
        FirebaseManager.Database.getSession(session: documentId) { (session) in
            self.musicImage.kf.setImage(with: URL(string: (session?.imageLink)!), placeholder: UIImage(named: "placeholder.png"))
            self.playAudio(url: URL(string: (session?.musicLink)!)!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let play = player {
            play.pause()
            player = nil
        } else {
            print("player was already deallocated")
        }
    }

    func playAudio(url : URL) {
        
        let playerItem : AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
        isPlaying = true
        musicProgress.minimumValue = 0
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        musicProgress.maximumValue = Float(seconds)
        musicProgress.isContinuous = false
        musicProgress.tintColor = UIColor.red
        musicProgress?.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
        player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player?.currentItem?.status == .readyToPlay{
                let time : Float64 = CMTimeGetSeconds((self.player?.currentTime())!);
                self.musicProgress!.value = Float ( time );
            }
        }
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)
        if player!.rate == 0 {
            player?.play()
        }
    }
    
    @IBAction func musicAction(_ sender: UIButton) {
        if(isPlaying){
            player?.pause()
            sender.setImage(UIImage(named: "pause"), for: .normal)
            isPlaying = false
        }
        else {
            player?.play()
            sender.setImage(UIImage(named: "play"), for: .normal)
            isPlaying = true
        }
    }
    
    @IBAction func fastBackwardAction(_ sender: Any) {
        
        let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
        var newTime = playerCurrentTime - seekDuration
        
        if newTime < 0 {
            newTime = 0
        }
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        player!.seek(to: time2)
        
    }
    
    @IBAction func fastForwardAction(_ sender: Any) {
        
        guard let duration  = player!.currentItem?.duration else{
            return
        }
        let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
        let newTime = playerCurrentTime + seekDuration
        
        if newTime < CMTimeGetSeconds(duration) {
            
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player!.seek(to: time2)
        }
    }
    
    
}
