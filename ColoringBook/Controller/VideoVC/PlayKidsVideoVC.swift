//
//  PlayKidsVideoVC.swift
//  ColoringBook
//
//  Created by Apple on 24/12/21.
//  Copyright © 2021 I MAC. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import AVKit
import youtube_ios_player_helper
import SwiftUI

class PlayKidsVideoVC: UIViewController {
    
    var strTitleName : String = ""

    @IBOutlet var playerView: YTPlayerView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var viewShare: UIView!

    var strVideoName : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.playVideo()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnShare(_ sender: Any) {
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [self.strVideoName], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.permittedArrowDirections = [.down]
        activityViewController.modalPresentationStyle = .fullScreen
        
        if let popOver = activityViewController.popoverPresentationController {
            popOver.sourceView = self.viewShare
            popOver.sourceRect = (sender as AnyObject).bounds
        }
        
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnRefresh(_ sender: Any) {
        self.playerView.seek(toSeconds: 0, allowSeekAhead: true)
    }
    
    func playVideo() {
        if self.strVideoName != "" {
            let strVideoID: String = self.strVideoName.youtubeID!
            self.playerView.load(withVideoId: strVideoID)
        }
    }
}

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)

        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }

        return (self as NSString).substring(with: result.range)
    }
}
