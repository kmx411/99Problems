/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number[][]}
 */
 
 //Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).
 
var levelOrder = function(root) {
    if (!root) {
        return [];
    }
    var q = [];
    q.push(root);
    var result = [];
    
    while(q.length > 0) {
        var rounds = q.length;
        var res = [];
        while (rounds !== 0) {
            var node = q.shift();
            rounds--;
            res.push(node.val);
            if (node.left) {
                q.push(node.left)
            } if (node.right) {
                q.push(node.right)
            }
        }
        result.push(res);
    }
    
    return result;
};
