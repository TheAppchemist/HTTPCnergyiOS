//
//  Error.swift
//  Soccer
//
//  Created by Francois Stark on 2015/04/13.
//  Copyright (c) 2015 CSIR. All rights reserved.
//

import UIKit

public class Error: NSObject
{
    public var message: String!
    public var code: Int!
    
    init(json: JSON)
    {
        message = json["message"].stringValue
        code = json["code"].intValue
    }
    
    init(message: String)
    {
        self.message = message
        self.code = -1
    }
}
