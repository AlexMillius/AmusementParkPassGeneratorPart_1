//
//  Swipe.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Alex Millius on 02.08.16.
//  Copyright © 2016 TumTum. All rights reserved. 
//

import Foundation

protocol AccessControlType {
    static var area:Area {get}
    static func checkIfAccessGranted(people:PeopleType) -> (granted:Bool,discount:Int?,birthDay:Bool)
}

extension AccessControlType {
    static func checkIfAccessGranted(people:PeopleType) -> (granted:Bool,discount:Int?,birthDay:Bool) {
        switch area {
        case .amusement:
            if people.access.amusement {
                //An Happy Birthday message at every swipe area would be combersome. So if a happy birthday message is displayed, it appear only at the amusement swipe.
                //Currently we required the birth date only for employees or for a freeChilds pass
                if people is EmployeeType {
                    let employee = people as! EmployeeType
                    if let birthday = employee.info.dateOfBirth {
                        if checkIfThisIsTheBirthday(birthday) {
                            return (true,nil,true)
                        } else {
                            return (true,nil,false)
                        }
                    }
                }
                if people is GuestFreeChild {
                    let freeChild = people as! GuestFreeChild
                    if checkIfThisIsTheBirthday(freeChild.dateOfBirth) {
                        return (true,nil,true)
                    } else {
                        return (true,nil,false)
                    }
                }
                return (true,nil,false)
            } else { return (false,nil,false) }
        case .kitchen:
            if people.access.kitchen { return (true,nil,false) } else { return (false,nil,false) }
        case .maintenance:
            if people.access.maintenance { return (true,nil,false) } else { return (false,nil,false) }
        case .office:
            if people.access.office { return (true,nil,false) } else { return (false,nil,false) }
        case .rideControll:
            if people.access.rideControll { return (true,nil,false) } else { return (false,nil,false) }
        case .rides:
            if people.access.rides { return (true,nil,false) } else { return (false,nil,false) }
        case .skipLines:
            if people.access.skipLines { return (true,nil,false) } else { return (false,nil,false) }
        case .foodDiscount:
            if let discount = people.access.foodDiscountPourcent {
                switch discount {
                case .food(let pourcentDiscount): return (true,pourcentDiscount,false)
                default: return(false,nil,false)
                }
            } else { return(false,nil,false) }
        case .merchandiseDiscount:
            if let discount = people.access.foodDiscountPourcent {
                switch discount {
                case .merchandise(let pourcentDiscount): return (true,pourcentDiscount,false)
                default: return(false,nil,false)
                }
            } else { return(false,nil,false) }
        }
    }
}

//MARK: - Example of swipe
struct AmusementParkArea:AccessControlType{
    static let area: Area = Area.amusement
}
struct RidesArea:AccessControlType {
    static let area: Area = Area.rides
}
struct RidesControllArea:AccessControlType{
    static let area: Area = Area.rideControll
}
struct SkipLineArea:AccessControlType{
    static let area: Area = Area.skipLines
}
struct MaintenanceArea:AccessControlType{
    static let area: Area = Area.maintenance
}
struct KitchenArea:AccessControlType {
    static let area: Area = Area.kitchen
}
struct OfficeArea:AccessControlType {
    static let area: Area = Area.office
}
struct FoodDiscountCheck:AccessControlType {
    static let area: Area = Area.foodDiscount
}
struct MerchandiseDiscountCheck:AccessControlType {
    static let area: Area = Area.merchandiseDiscount
}