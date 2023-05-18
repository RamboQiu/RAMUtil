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
//        testHighFunc()
        print("------------")
        print(headtail(["ab","bc","cd","da","ae","ef","fa","cg","gh","hc"]))
        print(headtail2(["ab","bc","cd","da","ae","ef","fa","cg","gh","hc"]))
        print(headtail3(["ab","bc","cd","da","ae","ef","fa","cg","gh","hc","aa"]))
        
        var input = [[0,0,0,0,0,0],[1,0,1,0,1,1],[0,1,0,1,1,0],[-1,-1,-1,0,0,0]]
        print(updateMatrix(&input))
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
    
    // 传入字符串数组判断是否可以首位相连形成环
    //  ["gj","jl","dg","ad","gg"]
    func headtail(_ list: [String]?) -> Bool {
        // 用动态规划试试
        guard let list = list else { return true }
        for (index, item) in list.enumerated() {
            var nextList = list
            nextList.remove(at: index)
            let resut = juade(item, nextList)
            if resut.0 {
                let lastStr = resut.1
                if item.first == lastStr.last {
                    return true
                }
            }
        }
        return false
    }
    
    func juade(_ head: String, _ list: [String]) -> (Bool, String) {
        if list.count == 0 {
            return (false, "")
        }
        let tail: Character = head.last!
        if list.count == 1 {
            let firstr = list.first!
            if firstr[head.startIndex] == tail {
                return (true, firstr)
            }
        }
        for (index, item) in list.enumerated() {
            if item.first == tail {
                var nextList = list
                nextList.remove(at: index)
                return juade(item, nextList)
            }
        }
        return (false, "")
    }
    
    // 拼多多面试题
    // 传入字符串数组判断是否可以首位相连形成环
    // https://blog.csdn.net/Bazinga521/article/details/97623572
    //  ["gj","jl","dg","ad","gg"]
    // 出现出度>0，且没法消费掉的，就说明这个节点没法进入环中
    // 尝试使用向量图的方式没法解决，向量图只能判断当前图中是否有环，并不能判断出是否所有元素形成一个大环
    func headtail2(_ list: [String]?) -> Bool {
        // 通过有向图的方法进行解答
        // 一次遍历算出每个字符的度是多少
        guard let list = list else { return true }
        // 1. 生成邻接矩阵
        var graph = [[Int]](repeating: [Int](repeating: 0, count: 26), count: 26)
        let start = "a".unicodeScalars.first!.value
        var chudu: [Int: Int] = [:]
        for item in list {
            let x = item.unicodeScalars.first!.value - start
            let y = item.unicodeScalars.last!.value - start
            graph[Int(x)][Int(y)] = 1
            if chudu[Int(x)] == nil {
                chudu[Int(x)] = 1
            } else {
                chudu[Int(x)]! += 1
            }
        }
        
        // 从任意字符串开始
        var next = Int(list.first!.unicodeScalars.first!.value - start)
        let begin = next
        while next != -1 {
            for tail in 0..<26 {
//                print("\(next)+\(tail)")
                if graph[Int(next)][tail] != 0 {
                    let tailcd = chudu[tail]
                    if tailcd != nil && tailcd! > 0 {
                        graph[Int(next)][tail] -= 1
                        chudu[Int(next)]! -= 1
                        next = tail
//                        print("next:\(next)")
                        break
                    } else if Int(chudu[next]!) > 1 {
                        if tail == 25 {
                            next = -1
                        }
                        continue
                    } else if tail == begin {
                        graph[Int(next)][tail] -= 1
                        chudu[Int(next)]! -= 1
                        next = -1
//                        print("next:\(next)")
                        break
                    } else {
                        return false
                    }
                }
            }
        }
        for (_, cc) in chudu.enumerated() {
            if cc.value > 0 {
                return false
            }
        }
        
        return true
    }
    
    // https://blog.csdn.net/Bazinga521/article/details/97623572
    // 使用另一种方案
    // 将所有字符串进行所有可能的首尾连接的情况下判断最末尾和最开始的单词是否收尾相同，有相同就flag=true并return
    // 全排列所有的可行链接
    // 固定一个单词，然后遍历其他的查找是否能接尾的，找到就进行和他后面的替换动作，替换完之后接着遍历固定第二个，递归遍历完了，就将第二个换回来，重新跳过进行查找
    var flag = false
    func headtail3(_ list: [String]?) -> Bool {
        guard var list = list else {
            return true
        }
        if list.count == 0 {
            return true
        }
        if list.count == 1 {
            return list[0].first == list[0].last
        }
        
        linkheadtail(&list, list.count, 1)
        
        return flag
    }
    
    func linkheadtail(_ list: inout [String], _ n: Int, _ k: Int) {
        
        if n == k {
            // 遍历到最后一个了
            if list[k-1].last == list[0].first {
                flag = true
                return
            }
        }
        
        for index in k..<list.count {
            if list[k-1].last == list[index].first {
                swapworld(&list, k, index) // 交换顺序
                linkheadtail(&list, n, k+1) // 接着递归查接下来的能够连接的
                swapworld(&list, k, index) // 重置过来，i接着偏移，也就是跳过命中了i的那一个相同的，看看后续还有没有其他case
            }
        }
        
    }
    
    func swapworld(_ list: inout [String], _ a: Int, _ b: Int) {
        let tmp = list[a]
        list[a] = list[b]
        list[b] = tmp
    }
    
    
    func updateMatrix(_ mat: inout [[Int]]) -> [[Int]] {

        var queue: [(Int, Int)] = []

        for (indexx, x) in mat.enumerated() {
            for (indexy, y) in x.enumerated() {
                if y == 0 {
                    queue.append((indexx, indexy))
                } else {
                    mat[indexx][indexy] = -1
                }
            }
        }
        
        let x = [-1, 0, 1, 0]
        let y = [0, -1, 0, 1]
        
        while !queue.isEmpty {
            let target = queue.removeFirst()
            for i in 0..<4 {
                let indexx = target.0 + x[i]
                let indexy = target.1 + y[i]
                if indexx >= 0 &&
                    indexx < mat.count &&
                    indexy >= 0 &&
                    indexy < mat[0].count &&
                    mat[indexx][indexy] == -1 {
                    mat[indexx][indexy] = mat[target.0][target.1] + 1
                    queue.append((indexx, indexy))
                }
            }
        }
        
        return mat


    }
    
}
