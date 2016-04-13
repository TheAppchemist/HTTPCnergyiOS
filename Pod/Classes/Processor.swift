import UIKit

public class Processor: NSObject, HttpInterfaceDelegate
{
    public var delegate: ProcessorDelegate!
    public var request: Request!
    public var json: JSON!
    public var data: Any! {
        get {
            return nil
        }
    }
    
    var http: HttpInterface?
    
    func request(url: String, request: Request)
    {
        delegate?.onProcessStarted(request)
        
        let settings = HttpSettings(type: request.type)
        settings.output = request.data!
        settings.headers = request.headers
        
        self.request = request
        http = HttpInterface(link: url, settings: settings)
        http!.request(self)
    }
    
    public func cancel() {
        if let http = http {
            http.cancel()
            
            if let delegate = delegate {
                //delegate.onProcessFinished(request)
            }
        }
    }
    
    func onRequestSuccess(data: String)
    {
//        let data = data.stringByTrimmingCharactersInSet(
//            NSCharacterSet.whitespaceAndNewlineCharacterSet()
//        )
        //NSLog(data)
        
        dispatch_async(dispatch_get_main_queue(),{
            self.delegate?.onProcessFinished(self.request)
        })
        
        if let s = data.dataUsingEncoding(NSUTF8StringEncoding) {
            
            if JSON(data: s).count == 0
        {
            dispatch_async(dispatch_get_main_queue(),{
                self.delegate?.onResponseError(self.request)
            })
        }
        else
        {
                print(data)
                let json = JSON(data: s)
                let error = json["error"]
                
                if (error.error != nil)
                {
                    print("No error")
                    self.json = json
                    
                    if self.data != nil {
                        dispatch_async(dispatch_get_main_queue(),{
                            self.delegate?.onProcessSuccess(self.data, request: self.request)
                        })
                    }
                }
                else
                {
                    print("Error: \(json.error)")
                    dispatch_async(dispatch_get_main_queue(),{
                        self.delegate?.onProcessFailed(Error(json: error), request: self.request)
                    })
                }
            }
        }
    }
    
    func onNetworkError(error: String) {
        print(error)
        dispatch_async(dispatch_get_main_queue(),{
            self.delegate?.onProcessFinished(self.request)
            self.delegate?.onNetworkError(self.request)
        })
        
        
    }
    
    func isJSON(data: String) -> Bool {
        do {
            try NSJSONSerialization.dataWithJSONObject(data, options: [])
            
            return true
        }
            //let json = JSON(json: theJSONText)
        catch  {
            print("Something wrong happened")
            return false
        }
    }
}

public protocol ProcessorDelegate
{
     func onProcessStarted(request: Request)
     func onProcessFinished(request: Request)
    
     func onProcessSuccess(data: Any, request: Request)
     func onProcessFailed(error: Error, request: Request)
     func onResponseError(request: Request)
     func onNetworkError(request: Request)
}
