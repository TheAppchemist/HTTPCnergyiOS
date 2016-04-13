//
//  HttpInterface.swift
//  SplitView
//
//  Created by Melvin Musehani on 2015/04/10.
//  Copyright (c) 2015 Appchemy. All rights reserved.
//

import UIKit

class HttpInterface: NSObject
{
    var settings: HttpSettings
    var url: NSURL
    var headers = [String: String]()
    var delegate: HttpInterfaceDelegate!
    var task: NSURLSessionDataTask?
    
    init(link: String, settings: HttpSettings)
    {
        var parameterString = ""
        if (settings.type == HttpSettings.RequestType.Get && settings.output != nil)
        {
            parameterString = "\(settings.output)"
        }
        
        self.settings = settings
        self.headers = settings.headers
        self.url = NSURL(string: "\(link)?\(parameterString)")!
    }
    
    func request(delegate: HttpInterfaceDelegate)
    {
        print("Connecting... \(url.absoluteString)")
        self.delegate = delegate
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        
        for (header, value) in settings.headers {
            request.setValue(value, forHTTPHeaderField: header)
            //NSLog("Header = \(header): \(value)")
        }
        
        if (settings.type == HttpSettings.RequestType.Post)
        {
            request.HTTPMethod = "POST"
            let postString = settings.output
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        print("Request \(request)")
        
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if let error = error {
                self.delegate?.onNetworkError("Network Error")
            }
            else {
                if let data = data {
                    let result = NSString(data: data, encoding:
                        NSASCIIStringEncoding)!
                    self.delegate.onRequestSuccess(result as String)
                }
            }
        }
        task.resume()
    }
    
    func cancel() {
        if let task = task {
            task.cancel()
        }
    }
}

protocol HttpInterfaceDelegate
{
    func onRequestSuccess(data: String)
    func onNetworkError(error: String)
}