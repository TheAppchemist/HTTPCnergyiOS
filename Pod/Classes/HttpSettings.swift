//
//  HttpSettings.swift
//  Soccer
//
//  Created by Francois Stark on 2015/04/13.
//  Copyright (c) 2015 CSIR. All rights reserved.
//

import UIKit

public class HttpSettings: NSObject
{
    public enum RequestType
    {
        case Get
        case Post
    }
    
    var type = RequestType.Get
    var headers = [String: String]()
    var output: String!
    
    init(type: RequestType)
    {
        self.type = type
    }
}
