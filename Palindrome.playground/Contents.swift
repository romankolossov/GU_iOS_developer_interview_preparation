import UIKit

enum PalindromeError : Error {
    case statementIsNotPalindrome
}

// First approach

func palindrome(_ string: String) -> Bool {
    let plainString = string.filter {
        $0 != " " &&
        $0 != ","
    }.lowercased()

    var chrArr: Array<Character> = plainString.map { $0 }
    var i: Int
    
    if (chrArr.count % 2) == 0 {
        i = chrArr.count / 2
    } else {
        i = chrArr.count / 2 + 1
    }

    repeat {
        if chrArr.first == chrArr.last {
            if chrArr.count > 1 {
                chrArr.removeFirst()
                chrArr.removeLast()
                i -= 1
            } else {
                print("The expression is a palindrome")
                return true
            }
        } else {
            print("The expression is not a palindrome")
            return false
        }
    } while i > 0
    
    print("The expression is a palindrome")
    return true
}

// Second approach

func isPalindrome(_ string: String) -> Bool {
    let plainString = string.filter {
        $0 != " " &&
            $0 != ","
    }.lowercased()
    
    let chrArr: Array<Character> = plainString.map { $0 }
    let numberOfElements = chrArr.count
    var i: Int
    
    i = 0
    do  { try chrArr.forEach {
        let endIndex = numberOfElements - 1 - i
        
        guard $0 == chrArr[endIndex] else {
            throw PalindromeError.statementIsNotPalindrome
        }
        i += 1
    }
    } catch {
        print("The expression is not a palindrome")
        return false
    }
    
    //    for i in 0..<numberOfIterations {
    //        let endIndex = numberOfIterations - 1 - i
    //
    //        guard chrArr[i] == chrArr[endIndex] else {
    //            print("The expression is not a palindrome")
    //            return false
    //        }
    //    }
    
    print("The expression is a palindrome")
    
    return true
}

palindrome("12 3,21")
isPalindrome("123, 21")

