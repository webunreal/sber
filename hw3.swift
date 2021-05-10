import UIKit

final class SomeClass<T> {
    
    var someClassVar: T
    
    init(someClassVar: T) {
        self.someClassVar = someClassVar
    }
}

struct SomeStruct<T> {
    
    var someReferenceVar: SomeClass<T>
    
    init(someClassVar: T) {
        someReferenceVar = SomeClass(someClassVar: someClassVar)
    }
    
    var someStructVar: T {
        get {
            someReferenceVar.someClassVar
        }
        set {
            if !isKnownUniquelyReferenced(&someReferenceVar) {
                someReferenceVar = SomeClass(someClassVar: newValue)
                return
            }
            someReferenceVar.someClassVar = newValue
        }
    }
}
