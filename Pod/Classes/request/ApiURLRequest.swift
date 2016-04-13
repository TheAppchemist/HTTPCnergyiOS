//
//  ApiURLRequest.swift
//  Soccer
//
//  Created by Melvin Musehani on 2015/04/13.
//  Copyright (c) 2015 CSIR. All rights reserved.
//

import UIKit

public class ApiURLRequest: UrlEncodedRequest
{
    var functionName: String
    
    public init(type: HttpSettings.RequestType, id: Int, functionName: String)
    {
        self.functionName = functionName
        
        super.init(type: type, id: id)
        
        setHeader("User-Agent", value: "iPhone")
        setHeader("Accept", value: "application/json")
    }
}
