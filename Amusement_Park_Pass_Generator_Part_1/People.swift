//
//  People.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Alex Millius on 29.07.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import Foundation

//MARK: Protocol
protocol PeopleType {
    var access:AreaAccess { get }
}

//MARK: - Employee Protocol
protocol EmployeeType:PeopleType {
    var info:PeopleInfo { get }
}
protocol EmployeeFoodServiceType: EmployeeType {
}
protocol EmployeeRideServiceType: EmployeeType {
}
protocol EmployeeMaintenanceType: EmployeeType {
}
protocol EmployeeManagerType: EmployeeType{
    var tier:ManagementTier { get }
}

//MARK: - Guest Protocol
protocol GuestType:PeopleType {
}
protocol GuestClassicType:GuestType {
}
protocol GuestFreeChildType:GuestType {
    var dateOfBirth:NSDate { get }
}
protocol GuestVIPType:GuestType {
}

//MARK: - Type
enum Type {
    enum Employee:PeopleType {
        enum Hourly:PeopleType {
            case FoodService
            case RideService
            case Maintenance
            
            var access:AreaAccess {
                switch self {
                case .FoodService:
                    return AreaAccess(maintenance: false, rideControll: false, kitchen: true/*, hourlyEmployeeDummy: nil*/)
                case .RideService:
                    return AreaAccess(maintenance: false, rideControll: true, kitchen: false/*, hourlyEmployeeDummy: nil*/)
                case .Maintenance:
                    return AreaAccess(maintenance: true, rideControll: true, kitchen: true/*, hourlyEmployeeDummy: nil*/)
                }
            }
        }
        case Manager
        
        var access:AreaAccess {
            switch self {
            case .Manager:
                return AreaAccess(allAcess: true)
            }
        }
    }
    
    enum Guest:PeopleType {
        case Classic
        case FreeChild
        case VIP
        
        var access: AreaAccess {
            return AreaAccess(allAcess: false)
        }
    }
}

struct AreaAccess {
    let amusement:Bool
    let maintenance:Bool
    let office:Bool
    let rideControll:Bool
    let kitchen:Bool
    let rides:Bool
    let foodDiscountPourcent:Int?
    let merchandiseDiscountPourcent:Int?
    
    //General Init
    init(amusement:Bool, maintenance:Bool, office:Bool, rideControll:Bool, kitchen:Bool, rides:Bool, foodDiscountPourcent:Int?, merchandiseDiscountPourcent:Int?){
        self.amusement = amusement
        self.maintenance = maintenance
        self.office = office
        self.rideControll = rideControll
        self.kitchen = kitchen
        self.rides = rides
        self.foodDiscountPourcent = foodDiscountPourcent
        self.merchandiseDiscountPourcent = merchandiseDiscountPourcent
    }
    
    //Hourly employee Init
    init(amusement:Bool = true, maintenance:Bool, office:Bool = false, rideControll:Bool, kitchen:Bool, rides:Bool = true,foodDiscountPourcent:Int = 15,merchandiseDiscountPourcent:Int = 25/*, hourlyEmployeeDummy:Any?*/){
    self.init(amusement:amusement,maintenance:maintenance,office:office,rideControll:rideControll,kitchen:kitchen,rides:rides,foodDiscountPourcent:foodDiscountPourcent,merchandiseDiscountPourcent:merchandiseDiscountPourcent)
    }
    
    //Manager employee Init
    init(allAcess:Bool){
        if allAcess {
            self.init(amusement:true,maintenance:true,office:true,rideControll:true,kitchen:true,rides:true,foodDiscountPourcent:25,merchandiseDiscountPourcent:25)
        } else {
            self.init(amusement:false,maintenance:false,office:false,rideControll:false,kitchen:false,rides:false,foodDiscountPourcent:nil,merchandiseDiscountPourcent:nil)
        }
    }
}

struct PeopleInfo {
    let firstName:String?
    let lastName:String?
    let dateOfBirth:NSDate?
    let streetAdress:String?
    let city:String?
    let zipCode:String?
    let state:String?
    let socialSecurityNumber:(Int,Int,Int)?
    let company:String?
    let managementTier:ManagementTier?
    
    //General Init
    init(firstName:String, lastName:String, dateOfBirth:NSDate, streetAdress:String, city:String, zipCode:String, state:String, socialSecurityNumber:(Int,Int,Int),company:String, managementTier:ManagementTier){
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.streetAdress = streetAdress
        self.city = city
        self.zipCode = zipCode
        self.state = state
        self.socialSecurityNumber = socialSecurityNumber
        self.company = company
        self.managementTier = managementTier
    }
    
    
    
    //Classic And VIP Guest init
    init(firstName:String?, lastName:String?, dateOfBirth:NSDate?, streetAdress:String?, city:String?, zipCode:String?, state:String?, socialSecurityNumber:(Int,Int,Int)?,company:String?, managementTier:ManagementTier?){
        self.init(firstName:nil,lastName: nil,dateOfBirth: nil,streetAdress: nil,city: nil,zipCode: nil,state: nil,socialSecurityNumber: nil,company: nil,managementTier: nil)
    }
    
    //Hourly employee init
    init(firstName:String, lastName:String, dateOfBirth:NSDate, streetAdress:String, city:String, zipCode:String, state:String, socialSecurityNumber:(Int,Int,Int),company:String? = nil, managementTier:ManagementTier? = nil){
        self.init(firstName:firstName,lastName: lastName,dateOfBirth: dateOfBirth,streetAdress: streetAdress,city: city,zipCode: zipCode,state: state,socialSecurityNumber: socialSecurityNumber,company: company,managementTier: managementTier)
    }
}

enum ManagementTier {
    case General
    case Senior
    case Shift
}

struct EmployeeFoodService:EmployeeFoodServiceType {
    let access:AreaAccess = Type.Employee.Hourly.FoodService.access
    let info: PeopleInfo
}





