//
//  ViewController.swift
//  ESTEELAUDER
//
//  Created by Ioana Nedelcu on 5/8/21.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    let videos = ["Video1", "video2", "video3", "video4", "video5"]
    let random = Int.random(in: 0...4)
    
    private func setupView() {
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: videos[random], ofType: "mp4")!)
        let player = AVPlayer(url: path)
        
        
        let newLayer = AVPlayerLayer(player: player)
        newLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoDidPlayToEnd(_ :)), name: NSNotification.Name(rawValue: "AVPlaterItemDidPlayToEndTimeNotification"), object: player.currentItem)
        
        videoView.bringSubviewToFront(nextButton)
        
        
        
    }
    @objc func videoDidPlayToEnd(_ notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero, completionHandler: nil)
    }
    
}

