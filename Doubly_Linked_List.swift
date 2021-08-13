class Node<T> {
    var value: T
    var prev: Node<T>?
    var next: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}

class DoublyLinkedList<T: Equatable> {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    var description: String {
        var str = ""
        var currentNode = head
        
        while let node = currentNode {
            str += "\(node.value) "
            
            if node.next != nil {
                str += "-> "
            }
            
            currentNode = node.next
        }
        
        return str
    }
    
    func append(_ value: T) {
        let newNode = Node<T>(value: value)
        
        if head == nil || tail == nil {
            head = newNode
            tail = head
            return
        }
        
        tail?.next = newNode
        newNode.prev = tail
        tail = newNode
    }
    
    func removeLast() {
        if head == nil || tail == nil {
            return
        }
        
        if head?.next == nil {
            head = nil
            tail = nil
            return
        }
        
        tail?.prev?.next = tail?.next
        tail = tail?.prev
    }
    
    func findNodeFromTail(value: T) -> Node<T>? {
        if head == nil || tail == nil {
            return nil
        }
        
        var currentNode = tail
        
        while let node = currentNode {
            if node.value == value {
                break
            }
            
            currentNode = node.prev
        }
        
        return currentNode
    }
}
