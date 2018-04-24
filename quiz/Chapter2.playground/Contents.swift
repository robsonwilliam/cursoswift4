//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str = "Hello Swift"
let constStr = str
//constStr = "Hello Word!"
var nextYear: Int
var bodyTemp: Float
var hasPet: Bool

//Using arrays
//var arrayOfInts: Array<Int>.ArrayLiteralElement
var arrayOfInts: [Int]

//Using Dictionary
//var dictionaryCapitalsByCountry: Dictionary<String, String>
var dictionaryCapitalsByCountry: [String: String]

//Using Set
var winningLotteryNumbers: Set<Int>

//let number = 42
let fmStation = 91.1

//let countinUp = ["one", "two"]
let nameByParkingSpace = [13: "Alice", 27: "Bob"]

//let secondElement = countinUp[1]


//Using Initializers
let emptyString = String()
let emptyArrayOfInts = [Int]()
let emptySetOfFloats = Set<Float>()


//other types have default values
let defaultNumber = Int()
let defaultBool = Bool()

let number = 42
let meaningOfLife = String(number)

let availableRooms = Set([205,411,412])

let defaultFloat = Float()
let floatFromLiteral = Float(3.14)

let easyPi = 3.14
let floatFromDouble = Float(easyPi)
let floatingPi = Float(3.14)

//Understanding Properties
var  countingUp = ["1-one", "2-two"]
let secondElement = countingUp[1]
countingUp.count
countingUp.append("three-3")

//Using Optional
var anOptionalFloat : Float?
var anOptionalArrayOfStrings : [String]?
var anOptionalArrayOfOptionsStrings : [String?]?

for quantidade in countingUp{
    print(quantidade)
}


for i in countingUp{
    print("enviando msg... \(i)")
}

//var rading1: Float
//var rading2: Float
//var rading3: Float

var reading1: Float?
var reading2: Float?
var reading3: Float?

reading1 = 9.8
reading2 = 9.2
reading3 = 9.7
print("Olha ai  \(reading1!)")

//let avgReading = (reading1 + reading2 + reading3) / 3
//let avgReading2 = (reading1! + reading2! + reading3!) / 3

if let r1 = reading1,
    let r2 = reading2,
    let r3 = reading3 {

    let avgReading = (r1 + r2 + r3) / 3
} else {
    let errorString = " Instrumentet reported a realiz what was nil"
}

//Working with Enum
enum PieType{
    case apple
    case cherry
    case pecan
}
let favoritePie = PieType.apple

let name: String
switch favoritePie {
case .apple:
    name = "Apple"
case .cherry:
    name = "Cherry"
default:
    name = "Pecan"
}

//Enum and raw values

enum PieTyp: Int {
    case apple = 1
    case cherry
    case pecan
}

let pieRawValue = PieTyp.pecan.rawValue
if let pieTyp = PieTyp(rawValue: pieRawValue){
    //eh um tipo valido!!
}


let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]



