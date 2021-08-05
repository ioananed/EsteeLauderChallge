//
//  FiveViewController.swift
//  ESTEELAUDER
//
//  Created by Ioana Nedelcu on 5/8/21.
//

import UIKit
import AVFoundation
import AVKit
import BLTNBoard


class FiveViewController: UIViewController {


    
    private lazy var boardManager: BLTNItemManager = { () -> BLTNItemManager in
        
        let item = BLTNPageItem(title: "Over 55 shades. 24-hour staying power. The #1 foundation in the US.")
        item.descriptionText = "Wear confidence. Double Wear Makeup is the fresh matte foundation that looks flawless whatever comes your way. 24-hour wear. Oil-free. Controls oil all day. Sweat-, heat- and humidity-resistant. Lifeproof, waterproof foundation. 24-hour color true. Liquid foundation in a wide range of shades that flatters all. Won’t look grey on deeper skintones. Unifies uneven skintone and covers imperfections—buildable, medium to full coverage foundation. Feels lightweight and so comfortable, you won’t believe it’s long wear. No touch ups needed. Our best foundation for long wear, Double Wear is the makeup that keeps up—no matter where your day takes you. Apply once and don’t think twice."
        item.actionButtonTitle = "Purchase"
        
        return BLTNItemManager(rootItem: item)
    }()
    
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTappedButton(_ sender: UIButton) {
        boardManager.showBulletin(above: self)

    }
    
    
    let videos23 = ["Video1", "video2", "video3", "video4", "video5"]
    let random = Int.random(in: 0...4)
    
    private func setupView() {
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: videos23[random], ofType: "mp4")!)
        let player = AVPlayer(url: path)
        
        
        let newLayer = AVPlayerLayer(player: player)
        newLayer.frame = self.videoView.frame
        self.videoView.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoDidPlayToEnd(_ :)), name: NSNotification.Name(rawValue: "AVPlaterItemDidPlayToEndTimeNotification"), object: player.currentItem)
        

        
        
        
    }
    @objc func videoDidPlayToEnd(_ notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero, completionHandler: nil)
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
