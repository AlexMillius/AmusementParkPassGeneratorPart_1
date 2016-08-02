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
    var access:Access { get }
}

//MARK: - Employee Protocol
protocol EmployeeType:PeopleType {
    var info:PeopleInfos { get }
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

//MARK: - Type of people
enum TypeAccess {
    enum Employee:PeopleType {
        enum Hourly:PeopleType {
            case FoodService
            case RideService
            case Maintenance
            
            var access:Access {
                switch self {
                case .FoodService:
                    return Access(maintenance: false, rideControll: false, kitchen: true)
                case .RideService:
                    return Access(maintenance: false, rideControll: true, kitchen: false)
                case .Maintenance:
                    return Access(maintenance: true, rideControll: true, kitchen: true)
                }
            }
        }
        case Manager
        
        var access:Access {
            switch self {
            case .Manager:
                return Access(allAcess: true,skipLines: false)
            }
        }
    }
    
    enum Guest:PeopleType {
        case Classic
        case FreeChild
        case VIP
        
        var access: Access {
            switch self {
            case .Classic:
                return Access(skipLines: false, foodDiscountPourcent: nil, merchandiseDiscountPourcent: nil)
            case .FreeChild:
                return Access(skipLines: false, foodDiscountPourcent: nil, merchandiseDiscountPourcent: nil)
            case .VIP:
                return Access(skipLines: true, foodDiscountPourcent: discount.food(10), merchandiseDiscountPourcent: discount.merchandise(20))
            }
        }
    }
}

enum TypesOfPeople {
    case GuestClassic
    case GuestVIP
    case GuestFreeChild
    case EmployeeFoodService
    case EmployeeRideService
    case EmployeeMaintenance
    case EmployeeManager
}

//MARK: - Area Access
enum discount {
    case food(Int)
    case merchandise(Int)
}

enum Area {
    case amusement
    case maintenance
    case office
    case rideControll
    case kitchen
    case rides
    case skipLines
    case foodDiscount
    case merchandiseDiscount
}

struct Access {
    let amusement:Bool
    let maintenance:Bool
    let office:Bool
    let rideControll:Bool
    let kitchen:Bool
    let rides:Bool
    let skipLines:Bool
    let foodDiscountPourcent:discount?
    let merchandiseDiscountPourcent:discount?
    
    //General Init
    init(amusement:Bool, maintenance:Bool, office:Bool, rideControll:Bool, kitchen:Bool, rides:Bool, skipLines:Bool, foodDiscountPourcent:discount?, merchandiseDiscountPourcent:discount?){
        self.amusement = amusement
        self.maintenance = maintenance
        self.office = office
        self.rideControll = rideControll
        self.kitchen = kitchen
        self.rides = rides
        self.skipLines = skipLines
        self.foodDiscountPourcent = foodDiscountPourcent
        self.merchandiseDiscountPourcent = merchandiseDiscountPourcent
    }
    
    //Hourly employee Init
    init(maintenance:Bool, rideControll:Bool, kitchen:Bool){
    self.init(amusement:true,maintenance:maintenance,office:false,rideControll:rideControll,kitchen:kitchen,rides:true,skipLines:false,foodDiscountPourcent:discount.food(15),merchandiseDiscountPourcent:discount.merchandise(25))
    }
    
    //Manager employee Init
    init(allAcess:Bool,skipLines:Bool){
        if allAcess {
            self.init(amusement:true,maintenance:true,office:true,rideControll:true,kitchen:true,rides:true,skipLines:skipLines,foodDiscountPourcent:discount.food(25),merchandiseDiscountPourcent:discount.merchandise(25))
        } else {
            self.init(amusement:false,maintenance:false,office:false,rideControll:false,kitchen:false,rides:false,skipLines:skipLines,foodDiscountPourcent:nil,merchandiseDiscountPourcent:nil)
        }
    }
    
    //Guest Init
    init(skipLines:Bool,foodDiscountPourcent:discount?, merchandiseDiscountPourcent:discount?){
        self.init(amusement:true,maintenance:false,office:false,rideControll:false,kitchen:false,rides:true,skipLines:skipLines,foodDiscountPourcent:foodDiscountPourcent,merchandiseDiscountPourcent:merchandiseDiscountPourcent)
    }
}

//MARK: - People Infos
enum ManagementTier {
    case General
    case Senior
    case Shift
    case None
}

struct PeopleInfos {
    let firstName:String?
    let lastName:String?
    let dateOfBirth:String?
    let streetAdress:String?
    let city:String?
    let zipCode:Int?
    let state:String?
    let socialSecurityNumber:(Int,Int,Int)?
    let managementTier:ManagementTier
    
    //General Init
    init(firstName:String?, lastName:String?, dateOfBirth:String?, streetAdress:String?, city:String?, zipCode:Int?, state:String?, socialSecurityNumber:(Int,Int,Int)?, managementTier:ManagementTier){
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.streetAdress = streetAdress
        self.city = city
        self.zipCode = zipCode
        self.state = state
        self.socialSecurityNumber = socialSecurityNumber
        self.managementTier = managementTier
    }
    
    //Empty Init
    init(){
        self.firstName = nil
        self.lastName = nil
        self.dateOfBirth = nil
        self.streetAdress = nil
        self.city = nil
        self.zipCode = nil
        self.state = nil
        self.socialSecurityNumber = nil
        self.managementTier = .None
    }
    
    //Free Child init
    init(birthday:String){
        self.init(firstName:nil,lastName: nil,dateOfBirth: birthday, streetAdress: nil,city: nil,zipCode: nil,state: nil,socialSecurityNumber: nil,managementTier: .None)
    }
    
    //Hourly employee init
    init(employeeFirstName:String?, lastName:String?, dateOfBirth:String?, streetAdress:String?, city:String?, zipCode:Int?, state:String?, socialSecurityNumber:(Int,Int,Int)?){
        self.init(firstName:employeeFirstName,lastName: lastName,dateOfBirth: dateOfBirth,streetAdress: streetAdress,city: city,zipCode: zipCode,state: state,socialSecurityNumber: socialSecurityNumber,managementTier: .None)
    }
    
    //Manager init
    init(managementTier:ManagementTier, firstName:String?, lastName:String?, dateOfBirth:String?, streetAdress:String?, city:String?, zipCode:Int?, state:String?, socialSecurityNumber:(Int,Int,Int)?){
        self.init(firstName:firstName,lastName: lastName,dateOfBirth: dateOfBirth,streetAdress: streetAdress,city: city,zipCode: zipCode,state: state,socialSecurityNumber: socialSecurityNumber,managementTier: managementTier)
    }
}

//MARK: - People object
struct GuestClassic:GuestClassicType {
    let access:Access = TypeAccess.Guest.Classic.access
}
struct GuestVIP:GuestVIPType {
    let access: Access = TypeAccess.Guest.VIP.access
}
struct GuestFreeChild:GuestFreeChildType {
    let access: Access = TypeAccess.Guest.FreeChild.access
    let dateOfBirth: NSDate
}
struct EmployeeFoodService:EmployeeFoodServiceType {
    let access:Access = TypeAccess.Employee.Hourly.FoodService.access
    let info: PeopleInfos
}
struct EmployeeRideService:EmployeeRideServiceType {
    let access: Access = TypeAccess.Employee.Hourly.RideService.access
    let info: PeopleInfos
}
struct EmployeeMaintenance:EmployeeMaintenanceType {
    let access: Access = TypeAccess.Employee.Hourly.Maintenance.access
    let info: PeopleInfos
}
struct Manager:EmployeeManagerType {
    let tier: ManagementTier
    let access: Access = TypeAccess.Employee.Manager.access
    let info: PeopleInfos
}





