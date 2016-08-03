//
//  Access.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Alex Millius on 03.08.16.
//  Copyright © 2016 TumTum. All rights reserved. 
//


protocol DiscountAccessible {
    var foodDiscountPourcent:Discount? { get }
    var merchandiseDiscountPourcent:Discount? { get }
    // If you add a property, you have to add a case in the Area enum
}

protocol AreaAccessible {
    var amusement:Bool { get }
    var maintenance:Bool { get }
    var kitchen:Bool { get }
    var office:Bool { get }
    // If you add a property, you have to add a case in the Area enum
}

protocol RideAccessible {
    var rideControll:Bool { get }
    var skipLines:Bool { get }
    // If you add a property, you have to add a case in the Area enum
}

enum Area {
    //rides accessible
    case rideControll, skipLines
    //areas accissible
    case  amusement, maintenance, kitchen, office, rides
    //discount accessible
    case foodDiscount, merchandiseDiscount
}

enum Discount {
    case food(Int)
    case merchandise(Int)
}

struct Access: AreaAccessible, DiscountAccessible, RideAccessible {
    let amusement:Bool
    let maintenance:Bool
    let kitchen:Bool
    let office:Bool
    let rides:Bool
    
    let rideControll:Bool
    let skipLines:Bool
    
    let foodDiscountPourcent:Discount?
    let merchandiseDiscountPourcent:Discount?
    
    //General Init
    init(amusement:Bool, maintenance:Bool, office:Bool, rideControll:Bool, kitchen:Bool, rides:Bool, skipLines:Bool, foodDiscountPourcent:Discount?, merchandiseDiscountPourcent:Discount?){
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
        self.init(amusement:true,maintenance:maintenance,office:false,rideControll:rideControll,kitchen:kitchen,rides:true,skipLines:false,foodDiscountPourcent:Discount.food(15),merchandiseDiscountPourcent:Discount.merchandise(25))
    }
    
    //Manager employee Init
    init(allAcess:Bool,skipLines:Bool){
        if allAcess {
            self.init(amusement:true,maintenance:true,office:true,rideControll:true,kitchen:true,rides:true,skipLines:skipLines,foodDiscountPourcent:Discount.food(25),merchandiseDiscountPourcent:Discount.merchandise(25))
        } else {
            self.init(amusement:false,maintenance:false,office:false,rideControll:false,kitchen:false,rides:false,skipLines:skipLines,foodDiscountPourcent:nil,merchandiseDiscountPourcent:nil)
        }
    }
    
    //Guest Init
    init(skipLines:Bool,foodDiscountPourcent:Discount?, merchandiseDiscountPourcent:Discount?){
        self.init(amusement:true,maintenance:false,office:false,rideControll:false,kitchen:false,rides:true,skipLines:skipLines,foodDiscountPourcent:foodDiscountPourcent,merchandiseDiscountPourcent:merchandiseDiscountPourcent)
    }
}
