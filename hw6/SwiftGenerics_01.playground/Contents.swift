import UIKit

// MARK: - Задача 1 "Сделать так, чтобы закомментированный код работал"

func sumTwoValues<T: AdditiveArithmetic>(_ a: T, _ b: T) -> T {
	let result = a + b
	return result
}

let a = 25.0
let b = 34.0

let resultDouble = sumTwoValues(a, b)
print(resultDouble)

let c = "ABC"
let d = "DEF"

let resultString = sumTwoValues(c, d)
print(resultString)

extension String: AdditiveArithmetic {
    public static var zero: String {
        ""
    }

    public static func - (lhs: String, rhs: String) -> String {
        var lhsArray = Array(lhs)
        let rhsArray = Array(rhs)
        
        lhsArray.removeAll { rhsArray.contains($0) }
        return String(lhsArray)
    }
}
