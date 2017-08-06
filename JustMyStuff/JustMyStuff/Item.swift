//
//  Item.swift
//  JustMyStuff
//
//  Created by James Birchall on 06/08/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import CoreData

extension Item {
    
    // When Item is inserted into Context, create the Date explicitly
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
