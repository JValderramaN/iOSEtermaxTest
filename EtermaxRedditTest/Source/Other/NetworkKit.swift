//
//  NetworkKit.swift
//  EtermaxRedditTest
//
//  Created by José Valderrama on 11/01/16.
//  Copyright © 2016 José Valderrama. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift
import SystemConfiguration

/// Network Resposability
class NetworkKit {
    
    /// Fetchs data for given <T> type conforming with protocols
    static func fetchData <T: Object> (type: T.Type, success:@escaping () -> Void, fail:@escaping (_ error:NSError)->Void)->Void where T:Mappable, T:Meta {
        Alamofire.request(type.url())
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    
                    guard let json = response.result.value as? [String: AnyObject]
                        , let data = json["data"] as? [String: AnyObject]
                        , let children = data["children"] as? [AnyObject]
                        else{
                            return
                    }
                    
                    if let entries = Mapper<RedditEntry>().mapArray(JSONObject: children){
                        do {
                            let realm = try Realm()
                            try realm.write {
                                for entry in entries {
                                    realm.add(entry,update: true)
                                }
                            }
                        } catch let error as NSError {
                            fail(error)
                        }
                        success()
                    }
                case .failure(let error):
                    fail(error as NSError)
                }
        }
    }
    
    /// Checks whether Internet connection
    static func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
        
    }
}
