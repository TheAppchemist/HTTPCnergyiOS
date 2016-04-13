//
//  Request.swift
//  Soccer
//
//  Created by Melvin Musehani on 2015/04/13.
//  Copyright (c) 2015 CSIR. All rights reserved.
//

import UIKit

public class Request: NSObject
{
    public var type = HttpSettings.RequestType.Get
    public var headers = [String: String]()
    public var id = -1
    public var data: String! {
        get {
            return nil
        }
    }
    
    public init(type: HttpSettings.RequestType)
    {
        self.type = type
    }
    
    public init(type: HttpSettings.RequestType, id: Int)
    {
        self.type = type
        self.id = id
    }
    
    public func setHeader(name: String, value: String)
    {
        headers[name] = value
    }
}
