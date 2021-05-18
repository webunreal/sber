import UIKit

// MARK: - Задача 2

protocol Container {
    associatedtype Element
    var count: Int { get }
    mutating func add(_ element: Element)
    subscript(index: Int) -> Element? { get }
}

struct FIFO<T>: Container {
    typealias Element = T
    private var elements: [T] = []
    var count: Int {
        elements.count
    }

    subscript(index: Int) -> T? {
        if index >= 0 {
            return elements[index]
        }
        return nil
    }
    
    mutating func add(_ element: T) {
        elements.append(element)
    }
    
    mutating func get() -> T? {
        elements.removeFirst()
    }
}



class ListNode<T> {
    var id = UUID()
    var element: T
    var next: ListNode?
    weak var previous: ListNode?
    
    init(element: T) {
        self.element = element
    }
}

class List<T>: Container {
    typealias Element = T
    
    private var head: ListNode<T>?
    private var tail: ListNode<T>?
    
    var isEmpty: Bool {
        head == nil
    }
    
    var first: ListNode<T>? {
        head
    }
    
    var last: ListNode<T>? {
        tail
    }
    
    private var elements: [ListNode<T>] = []
    
    var count: Int {
        elements.count
    }
    
    subscript(index: Int) -> T? {
        if index >= 0 {
            return elements[index].element
        }
        return nil
    }
    
    func add(_ element: T) {
        let newListNode = ListNode(element: element)
        
        if let tailNode = tail {
            newListNode.previous = tailNode
            tailNode.next = newListNode
        } else {
            head = newListNode
        }
        tail = newListNode
        elements.append(newListNode)
    }
    
    func delete(element: ListNode<T>) -> T {
        let previous = element.previous
        let next = element.next
        
        if let previous = previous {
            previous.next = next
        } else {
            head = next
        }
        next?.previous = previous
        
        if next == nil {
            tail = previous
        }
        
        element.previous = nil
        element.next = nil
        
        elements.removeAll { $0.id == element.id }
        return element.element
    }
}
