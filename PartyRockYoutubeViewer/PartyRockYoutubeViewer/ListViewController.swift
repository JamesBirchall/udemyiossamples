//
//  ViewController.swift
//  PartyRockYoutubeViewer
//
//  Created by James Birchall on 08/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Variables
    
    private var videoCells = [VideoModel]()

    // MARK: - ViewController Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We used Storyboard to connect Data Source and Delegate so not need to code it in.
        
        let video1 = VideoModel(imageURL: "https://yt3.ggpht.com/-aK8ZW8-RwNQ/AAAAAAAAAAI/AAAAAAAAAAA/nJjMP-m_YJQ/s88-c-k-no-mo-rj-c0xffffff/photo.jpg", videoURL: "https://www.youtube.com/embed/fz94zgW8L6w", videoTitle: "Simple Programmer")
        let video2 = VideoModel(imageURL: "https://yt3.ggpht.com/-VxZgZkhnb74/AAAAAAAAAAI/AAAAAAAAAAA/mwYsteEti-8/s88-c-k-no-mo-rj-c0xffffff/photo.jpg", videoURL: "https://www.youtube.com/embed/H-nxpSoaSwE", videoTitle: "Burn baby burn")
        let video3 = VideoModel(imageURL: "https://yt3.ggpht.com/-76JS-CU_E6c/AAAAAAAAAAI/AAAAAAAAAAA/e3lX1jOnSxk/s88-c-k-no-mo-rj-c0xffffff/photo.jpg", videoURL: "https://www.youtube.com/embed/fz94zgW8L6w", videoTitle: "Look at me prince Ali...")
        let video4 = VideoModel(imageURL: "https://yt3.ggpht.com/-QGhAvSy7npM/AAAAAAAAAAI/AAAAAAAAAAA/Uom6Bs6gR9Y/s88-c-k-no-mo-rj-c0xffffff/photo.jpg", videoURL: "https://www.youtube.com/embed/fz94zgW8L6w", videoTitle: "Home sweet home")
        let video5 = VideoModel(imageURL: "https://yt3.ggpht.com/-jW69mSF8nzI/AAAAAAAAAAI/AAAAAAAAAAA/O6TB_f7j9bA/s88-c-k-no-mo-rj-c0xffffff/photo.jpg", videoURL: "https://www.youtube.com/embed/fz94zgW8L6w", videoTitle: "I kissed a girl")
        
        videoCells.append(contentsOf: [video1, video2, video3, video4, video5])
        
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoModel = videoCells[indexPath.row]
        
        performSegue(withIdentifier: "showVideoSegue", sender: videoModel)
        
        print("Did Select Row as Index!")
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as? VideoTableViewCell {
            let videoCell = videoCells[indexPath.row]
            cell.updateUI(videoModel: videoCell)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - Segue Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? VideoViewController {
            if let videoModel = sender as? VideoModel {
                destination.videoModel = videoModel
                print("Desintation setup and video model shared \(videoModel.videoTitle)")
            }
        }
    }
}

