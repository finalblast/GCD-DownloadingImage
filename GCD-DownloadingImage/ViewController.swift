//
//  ViewController.swift
//  GCD-DownloadingImage
//
//  Created by Nam (Nick) N. HUYNH on 3/22/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    var token: dispatch_once_t = 0
    var numberOfEntries = 0
    
    func executeOnlyOnce() {
        
        numberOfEntries++
        println("Executed: \(numberOfEntries)(s) times")
        
    }
    
    func fileLocation() -> String? {
        
        let folders = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as [String]
        
        if folders.count == 0 {
            
            return nil
            
        }
        
        let documentsFolder = folders[0]
        return documentsFolder.stringByAppendingPathComponent("list.txt")
        
    }
    
    func hasFileAlreadyBeenCreated() -> Bool {
        
        let fileManager = NSFileManager()
        if let location = fileLocation() {
            
            return fileManager.fileExistsAtPath(location)
            
        }
        
        return false
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
//        let concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//        
//        dispatch_async(concurrentQueue, { () -> Void in
//            
//            let numbersOfvalues = 10000
//            
//            if self.hasFileAlreadyBeenCreated() == false {
//                
//                dispatch_sync(concurrentQueue, { () -> Void in
//                    
//                    var arrayOfRandomValues = [Int]()
//                    for _ in 0 ..< numbersOfvalues {
//                        
//                        let ramdomNumber = Int(arc4random())
//                        arrayOfRandomValues.append(ramdomNumber)
//                        
//                    }
//                    
//                    let array = arrayOfRandomValues as NSArray
//                    array.writeToFile(self.fileLocation()!, atomically: true)
//                    
//                })
//                
//            }
//            
//            var randomNumbers: NSMutableArray?
//            
//            dispatch_sync(concurrentQueue, { () -> Void in
//                
//                if self.hasFileAlreadyBeenCreated() {
//                    
//                    randomNumbers = NSMutableArray(contentsOfFile: self.fileLocation()!)
//                    
//                    randomNumbers?.sortUsingComparator({ (obj1, obj2) -> NSComparisonResult in
//                        
//                        let number1 = obj1 as NSNumber
//                        let number2 = obj2 as NSNumber
//                        
//                        return number1.compare(number2)
//                        
//                    })
//                    
//                }
//                
//            })
//            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                
//                if let numbers = randomNumbers {
//                    
//                    if numbers.count > 0 {
//                        
//                        println("Array: \(numbers)")
//                        
//                    } else {
//                        
//                        println("Error")
//                        
//                    }
//                    
//                }
//                
//            })
//            
//        })
        
//        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//        
//        dispatch_async(queue, { () -> Void in
//            
//            dispatch_sync(queue, { () -> Void in
//                
//                // Downloading image
//                let urlAsString = "http://www.apple.com/iphone-6s/overview/images/og.jpg?201603021549"
//                let url = NSURL(string: urlAsString)!
//                let urlRequest = NSURLRequest(URL: url)
//                var downloadError: NSError?
//                
//                let imageData = NSURLConnection.sendSynchronousRequest(urlRequest, returningResponse: nil, error: &downloadError)
//                
//                if let error = downloadError {
//                    
//                    println("Error: \(error)")
//                    
//                }
//                
//                if imageData?.length > 0 {
//                    
//                    self.image = UIImage(data: imageData!)
//                    
//                } else {
//                    
//                    println("No data!")
//                    
//                }
//                
//            })
//            
//            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
//                
//                if let downloadedImage = self.image {
//                    
//                    self.imageView.image = downloadedImage
//                    
//                }
//                
//            })
//            
//        })
//        
    }
    
    func reloadTableView() {
        
        println(__FUNCTION__)
        
    }
    
    func reloadScrollView() {
        
        println(__FUNCTION__)
        
    }
    
    func reloadImageView() {
        
        println(__FUNCTION__)
        
    }
    
    func operationCode() {
        
        for _ in 0 ..< 100 {
            
            println("Thread = \(NSThread.currentThread())")
            
        }
        
    }
    
    func downloadUrls(urls: [NSURL]) {
        
        for url in urls {
            
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.currentQueue(), completionHandler: { (response, data, error) -> Void in
                
                if error != nil {
                    
                    println("Failed to download data. Error = \(error)")
                    
                } else {
                    
                    println("Data is downloaded. Save it to disk...")
                    
                }
                
            })
            
        }
        
    }
    
    func downloadUrls() {
        
        let urlsAsString = [
            "http://www.keenthemes.com/preview/metronic/theme/assets/global/plugins/jcrop/demos/demo_files/image1.jpg",
            "http://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/idcs1426.jpg?itok=Gc_-Q58L",
            "http://www.joomlaworks.net/images/demos/galleries/abstract/7.jpg",
        ]
        
        var urls = [NSURL]()
        for string in urlsAsString {
            
            urls.append(NSURL(string: string)!)
            
        }
        
        downloadUrls(urls)
        
    }
    
    func performWorkForParameter(param: AnyObject?, operationName: String) {
        
        if let theParam: AnyObject = param {
            
            println("First operation - Object = \(theParam)")
            
        }
        
        println("\(operationName) Operation - Main Thread = \(NSThread.mainThread())")
        println("\(operationName) Operation - Current Thread = \(NSThread.currentThread())")
        
    }
    
    func firstOperationEntry(param: AnyObject?) {
        
        performWorkForParameter(param, operationName: "First")
        
    }
    
    func secondOperationEntry(param: AnyObject?) {
        
        performWorkForParameter(param, operationName: "Second")
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        let delayInSeconds = 2.0
//        
//        let delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
//        let concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//        
//        dispatch_after(delayInNanoSeconds, concurrentQueue) { () -> Void in
//            
//            println("OK")
//            
//        }
//        
//        dispatch_once(&token, executeOnlyOnce)
//        dispatch_once(&token, executeOnlyOnce)
//        
//        let taskGroup = dispatch_group_create()
//        let mainQueue = dispatch_get_main_queue()
//        
//        dispatch_group_async(taskGroup, mainQueue) { () -> Void in
//            
//            self.reloadTableView()
//            
//        }
//        
//        dispatch_group_async(taskGroup, mainQueue) { () -> Void in
//            
//            self.reloadScrollView()
//            
//        }
//        
//        dispatch_group_async(taskGroup, mainQueue) { () -> Void in
//            
//            self.reloadImageView()
//            
//        }
//        
//        dispatch_group_notify(taskGroup, mainQueue) { () -> Void in
//            
//            let controller = UIAlertController(title: "Finished", message: "All task has been finished", preferredStyle: UIAlertControllerStyle.Alert)
//            controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(controller, animated: true, completion: nil)
//            
//        }
//        
//        let operation = CountingOperation()
//        let operationQueue = NSOperationQueue()
//        operationQueue.addOperation(operation)
//        
//        let operation1 = NSBlockOperation(block: operationCode)
//        let operation2 = NSBlockOperation(block: operationCode)
//        
//        let queue = NSOperationQueue()
//        queue.addOperation(operation1)
//        queue.addOperation(operation2)
        
//        let operationUserInit = NSBlockOperation(block: downloadUrls)
//        let queueUserInit = NSOperationQueue()
//        queueUserInit.qualityOfService = NSQualityOfService.UserInitiated
//        queueUserInit.maxConcurrentOperationCount = 3
//        queueUserInit.addOperation(operationUserInit)
        
        let firstNumber = 111
        let secondNumber = 222
        
        let firstOperation = NSBlockOperation { () -> Void in
            
            self.firstOperationEntry(firstNumber)
            
        }
        
        let secondOperation = NSBlockOperation { () -> Void in
            
            self.secondOperationEntry(secondNumber)
            
        }
        
        let operationQueue = NSOperationQueue()
        firstOperation.addDependency(secondOperation)
        operationQueue.addOperation(firstOperation)
        operationQueue.addOperation(secondOperation)
        println("Main Thread is here.")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

