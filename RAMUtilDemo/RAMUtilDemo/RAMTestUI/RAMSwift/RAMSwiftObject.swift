//
//  RAMSwiftObject.swift
//  RAMUtilDemo
//
//  Created by rambo on 2020/1/21.
//  Copyright © 2020 裘俊云. All rights reserved.
//

import UIKit
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension Notification.Name {
    static let myNoti = Notification.Name("myNoti")
}

class RAMSwiftObject: NSObject {
    
    func test() -> Void {
        print(sortedSquares([-4,-1,0,3,10]))
        print(minSubArrayLen(11, [1,2,3,4,5]))
        print(isAnagram("abc", "acb"))
        print(fourSumCount([1,2], [-1,-2], [-1,2], [0,2]))
        print(threeSum([-13,5,13,12,-2,-11,-1,12,-3,0,-3,-7,-7,-5,-3,-15,-2,14,14,13,6,-11,-11,5,-15,-14,5,-5,-2,0,3,-8,-10,-7,11,-5,-10,-5,-7,-6,2,5,3,2,7,7,3,-10,-2,2,-12,-11,-1,14,10,-9,-15,-8,-7,-9,7,3,-2,5,11,-13,-15,8,-3,-7,-12,7,5,-2,-6,-3,-10,4,2,-5,14,-3,-1,-10,-3,-14,-4,-3,-7,-4,3,8,14,9,-2,10,11,-10,-4,-15,-9,-1,-1,3,4,1,8,1]))
        print(threeSum([0,0,0,0]))
        var s: [Character] = ["h","e","l","l","o"]
        reverseString(&s)
        print(s)
        print(reverseStr("a", 2))
        print(isValid("]"))
        print(combine(0,1))
        print(findContentChildren([1,2,3],[1,1]))
        testHighFunc()
    }
    
    func testHighFunc() {
        // 高阶函数用法
        let test1 = [1, 2, 3, 4]
        let squares = test1.map { $0 * $0 }
        print(squares)
        let test2 = ["rambo", "jhon", "", "test"]
        let nonil = test2.compactMap { (str) -> String? in
            if str.count > 0 {
                return str
            } else {
                return nil
            }
        }
        print(nonil)
        test1.filter { $0 > 2 }
        
        let latticeNumbers = [[1, Optional(2), 3], [3, nil, 5]]
        // 解析首层元素, 若没有nil, 则会降维
        let flatMapArr = latticeNumbers.flatMap { $0 }
        print(flatMapArr)
        
        let numbers = [7, 6, 10, 9, 8, 1, 2, 3, 4, 5]
        // 找到第一个满足小于10的条件就跳出循环
        let prefixArr = numbers.prefix { $0 < 10 }
        print(prefixArr)
        // [7, 6]
        let dropArr = numbers.drop { $0 < 10 }
        print(dropArr)
        let dropFirstArr = numbers.dropFirst(3)
        print(dropFirstArr)
        let dropLastArr = numbers.dropLast(5)
        print(dropLastArr)
        
        if #available(iOS 13.0, *) {
            let test = NotificationCenter.default.publisher(for: .myNoti).map { notification in
                return notification.userInfo?["data"]
            }
            print(test)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func greet(person: String = "Tom") -> String {
        let greeting = "Hello, " + person + "!"
        return greeting
    }
    
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let tmp = a;
        a = b;
        b = tmp;
    }
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    override init() {
        super.init();
        print(arithmeticMean(1, 2, 3, 4, 5));
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        var reversedNames = names.sorted { (_ s1: String, _ s2: String) -> Bool in
            return s1 > s2
        }
        print(reversedNames)
    }
    
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var i = 0
        for var j in 0..<nums.count {
            if nums[j] != val {
                nums[i] = nums[j]
                i += 1
            }
        }
        return i
    }
    
    func sortedSquares(_ nums: [Int]) -> [Int] {
        var result = [Int](repeating: -1, count: nums.count)
        var i = 0, j = nums.count - 1
        var index = nums.count - 1
        while (i <= j) {
            if (abs(nums[i]) <= abs(nums[j])) {
                result[index] = nums[j] * nums[j]
                j -= 1
            } else {
                result[index] = nums[i] * nums[i]
                i += 1
            }
            index -= 1
        }
        return result
    }
    
    
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        print(nums)
        var total = 0
        for num in nums {
            total += num
        }
        if (total == target) {
            return nums.count
        } else if (total > target) {
            let left = minSubArrayLen(target, Array(nums[0...(nums.count - 2)]))
            let right = minSubArrayLen(target, Array(nums[1...(nums.count - 1)]))
            if left == 0 {
                return right
            }
            if right == 0 {
                return left
            }
            return min(left, right)
        } else {
            return 0
        }
    }
    
    
    
    func generateMatrix(_ n: Int) -> [[Int]] {
        var result = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        var direct = 0 // 0 右 1 下 2 左 3上
        var current = 1
        var x = 0, y = 0
        while (current <= n * n) {
            result[x][y] = current
            switch direct {
                case 0:
                    x += 1
                    if x == n || result[x][y] != 0 {
                        x -= 1
                        y += 1
                        direct = 1
                    }
                case 1:
                    y += 1
                    if y == n || result[x][y] != 0 {
                        y -= 1
                        x -= 1
                        direct = 2
                    }
                case 2:
                    x -= 1
                    if x < 0 || result[x][y] != 0 {
                        x += 1
                        y -= 1
                        direct = 3
                    }
                case 3:
                    y -= 1
                    if y < 0 || result[x][y] != 0 {
                        y += 1
                        x += 1
                        direct = 0
                    }
                default: break
            }
            current += 1
        }
        return result
    }
    
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        
        let sc = s.map { $0 }.sorted { $0 > $1 }
        let tc = t.map { $0 }.sorted { $0 > $1 }
        for i in 0..<s.count {
            if sc[i] != tc[i] {
                return false
            }
        }
        return true
    }
    
    func isAnagram2(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        var result: [Int] = [Int](repeating: 0, count: 26)
        let start = "a".unicodeScalars.first!.value
        for sc in s.unicodeScalars {
            result[Int(sc.value - start)] += 1
        }
        for tc in t.unicodeScalars {
            result[Int(tc.value - start)] -= 1
        }
        for r in result {
            if r != 0 {
                return false
            }
        }
        return true
    }
    
    func fourSumCount(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int], _ nums4: [Int]) -> Int {
        var leftM: [Int: Int] = [:]
        for i in 0..<nums1.count {
            for j in 0..<nums2.count {
                let sum: Int = 0 - nums1[i] - nums2[j]
                if leftM[sum] == nil {
                    leftM[sum] = 1
                } else {
                    leftM[sum]! += 1
                }
            }
        }
        var count = 0
        for i in 0..<nums3.count {
            for j in 0..<nums4.count {
                let sum: Int = nums3[i] + nums4[j]
                guard let cc = leftM[sum] else { continue }
                count += cc
            }
        }
        return count
    }
    
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var map: [Character: Int] = [:]
        for c in ransomNote.indices {
            if map[ransomNote[c]] == nil {
                map[ransomNote[c]] = 1
            } else {
                map[ransomNote[c]]! += 1
            }
        }
        for c in magazine.indices {
            if map[magazine[c]] != nil && map[magazine[c]] != 0 {
                map[magazine[c]]! -= 1
            }
        }
        for (_ , value) in map {
            if value != 0 {
                return false
            }
        }
        return true
    }
    
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let sortArr = nums.sorted { $0 < $1 }
        var result: [[Int]] = []
        for i in 0..<sortArr.count {
            if i > 0 && sortArr[i] == sortArr[i-1] {
                continue
            }
            var left = i + 1
            var right = sortArr.count - 1
            while left < right {
                if (sortArr[i] + sortArr[left] + sortArr[right] == 0) {
                    result.append([sortArr[i], sortArr[left], sortArr[right]])
                    left += 1
                    while left < sortArr.count && sortArr[left] == sortArr[left-1] {
                        left += 1
                    }
                } else if (sortArr[i] + sortArr[left] + sortArr[right] < 0) {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        return result
    }
    
    func reverseString(_ s: inout [Character]) {
        var i = 0, j = s.count - 1
        while (i < j) {
            let tmp = s[i]
            s[i] = s[j]
            s[j] = tmp
            i += 1
            j -= 1
        }
    }
    
    func reverseStr(_ s: String, _ k: Int) -> String {
        var chars = Array(s)
        chars.popLast()
        var left = 0, right = k - 1, index = 2 * k - 1
        while (index < s.count || left < s.count) {
            if right >= s.count {
                right = s.count - 1
            }
            
            while (left < right) {
                (chars[left], chars[right]) = (chars[right], chars[left])
                left += 1
                right -= 1
            }
            left = index + 1
            right = index + k
            index += 2 * k
        }
        return String(chars)
    }
    
    func isValid(_ s: String) -> Bool {
        var stack: [Character] = []
        for chr in s {
            switch chr {
                case "(":
                    stack.append(")")
                case "{":
                    stack.append("}")
                case "[":
                    stack.append("]")
                default:
                    if !stack.isEmpty {
                        if chr != stack.removeFirst() {
                            return false
                        }
                    }
            }
        }
        return stack.isEmpty
    }
    
    
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        if n <= 0 || k <= 0 {
            return [[]]
        }
        if k > n { return [[]] }
        if k == n {
            var sumi: [Int] = []
            for i in (1...n).reversed() {
                sumi.append(i)
            }
            return [sumi]
        }
        var sum:[[Int]] = []
        for i in (1...n).reversed() {
            if i < k { break }
            var sumi: [Int] = []
            sumi.append(i)
            for s in combine(i - 1, k - 1) {
                var tpms = sumi;
                tpms += s
                sum.append(tpms)
            }
        }
        return sum
    }
    
    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        if s.count == 0 || g.count == 0 { return 0 }
        let gs = g.sorted { $0 > $1 }
        let ss = s.sorted { $0 > $1 }
        var gj = 0
        var sum = 0
        for si in ss {
            if gj >= gs.count {
                return sum
            }
            while si < gs[gj] {
                if gj >= gs.count {
                    return sum
                }
                gj += 1
            }
            sum += 1
            gj += 1
        }
        
        return sum
    }
}
