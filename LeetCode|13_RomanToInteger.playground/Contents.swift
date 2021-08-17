import UIKit

func romanToInt(romanNumber string: String) -> Int {
    var result: Int = 0
    let charArr: Array<Character> = string.map { $0 }
    var i: Int = 0;
    
    charArr.forEach { character in
        switch  character {
        case "I":
            result += 1
        case "V":
            if  (i - 1) >= 0,
                charArr[i-1] == "I" {
                result -= 1
                result += 4
            } else {
                result += 5
            }
        case "X":
            if  (i - 1) >= 0,
                charArr[i-1] == "I" {
                result -= 1
                result += 9
            } else {
                result += 10
            }
        case "L":
            if  (i - 1) >= 0,
                charArr[i-1] == "X" {
                result -= 10
                result += 40
            } else {
                result += 50
            }
        case "C":
            if  (i - 1) >= 0,
                charArr[i-1] == "X" {
                result -= 10
                result += 90
            } else {
                result += 100
            }
        case "D":
            if  (i - 1) >= 0,
                charArr[i-1] == "C" {
                result -= 100
                result += 400
            } else {
                result += 500
            }
        case "M":
            if  (i - 1) >= 0,
                charArr[i-1] == "C" {
                result -= 100
                result += 900
            } else {
                result += 1000
            }
        default:
            print("Error: Undefined case")
            break
        }
        i += 1
    }
    return result
}


let res = romanToInt(romanNumber: "MMMCMXCIX")
let res2 = romanToInt(romanNumber: "XMVMXXMVV")
print(res2)
