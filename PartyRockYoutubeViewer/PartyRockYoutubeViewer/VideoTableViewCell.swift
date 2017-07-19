//
//  VideoTableViewCell.swift
//  PartyRockYoutubeViewer
//
//  Created by James Birchall on 08/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoPreviewImageView: UIImageView!
    @IBOutlet weak var viewTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(videoModel: VideoModel) {
        viewTitleLabel.text = videoModel.videoTitle
        
        if let checkedURL = URL(string: videoModel.imageURL) {
            downloadImage(url: checkedURL)
        }
    }
    
    
    // MARK: - Private Download Methods for Images
    
    private func downloadImage(url: URL) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { print("Error with data: \(error.debugDescription)."); return }
            
            DispatchQueue.main.async() { () -> Void in
                self.videoPreviewImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}
