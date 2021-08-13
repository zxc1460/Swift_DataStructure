import Foundation

class Node<T> {
    var value: T
    var next: Node<T>?
    
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else {
            return "\(value)"
        }
        
        return "\(value) -> " + String(describing: next) + " "
    }
}


struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    init() {}
    
    // 연결리스트가 빈 리스트인지 반환해주는 연산 프로퍼티
    var isEmpty: Bool {
        return head == nil
    }
    
    
    // 맨 앞에 노드 추가
    private mutating func push(_ value: T) {
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    // 특정 위치 노드 반환
    func node(at index: Int) -> Node<T>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    // 맨 뒤에 노드 추가
    mutating func append(_ value: T) {
    
        guard !isEmpty else {
            push(value)
            return
        }
        
        self.tail?.next = Node(value: value)
        self.tail = self.tail?.next
    }
    
    // 특정 노드 뒤에 노드 추가
    mutating func insert(_ value: T, after node: Node<T>) {
        guard tail !== node else {
            append(value)
            return
        }
        
        node.next = Node<T>(value: value, next: node.next)
    }
    
    // 맨 앞의 노드 제거
    mutating func pop() -> T? {
        defer { // 함수 반환 직전 노드 반환
            head = head?.next
            
            if isEmpty {
                tail = nil
            }
        }
        
        return head?.value
    }
    
    // 맨 뒤의 노드 제거
    mutating func removeLast() -> T? {
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        
        return current.value
    }
}

// 연결 리스트를 출력하기 위한 CustomStringConvertible 프로토콜 구현
extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else {
            return "Empty Linked List"
        }
        
        return String(describing: head)
    }
}
