//
//  CarListModel.swift
//  Cars
//
//  Created by Vikas Kumar on 03/03/22.
//

import Foundation

class CarListModel: NSObject, NSCoding {
    
    //Properties
    var id: Int?
    var title: String?
    var dateTime: String?
    var ingress: String?
    var image: String?
    
    //Computed Property
    var formattedDateTime: String {
        get {
            if let dateTime = dateTime {
                if Date.isDateFormatSupported(with: dateTime, to: DATE_FORMAT) {
                    let dateObject = Date.formattedDate(dateTime, DATE_FORMAT)
                    let dateFormat = dateObject.isCurrentYear() ? DATETIME_FORMAT : DATEYEAR_FORMAT
                    return dateObject.formattedDateString(dateFormat)
                } else {
                    return dateTime
                }
            }
            return ""
        }
    }
    
    //Initializer
    override init() {
        super.init()
    }
    
    //Custom Initializer
    init(dict: [String:Any]) {
        if let value = dict["id"] as? Int {
            self.id = value
        }
        if let value = dict["title"] as? String {
            self.title = value
        }
        if let value = dict["dateTime"] as? String {
            self.dateTime = value
        }
        if let value = dict["ingress"] as? String {
            self.ingress = value
        }
        if let value = dict["image"] as? String {
            self.image = value
        }
    }
    
    //Coding Protocol Methods
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: "id")
        coder.encode(self.title, forKey: "title")
        coder.encode(self.dateTime, forKey: "dateTime")
        coder.encode(self.ingress, forKey: "ingress")
        coder.encode(self.image, forKey: "image")
    }
    
    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeObject(forKey: "id") as? Int
        self.title = decoder.decodeObject(forKey: "title") as? String
        self.dateTime = decoder.decodeObject(forKey: "dateTime") as? String
        self.ingress = decoder.decodeObject(forKey: "ingress") as? String
        self.image = decoder.decodeObject(forKey: "image") as? String
    }
}
