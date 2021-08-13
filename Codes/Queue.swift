import Foundation

protocol Queue {
    associatedtype T
    
    mutating func push(_ value: T)
    mutating func pop() -> T?
    
    var isEmpty: Bool { get }
    var peek: T? { get }
}

// push O(1), pop O(n)
struct QueueWithArray<T>: Queue {
    private var arr = [T]()
    
    init() {}
    
    var isEmpty: Bool {
        return self.arr.isEmpty
    }
    
    var peek: T? {
        return self.arr.first
    }
    
    mutating func push(_ value: T) {
        self.arr.append(value)
    }
    
    mutating func pop() -> T? {
        return isEmpty ? nil : self.arr.removeFirst()
    }
}


// push O(1), pop O(1)
struct QueueWithDoubleStack<T>: Queue {
    private var inStack = [T]()
    private var outStack = [T]()
    
    init() {}
    
    var isEmpty: Bool {
        return inStack.isEmpty && outStack.isEmpty
    }
    
    var peek: T? {
        return outStack.isEmpty ? inStack.first : outStack.last
    }
    
    mutating func push(_ value: T) {
        inStack.append(value)
    }
    
    mutating func pop() -> T? {
        if outStack.isEmpty {
            while !inStack.isEmpty {
                outStack.append(inStack.removeLast())
            }
        }
        
        return outStack.popLast()
    }
}

