//
//  SoccerProcessor.swift
//  Soccer
//
//  Created by Melvin Musehani on 2015/04/13.
//  Copyright (c) 2015 CSIR. All rights reserved.
//

import UIKit

public class ApiProcessor: Processor
{
    public override var data: Any! {
        get {
            return nil
        }
    }
    
    var server: String
    
    public init(server: String)
    {
        self.server = server
    }
    
    public func callFunction(request: Request)
    {
        var functionName = ""
        
        if (request is ApiURLRequest)
        {
            functionName = (request as! ApiURLRequest).functionName
        }
        
        self.request(server + functionName, request: request)
    }
}
