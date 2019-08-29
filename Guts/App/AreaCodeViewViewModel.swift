//
//  AreaCodeViewViewModel.swift
//  Guts
//
//  Created by uncle_jia on 29/8/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import RxSwift

class  AreaCodeViewModel: NSObject  {
    
    func numberOfArea() -> Observable<([String], NSDictionary)> {
        return Observable.create({ (observer) -> Disposable in
            var areaHeaders = [String]()
            let path = Bundle.main.path(forResource: "area_code", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            
            do {
                let data = try Data(contentsOf: url)
                let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                let jsonDic = jsonData as! NSDictionary
                
                for (key, _) in jsonDic{
                    areaHeaders.append(key as! String)
                }
                areaHeaders.sort()
                
                observer.on(Event<([String], NSDictionary)>.next((areaHeaders, jsonDic)))
                observer.on(.completed)
                
            } catch let error as Error?{
                print("read json data error", error ?? "")
                observer.onError(error!)
            }
        
            return Disposables.create()
        })
       
    }
}
