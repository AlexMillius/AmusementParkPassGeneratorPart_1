//
//  Swipe.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Alex Millius on 02.08.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

//import Foundation

protocol AccessControlType {
    static var area:Area {get}
    static func checkIfAccessGranted(people:PeopleType) -> (granted:Bool,discount:Int?)
}

extension AccessControlType {
    static func checkIfAccessGranted(people:PeopleType) -> (granted:Bool,discount:Int?) {
        switch area {
        case .amusement:
            if people.access.amusement { return (true,nil) } else { return (false,nil) }
        case .kitchen:
            if people.access.kitchen { return (true,nil) } else { return (false,nil) }
        case .maintenance:
            if people.access.maintenance { return (true,nil) } else { return (false,nil) }
        case .office:
            if people.access.office { return (true,nil) } else { return (false,nil) }
        case .rideControll:
            if people.access.rideControll { return (true,nil) } else { return (false,nil) }
        case .rides:
            if people.access.rides { return (true,nil) } else { return (false,nil) }
        case .skipLines:
            if people.access.skipLines { return (true,nil) } else { return (false,nil) }
        case .foodDiscount:
            if let discount = people.access.foodDiscountPourcent {
                switch discount {
                case .food(let pourcentDiscount): return (true,pourcentDiscount)
                default: return(false,nil)
                }
            } else { return(false,nil) }
        case .merchandiseDiscount:
            if let discount = people.access.foodDiscountPourcent {
                switch discount {
                case .merchandise(let pourcentDiscount): return (true,pourcentDiscount)
                default: return(false,nil)
                }
            } else { return(false,nil) }
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









