//
//  CarListDataModel.swift
//  Cars
//
//  Created by Vikas Kumar on 05/03/22.
//

import Foundation

class CarListDataModel: NSObject, NSCoding {
    
    //Property
    var carsListArray: [CarListModel] = []

    //Initializer
    override init() {
        super.init()
    }
    
    //Coding Protocol Methods
    func encode(with coder: NSCoder) {
        coder.encode(self.carsListArray, forKey: "carsListArray")
    }
    
    required init(coder decoder: NSCoder) {
        if let data = decoder.decodeObject(forKey: "carsListArray") as? [CarListModel] {
            self.carsListArray = data
        }
    }
}
