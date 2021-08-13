import Foundation

class Node<T> {
    var value: T
    var next: Node?
    
    init(value: T) {
        self.value = value
    }
}

class LinkedList<T: Equatable> {
    private var head: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var description: String {
        var currentNode = head
        var answer = ""
        
        while let node = currentNode {
            answer += "\(node.value) "
            
            if node.next != nil {
                answer += "-> "
            }
            
            currentNode = node.next
        }
        
        return answer
    }
    
    func append(_ value: T) {
        let node = Node<T>(value: value)
        
        guard head != nil else {
            return head = node
        }
        
        var currentNode = head
        
        while let node = currentNode?.next {
            currentNode = node
        }
        
        currentNode?.next = node
    }
    
    // 헤드가 없으면 생성, index가 boundary를 넘어갈 시 마지막에 추가
    func insert(_ value: T, at index: Int) {
        let node = Node<T>(value: value)
        
        if head == nil {
            return head = node
        }
        
        var currentNode = head
        
        for _ in 0..<(index - 1) {
            if currentNode?.next == nil {
                break
            }
            
            currentNode = currentNode?.next
        }
        
        let nextNode = currentNode?.next
        currentNode?.next = node
        currentNode?.next?.next = nextNode
    }
    
    func removeLast() {
        if head == nil {
            return
        }
        
        if head?.next == nil {
            return head = nil
        }
        
        var node = head
        
        while node?.next?.next != nil {
            node = node?.next
        }
        
        node?.next = nil
    }
    
    func remove(at index: Int) {
        if head == nil {
            return
        }
        
        if index == 0 || head?.next == nil {
            return head = head?.next
        }
        
        var node = head
        
        for _ in 0..<(index - 1) {
            if node?.next?.next == nil {
                break
            }
            
            node = node?.next
        }
        
        node?.next = node?.next?.next
    }
    
    func findNode(_ value: T) -> Node<T>? {
        if head == nil {
            return nil
        }
        
        var node = head
        
        while node != nil {
            if node?.value == value {
                break
            }
            
            node = node?.next
        }
        
        return node
    }
}
