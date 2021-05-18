import UIKit

// MARK: - Задача 3*. К выполнению необязательна. 

indirect enum ListNode<T> {
    case node(element: T, next: ListNode<T>?)
    case end
}

struct List<T> {
    var head: ListNode<T>
}

let list = List<Int>(head: ListNode.node(element: 1, next: ListNode.node(element: 2, next: ListNode.node(element: 3, next: ListNode.end))))
