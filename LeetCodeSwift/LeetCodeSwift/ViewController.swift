//
//  ViewController.swift
//  LeetCodeStudy
//
//  Created by Wcg on 2019/12/23.
//  Copyright © 2019 吴朝刚. All rights reserved.
//

import UIKit

extension String {
    subscript (_ i: Int) -> Character {
        get{ return self[index(startIndex,offsetBy: i)] }
    }
    //获取子字符串
    func substingInRange(_ r: Range<Int>) -> String? {
        if r.lowerBound < 0 || r.upperBound > self.count {
            return nil
        }
        let startIndex = self.index(self.startIndex, offsetBy:r.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

// 单链表
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    func desc() -> String {
        
        var desc = ""
        
        var tempNode: ListNode? = self
        while tempNode != nil {
            desc.append(contentsOf: "\(tempNode!.val),")
            tempNode = tempNode?.next
        }
        desc.removeLast()
        
        return desc
    }
}

class ViewController: UIViewController {
    
    let digitNames = [
        0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
        5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
    ]
    let numbers = [16, 58, 510]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let l1 = createNode(nodes: [1,2,3,4,5])
        if let res = removeNthFromEnd(l1, 2) {
            print(res.desc())
        }
    }
    
    /// test
    
    func test1() {
        let nums:[Int] = [2,7,11,15]
        let target = 26
        let res = twoSum(nums, target)
        print(res.description)
    }
    
    func test2() {
        let l1 = createNode(nodes: [0,1])
        let l2 = createNode(nodes: [])
        if let resNode = addTwoNumbers(l1, l2) {
            print(resNode.desc())
        }
    }
    
    func test3() {
        let res = numbers.map { (number) -> String in
            var number = number
            var output = ""
            while number > 0 {
                output = digitNames[number % 10]! + output
                number = number / 10
            }
            return output
        }
        print(res)
    }
    
    func test4() {
        let s = "abcbbcbb"
        let res = lengthOfLongestSubstring(s)
        print(res)
    }
    
    func test5() {
        let num1 = [2,3,5]
        let num2 = [1,4,7,9]
        let res = findMedianSortedArrays(num1, num2)
        print(res)
    }
    
    func test6() {
        let s = "abab"
        let res = longestPalindrome(s)
        print(res)
    }
    
    func test7() {
        let s = "wuchaogang"
        let res = convert(s, 3)
        print(res)
    }
    
    func test8() {
        let num = -9871
        let res = reverse(num)
        print(res)
    }
    
    func test9() {
        let s = "   -12312sadaskjdaksl"
        let res = myAtoi(s)
        print(res)
    }
    
    func test10() {
        let s = "ab"
        let p = ".*c"
        let res = isMatch(s, p)
        print(res)
    }
    /// 闭包
    /// function 功能函数
    
    /// 第一题
    /*
     给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
     
     你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。
     
     示例:
     
     给定 nums = [2, 7, 11, 15], target = 9
     
     因为 nums[0] + nums[1] = 2 + 7 = 9
     所以返回 [0, 1]
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var tempMap:[Int:Int] = [:] // key 是值，value 是索引
        for (index,num) in nums.enumerated() { // 遍历数组
            let complement = target - num  //
            if let index2 = tempMap[complement] {
                return [index2,index]
            } else {
                tempMap[num] = index;
            }
        }
        return [];
    }
    
    /// 第二题
    /*
     给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。
     
     如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。
     
     您可以假设除了数字 0 之外，这两个数都不会以 0 开头。
     
     示例：
     
     输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
     输出：7 -> 0 -> 8
     原因：342 + 465 = 807
     */
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // 定义一个空的头结点
        let bummyNode: ListNode? = ListNode(0) // 这个是存储第一个Node 用作返回
        
        var carray = 0
        var p = l1, q = l2, cur = bummyNode
        while (p != nil || q != nil) {
            // 1.计算
            let x = p?.val ?? 0
            let y = q?.val ?? 0
            let sum = carray + x + y
            
            // 2.赋值当前
            carray = sum / 10
            cur?.next = ListNode(sum % 10)
            
            // 3.赋值之后移动到下一个
            cur = cur?.next
            if p != nil {
                p = p?.next
            }
            if q != nil {
                q = q?.next
            }
        }
        
        // 4.最后循环结束如果carray为1 表示有溢出
        if carray > 0 {
            cur?.next = ListNode(carray)
        }
        return bummyNode?.next
    }
    func createNode(nodes: [Int]) -> ListNode? {
        // 定义一个空的头结点
        let bummyNode = ListNode(0)
        
        // 遍历
        var tempNode = bummyNode
        for val in nodes {
            let node = ListNode(val)
            tempNode.next = node
            tempNode = node
        }
        
        return bummyNode.next
    }
    
    /// 第三题
    /*
     给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
     
     示例 1:
     
     输入: "abcabcbb"
     输出: 3
     解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
     */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var ans = 0, i = 0, j = 0
        let length = s.count
        var set:Set<Character> = [] // 定义一个集合
        
        while i < length && j < length {
            if set.contains(s[j]) {
                set.remove(s[i])
                i += 1
            } else {
                set.insert(s[j])
                j += 1
                ans = max(ans, j - i)
            }
        }
        return ans
    }
    
    /// 第四题
    /*
     给定两个大小为 m 和 n 的有序数组 nums1 和 nums2。
     
     请你找出这两个有序数组的中位数，并且要求算法的时间复杂度为 O(log(m + n))。
     
     你可以假设 nums1 和 nums2 不会同时为空。
     
     示例 1:
     
     nums1 = [1, 3]
     nums2 = [2]
     
     则中位数是 2.0
     示例 2:
     
     nums1 = [1, 2]
     nums2 = [3, 4]
     
     则中位数是 (2 + 3)/2 = 2.5
     */
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        let m = nums1.count
        let n = nums2.count
        if m > n { //保证数组1一定最短
            return findMedianSortedArrays(nums2, nums1)
        }
        var iMin = 0, iMax = m
        let halfLen = (m + n + 1) / 2
        while iMin <= iMax {
            let i = (iMax + iMin) / 2
            let j = halfLen - i
            if i < iMax && nums2[j - 1] > nums1[i] { // i 小了 增加i值
                iMin = i + 1
            } else if i > iMin && nums1[i - 1] > nums2[j] { // i 大了 减小i值
                iMax = i - 1
            } else { // i 刚刚好等式成立
                var maxLeft = 0
                if i == 0 {
                    maxLeft = nums2[j - 1]
                } else if j == 0 {
                    maxLeft = nums1[i - 1]
                } else {
                    maxLeft = max(nums1[i - 1], nums2[j - 1])
                }
                // 当是奇数个时 直接返回左边最大
                if ((m + n) % 2 == 1) {
                    return Double(maxLeft)
                }
                
                var minRight = 0
                if i == m {
                    minRight = nums2[j]
                } else if j == n {
                    minRight = nums1[i]
                } else {
                    minRight = min(nums1[i], nums2[j])
                }
                return (Double)(minRight + maxLeft) / 2.0
            }
        }
        return 0.0
    }
    
    /// 第五题
    /*
     给定一个字符串 s，找到 s 中最长的回文子串。你可以假设 s 的最大长度为 1000。
     
     示例 1：
     
     输入: "babad"
     输出: "bab"
     注意: "aba" 也是一个有效答案。
     示例 2：
     
     输入: "cbbd"
     输出: "bb"
     */
    func longestPalindrome(_ str: String) -> String {
        if (str.count < 1) {
            return ""
        }
        var start = 0, end = 0
        for (i,_) in str.enumerated() {
            let len1 = expandAroundCenter(str, left: i, right: i)
            let len2 = expandAroundCenter(str, left: i, right: i + 1)
            let len = max(len1, len2)
            if len > end - start {
                start = i - (len - 1) / 2
                end = i + len / 2
            }
        }
        guard let range = Range(NSRange.init(location: start, length: end - start + 1)) else {
            return ""
        }
        return str.substingInRange(range) ?? ""
    }
    
    func expandAroundCenter(_ s: String, left: Int, right: Int) -> Int {
        var L = left, R = right
        while L >= 0 && R < s.count && s[L] == s[R] {
            L -= 1
            R += 1
        }
        return R - L - 1;
    }
    
    /// 第六题
    /*
     将一个给定字符串根据给定的行数，以从上往下、从左到右进行 Z 字形排列。
     
     比如输入字符串为 "LEETCODEISHIRING" 行数为 3 时，排列如下：
     
     L   C   I   R
     E T O E S I I G
     E   D   H   N
     之后，你的输出需要从左往右逐行读取，产生出一个新的字符串，比如："LCIRETOESIIGEDHN"。
     
     请你实现这个将字符串进行指定行数变换的函数：
     
     string convert(string s, int numRows);
     */
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows <= 1 {
            return s
        }
        
        var rows : Array<String> = []
        var curRow = 0
        var goingDown = false
        for c in s {
            var str = ""
            if curRow < rows.count {
                str = rows[curRow]
                str.append(c)
                rows[curRow] = str
            } else {
                str.append(c)
                rows.append(str)
            }
            if curRow == 0 || curRow == numRows - 1 {
                goingDown = !goingDown
            }
            curRow += goingDown ? 1 : -1
        }
        var res: String = ""
        for str in rows {
            res = res + str
        }
        return res
    }
    
    /// 第七题
    /*
     给出一个 32 位的有符号整数，你需要将这个整数中每位上的数字进行反转。
     
     示例 1:
     
     输入: 123
     输出: 321
     示例 2:
     
     输入: -123
     输出: -321
     示例 3:
     
     输入: 120
     输出: 21
     注意:
     
     假设我们的环境只能存储得下 32 位的有符号整数，则其数值范围为 [−231,  231 − 1]。请根据这个假设，如果反转后整数溢出那么就返回 0。
     */
    func reverse(_ x: Int) -> Int {
        var res = 0
        var temp = x
        while (temp != 0) {
            res = res * 10 + temp % 10
            if res > 2147483647 || res < -2147483647 {
                return 0
            }
            temp = temp / 10
        }
        return res
    }
    
    /// 第八题
    /*
     请你来实现一个 atoi 函数，使其能将字符串转换成整数。
     
     首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。
     
     当我们寻找到的第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字组合起来，作为该整数的正负号；假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成整数。
     
     该字符串除了有效的整数部分之后也可能会存在多余的字符，这些字符可以被忽略，它们对于函数不应该造成影响。
     
     注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换。
     
     在任何情况下，若函数不能进行有效的转换时，请返回 0。
     
     说明：
     
     假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为 [−231,  231 − 1]。如果数值超过这个范围，请返回  INT_MAX (231 − 1) 或 INT_MIN (−231) 。
     
     示例 1:
     
     输入: "42"
     输出: 42
     示例 2:
     
     输入: "   -42"
     输出: -42
     解释: 第一个非空白字符为 '-', 它是一个负号。
     我们尽可能将负号与后面所有连续出现的数字组合起来，最后得到 -42 。
     */
    func myAtoi(_ str: String) -> Int {
        var res = 0
        var i = 0
        var flag = 1 // 是否是负数
        while str[i].isWhitespace  {
            i += 1
        }
        if str[i] == "-" {
            flag = -1
            i += 1
        }
        while (i < str.count && str[i].isWholeNumber) {
            guard let r = str[i].wholeNumberValue  else {
                break
            }
            if (res > 2147483647 / 10 || res == 2147483647 / 10 && r > 7) {
                return flag == 1 ? 2147483647 : -2147483647
            }
            res = res * 10 + r
            i = i + 1
        }
        return res * flag
    }
    
    
    /// 第九题
    /*
     判断一个整数是否是回文数。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。
     
     示例 1:
     
     输入: 121
     输出: true
     示例 2:
     
     输入: -121
     输出: false
     解释: 从左向右读, 为 -121 。 从右向左读, 为 121- 。因此它不是一个回文数。
     示例 3:
     
     输入: 10
     输出: false
     解释: 从右向左读, 为 01 。因此它不是一个回文数。
     进阶:
     
     你能不将整数转为字符串来解决这个问题吗？
     */
    func isPalindrome(_ x: Int) -> Bool {
        // 特殊情况：
        // 如上所述，当 x < 0 时，x 不是回文数。
        // 同样地，如果数字的最后一位是 0，为了使该数字为回文，
        // 则其第一位数字也应该是 0
        // 只有 0 满足这一属性
        if x < 0 || (x % 10 == 0 && x != 0 ){
            return false
        }
        var res = 0
        var temp = x
        while temp > res {
            res = res * 10 + temp % 10
            temp /= 10
        }
        // 当数字长度为奇数时，我们可以通过 revertedNumber/10 去除处于中位的数字。
        // 例如，当输入为 12321 时，在 while 循环的末尾我们可以得到 x = 12，revertedNumber = 123，
        // 由于处于中位的数字不影响回文（它总是与自己相等），所以我们可以简单地将其去除。
        return res == temp || temp == res/10;
    }
    
    
    /// 第十题
    /*
     给你一个字符串 s 和一个字符规律 p，请你来实现一个支持 '.' 和 '*' 的正则表达式匹配。
     
     '.' 匹配任意单个字符
     '*' 匹配零个或多个前面的那一个元素
     所谓匹配，是要涵盖 整个 字符串 s的，而不是部分字符串。
     
     说明:
     
     s 可能为空，且只包含从 a-z 的小写字母。
     p 可能为空，且只包含从 a-z 的小写字母，以及字符 . 和 *。
     示例 1:
     
     输入:
     s = "aa"
     p = "a"
     输出: false
     解释: "a" 无法匹配 "aa" 整个字符串。
     示例 2:
     
     输入:
     s = "aa"
     p = "a*"
     输出: true
     解释: 因为 '*' 代表可以匹配零个或多个前面的那一个元素, 在这里前面的元素就是 'a'。因此，字符串 "aa" 可被视为 'a' 重复了一次。
     示例 3:
     
     输入:
     s = "ab"
     p = ".*"
     输出: true
     解释: ".*" 表示可匹配零个或多个（'*'）任意字符（'.'）。
     示例 4:
     
     输入:
     s = "aab"
     p = "c*a*b"
     输出: true
     解释: 因为 '*' 表示零个或多个，这里 'c' 为 0 个, 'a' 被重复一次。因此可以匹配字符串 "aab"。
     示例 5:
     
     输入:
     s = "mississippi"
     p = "mis*is*p*."
     输出: false
     */
    func isMatch(_ text: String, _ pattern: String) -> Bool {
        
        //        var memo:[[Bool]] = [[Bool]]() // 备忘录
        //
        //        // 重叠子问题 解题思路 使用动态规划
        //        func dp(_ i: Int,_ j: Int) -> Bool {
        //            if i < memo.count && j < memo[i].count {
        //                return memo[i][j]
        //            }
        //
        //            let first_match = i < text.count && (pattern[j] == text[i] || pattern[j] == ".")
        //
        //            var ans = false
        //            if j <= pattern.count - 2 && pattern[j+1] == "*" {
        //                ans = dp(i, j+2) || (first_match && dp(i+1, j))
        //            } else {
        //                ans = first_match && dp(i+1,j+1)
        //            }
        //            memo[i][j] = ans
        //            return ans
        //
        //        }
        //        return dp(0,0)
        
        // 暴力循环
        
        // 1.如果正则字符串为空
        if pattern.isEmpty {
            return text.isEmpty
        }
        
        // 2.正则字符串不为空，判断第一个字符串是否匹配
        let first_match = !text.isEmpty && (pattern[0] == text[0] || pattern[0] == ".")
        
        // 3.判断第二个字符串是否出现 * 出现时做如下操作
        if pattern.count >= 2 && pattern[1] == "*" {
            
            let patternIndex2 = pattern.index(pattern.startIndex, offsetBy: 2)
            let subPattern = String(pattern.suffix(from: patternIndex2))
            
            let textIndex1 = text.index(after: text.startIndex)
            let subText = String(text[textIndex1..<text.endIndex])
            return isMatch(text, subPattern) || (first_match && isMatch(subText, pattern))
            // 4.判断第二个字符串是否出现 * 不出现时做如下操作
        } else {
            let textIndex1 = text.index(after: text.startIndex)
            let patternIndex1 = pattern.index(after: pattern.startIndex)
            
            let subText = String(text[textIndex1..<text.endIndex])
            let subPattern = String(pattern[patternIndex1..<pattern.endIndex])
            
            return first_match && isMatch(subText, subPattern)
        }
    }
    
    /// 第十一题
    /*
     给定 n 个非负整数 a1，a2，...，an，每个数代表坐标中的一个点 (i, ai) 。在坐标内画 n 条垂直线，垂直线 i 的两个端点分别为 (i, ai) 和 (i, 0)。找出其中的两条线，使得它们与 x 轴共同构成的容器可以容纳最多的水。
     
     说明：你不能倾斜容器，且 n 的值至少为 2。
     
     图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。
     
     示例:
     
     输入: [1,8,6,2,5,4,8,3,7]
     输出: 49
     */
    func maxArea(_ height: [Int]) -> Int {
        var maxArea = 0
        var i = 0, j = height.count - 1
        while i != j {
            let h = min(height[i], height[j])
            let res = h * (j - i)
            maxArea = max(res, maxArea)
            if height[i] < height[j] {
                i += 1
            } else {
                j -= 1
            }
        }
        return maxArea
    }
    
    /// 第十二题
    /*
     罗马数字包含以下七种字符： I， V， X， L，C，D 和 M。
     
     字符          数值
     I             1
     V             5
     X             10
     L             50
     C             100
     D             500
     M             1000
     例如， 罗马数字 2 写做 II ，即为两个并列的 1。12 写做 XII ，即为 X + II 。 27 写做  XXVII, 即为 XX + V + II 。
     
     通常情况下，罗马数字中小的数字在大的数字的右边。但也存在特例，例如 4 不写做 IIII，而是 IV。数字 1 在数字 5 的左边，所表示的数等于大数 5 减小数 1 得到的数值 4 。同样地，数字 9 表示为 IX。这个特殊的规则只适用于以下六种情况：
     
     I 可以放在 V (5) 和 X (10) 的左边，来表示 4 和 9。
     X 可以放在 L (50) 和 C (100) 的左边，来表示 40 和 90。
     C 可以放在 D (500) 和 M (1000) 的左边，来表示 400 和 900。
     给定一个整数，将其转为罗马数字。输入确保在 1 到 3999 的范围内。
     
     示例 1:
     
     输入: 3
     输出: "III"
     示例 2:
     
     输入: 4
     输出: "IV"
     示例 3:
     
     输入: 9
     输出: "IX"
     示例 4:
     
     输入: 58
     输出: "LVIII"
     解释: L = 50, V = 5, III = 3.
     示例 5:
     
     输入: 1994
     输出: "MCMXCIV"
     解释: M = 1000, CM = 900, XC = 90, IV = 4.
     */
    func intToRoman(_ num: Int) -> String {
        var tempNum = num
        let keyArr = ["M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"]
        let valueArr = [1000,900,500,400,100,90,50,40,10,9,5,4,1]
        var res = ""
        for i in 0..<valueArr.count {
            while tempNum >= valueArr[i] {
                res += keyArr[i]
                tempNum -= valueArr[i]
            }
        }
        return res
    }
    
    /// 第三题
    /*
     罗马数字包含以下七种字符: I， V， X， L，C，D 和 M。
     
     字符          数值
     I             1
     V             5
     X             10
     L             50
     C             100
     D             500
     M             1000
     例如， 罗马数字 2 写做 II ，即为两个并列的 1。12 写做 XII ，即为 X + II 。 27 写做  XXVII, 即为 XX + V + II 。
     
     通常情况下，罗马数字中小的数字在大的数字的右边。但也存在特例，例如 4 不写做 IIII，而是 IV。数字 1 在数字 5 的左边，所表示的数等于大数 5 减小数 1 得到的数值 4 。同样地，数字 9 表示为 IX。这个特殊的规则只适用于以下六种情况：
     
     I 可以放在 V (5) 和 X (10) 的左边，来表示 4 和 9。
     X 可以放在 L (50) 和 C (100) 的左边，来表示 40 和 90。
     C 可以放在 D (500) 和 M (1000) 的左边，来表示 400 和 900。
     给定一个罗马数字，将其转换成整数。输入确保在 1 到 3999 的范围内。
     
     示例 1:
     
     输入: "III"
     输出: 3
     示例 2:
     
     输入: "IV"
     输出: 4
     示例 3:
     
     输入: "IX"
     输出: 9
     示例 4:
     
     输入: "LVIII"
     输出: 58
     解释: L = 50, V= 5, III = 3.
     示例 5:
     
     输入: "MCMXCIV"
     输出: 1994
     解释: M = 1000, CM = 900, XC = 90, IV = 4.
     */
    func romanToInt(_ s: String) -> Int {
        let keyArr = ["M":1000,"CM":900,"D":500,"CD":400,"C":100,"XC":90,"L":50,"XL":40,"X":10,"IX":9,"V":5,"IV":4,"I":1]
        var ans = 0
        var i = 0
        
        var index = s.index(s.startIndex, offsetBy: 0)
        
        var endIndex1 = s.index(index, offsetBy:0)
        var oneKey = s[index...endIndex1]
        
        var endIndex2 = s.index(index, offsetBy:0)
        var twoKey = s[index...endIndex1]
        
        while i < s.count {
            index = s.index(s.startIndex, offsetBy: i)
            endIndex1 = s.index(index, offsetBy:0)
            oneKey = s[index...endIndex1]
            if i == s.count - 1 {
                ans += keyArr[String(oneKey)] ?? 0
                i += 1
            } else {
                endIndex2 = s.index(index, offsetBy:1)
                twoKey = s[index...endIndex2]
                if keyArr.keys.contains(String(twoKey)) {
                    ans += keyArr[String(twoKey)] ?? 0
                    i += 2
                } else if(keyArr.keys.contains(String(oneKey))) {
                    ans += keyArr[String(oneKey)] ?? 0
                    i += 1
                } else {
                    i += 1
                }
            }
        }
        return ans
    }
    
    
    /// 第十四题
    /*
     编写一个函数来查找字符串数组中的最长公共前缀。
     
     如果不存在公共前缀，返回空字符串 ""。
     
     示例 1:
     
     输入: ["flower","flow","flight"]
     输出: "fl"
     示例 2:
     
     输入: ["dog","racecar","car"]
     输出: ""
     解释: 输入不存在公共前缀。
     说明:
     
     所有输入只包含小写字母 a-z 。
     */
    func longestCommonPrefix(_ strs: [String]) -> String {
        var prefix = strs.first ?? ""
        if(strs.count == 1 || strs.count == 0) {
            return prefix
        }
        var tempStrs:[String] = strs
        tempStrs.removeFirst()
        for str in tempStrs {
            let commonPrefix = str.commonPrefix(with: prefix)
            if commonPrefix.count > 0 {
                prefix = commonPrefix
            }else {
                return ""
            }
        }
        return prefix
    }
    
    /// 第十五题
    /*
     给定一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？找出所有满足条件且不重复的三元组。
     
     注意：答案中不可以包含重复的三元组。
     
     例如, 给定数组 nums = [-1, 0, 1, 2, -1, -4]，
     
     满足要求的三元组集合为：
     [
     [-1, 0, 1],
     [-1, -1, 2]
     ]
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var res:[[Int]] = []
        let length = nums.count
        
        var numsTemp = nums
        numsTemp.sort { (a, b) -> Bool in
            return a < b
        }
        
        if numsTemp.count > 2 && numsTemp[0] <= 0 && numsTemp[length - 1] >= 0 {
            for var i in 0..<length {
                if numsTemp[i] > 0 || i == length - 1 { break }
                var first = i + 1
                var last = length - 1
                while (first < last) {
                    if (first >= last || numsTemp[i] * numsTemp[last] > 0) { break }
                    let result = numsTemp[i] + numsTemp[first] + numsTemp[last]
                    if (result == 0) { // 如果可以组队
                        res.append([numsTemp[i],numsTemp[first],numsTemp[last]])
                    }
                    if result <= 0 { // 实力弱左边太菜，左边右移一个
                        while first < last && numsTemp[first] == numsTemp[first + 1] { // 去重之后再加一
                            first += 1
                        }
                        first += 1
                    } else { // 实力强右边太强，右边左移一个
                        while first < last && numsTemp[last] == numsTemp[last - 1] { // 去重之后再减一
                            last -= 1
                        }
                        last -= 1
                    }
                }
                // 如果下次循环
                // 循环跨过连续相等的数字
                while i < length - 1 && numsTemp[i] == numsTemp[i + 1] {
                    i += 1
                }
            }
        }
        return res
    }
    
    
    /// 第十六题
    /*
     给定一个包括 n 个整数的数组 nums 和 一个目标值 target。找出 nums 中的三个整数，使得它们的和与 target 最接近。返回这三个数的和。假定每组输入只存在唯一答案。
     
     例如，给定数组 nums = [-1，2，1，-4], 和 target = 1.
     
     与 target 最接近的三个数的和为 2. (-1 + 2 + 1 = 2).
     */
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        var ans = 0
        if nums.count <= 3 {
            for num in nums {
                ans += num
            }
            return ans
        }
        var numsTemp = nums
        numsTemp.sort()
        ans = numsTemp[0] + numsTemp[1] + numsTemp[2]
        var del = Int.max
        for i in 0..<numsTemp.count {
            var start = i + 1
            var end = numsTemp.count - 1;
            while start < end {
                let sum = numsTemp[i] + numsTemp[start] + numsTemp[end]
                if sum == target {
                    return sum
                }
                if abs(sum - target) < del {
                    ans = sum
                    del = abs(sum - target)
                }
                if sum > target {
                    end -= 1
                } else {
                    start += 1
                }
            }
        }
        return ans
    }
    
    /// 第十七题
    /*
     给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。
     
     给出数字到字母的映射如下（与电话按键相同）。注意 1 不对应任何字母。
     
     示例:
     
     输入："23"
     输出：["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
     说明:
     尽管上面的答案是按字典序排列的，但是你可以任意选择答案输出的顺序。
     */
    let table:[String: String] = ["2":"abc","3":"def","4":"ghi","5":"jkl","6":"mno","7":"pqrs","8":"tuv","9":"wxyz"]
    var res:[String] = []
    
    func letterCombinations(_ digits: String) -> [String] {
        if digits.isEmpty {
            return res
        }
        backtarck(combination: "", next_digits: digits)
        return res
    }
    func backtarck(combination: String, next_digits: String) {
        if next_digits.count == 0 {
            res.append(combination)
        } else {
            let firstNumIndex = next_digits.index(after: next_digits.startIndex)
            let num = next_digits[next_digits.startIndex..<firstNumIndex]
            var digits = next_digits
            digits.removeFirst()
            if let letters = table[String(num)] {
                for c in letters {
                    backtarck(combination: combination + String(c), next_digits: digits)
                }
            }
        }
    }
    
    /// 第十八题
    /*
     给定一个包含 n 个整数的数组 nums 和一个目标值 target，判断 nums 中是否存在四个元素 a，b，c 和 d ，使得 a + b + c + d 的值与 target 相等？找出所有满足条件且不重复的四元组。
     
     注意：
     
     答案中不可以包含重复的四元组。
     
     示例：
     
     给定数组 nums = [1, 0, -1, 0, -2, 2]，和 target = 0。
     
     满足要求的四元组集合为：
     [
     [-1,  0, 0, 1],
     [-2, -1, 1, 2],
     [-2,  0, 0, 2]
     ]
     */
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var tempNums = nums
        var res:[[Int]] = []
        if tempNums.count < 4 {
            return res
        }
        tempNums.sort() // 先排序
        let length = nums.count
        for k in 0..<(length - 3) {
            // 当k值与前面的值相等忽略
            if (k > 0 && tempNums[k] == tempNums[k-1]) {
                continue
            }
            if (tempNums[k] + tempNums[k + 1] + tempNums[k + 2] + tempNums[k + 3]) > target {
                continue
            }
            
            if (tempNums[k] + tempNums[length - 1] + tempNums[length - 2] + tempNums[length - 3]) < target {
                continue
            }
            
            for i in (k+1)..<(length - 2) {
                // 当i值与前面的值相等忽略
                if i > k+1 && tempNums[i] == tempNums[i-1] {
                    continue
                }
                
                var j = i + 1
                var h = length - 1
                
                if (tempNums[k] + tempNums[i] + tempNums[j] + tempNums[j+1]) > target {
                    continue
                }
                
                if (tempNums[k] + tempNums[i] + tempNums[h] + tempNums[h-1]) < target {
                    continue
                }
                
                while j < h {
                    let current = tempNums[k] + tempNums[i] + tempNums[j] + tempNums[h]
                    if current == target {
                        res.append([tempNums[k],tempNums[i],tempNums[j],tempNums[h]])
                        
                        j += 1
                        while (j<h && tempNums[j] == tempNums[j-1]) {
                            j += 1
                        }
                        
                        h -= 1
                        while (j<h && tempNums[h] == tempNums[h+1]) {
                            h -= 1
                        }
                    } else if current > target {
                        h -= 1
                    } else {
                        j += 1
                    }
                }
            }
        }
        return res
    }
    
    
    /// 第十九题
    /*
     给定一个链表，删除链表的倒数第 n 个节点，并且返回链表的头结点。
     
     示例：
     
     给定一个链表: 1->2->3->4->5, 和 n = 2.
     
     当删除了倒数第二个节点后，链表变为 1->2->3->5.
     说明：
     
     给定的 n 保证是有效的。
     
     进阶：
     
     你能尝试使用一趟扫描实现吗？
     解题一: 两次遍历 第一次得到长度L 然后将L - n + 1
     解题二: 一次遍历 两个指针
     */
    
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let d = ListNode(0)
        d.next = head
        
        var first = d
        var second = d
        for _ in 0..<n {
            first = first.next!
        }
        
        while first.next != nil {
            first = first.next!
            second = second.next!
        }
        
        second.next = second.next?.next
        return d.next
    }
    
    /// 第二十题
    /*
     给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。
     
     有效字符串需满足：
     
     左括号必须用相同类型的右括号闭合。
     左括号必须以正确的顺序闭合。
     注意空字符串可被认为是有效字符串。
     */
    func isValid(_ s: String) -> Bool {
        var index = s.startIndex
        var stack: [Character] = []
        let pair:[Character: Character] = ["[":"]","{":"}","(":")"]
        while index != s.endIndex {
            switch s[index] {
            case "[","{","(": stack.append(s[index])
            case "]","}",")":
                guard !stack.isEmpty, pair[stack.removeLast()] == s[index] else {
                    return false
                }
            default:
                break
            }
            index = s.index(after: index)
        }
        return stack.isEmpty
    }
}
