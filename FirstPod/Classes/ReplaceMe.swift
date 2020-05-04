
import Foundation

public class Logger
{
    public init(){}
    
    public func printLog() {
        print("Firspod Framework :: Hello world")
    }
    
    public func printLog(text : String)
    {
       print("Firspod Framework :: \(text)")
    }
    
    func privateMethod()
    {
        print("private")
    }
}
