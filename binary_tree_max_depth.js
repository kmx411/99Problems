/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number}
 */

// Find the max depth of the tree
 
var maxDepth = function(root) {
    var left;
    var right;
    
    if (!root) {
        return 0;
    } 
    
    left = maxDepth(root.left);
    right = maxDepth(root.right);
    
    return left > right ? left + 1 : right + 1;
};

