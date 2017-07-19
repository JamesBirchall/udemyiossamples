//
//  VideoModel.swift
//  PartyRockYoutubeViewer
//
//  Created by James Birchall on 08/07/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import Foundation

struct VideoModel {
    
    // MARK: - Private Variables
    private var _imageURL: String!
    private var _videoURL: String!
    private var _videoTitle: String!
    
    
    // MARK: - Public Variables
    var imageURL: String {
        return _imageURL
    }
    
    var videoURL: String {
        return _videoURL
    }
    
    var videoTitle: String {
        return _videoTitle
    }
    
    // MARK: - Initialisers
    
    init(imageURL: String, videoURL: String, videoTitle: String) {
        _imageURL = imageURL
        _videoURL = videoURL
        _videoTitle = videoTitle
    }
}
