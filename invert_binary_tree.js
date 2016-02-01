/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {TreeNode}
 */
 
 // invert the binary tree
 
var invertTree = function(root) {
    var temp;
    
    if (!root) {
        return null;
    }
    
    temp = root.left;
    root.left = invertTree(root.right);
    root.right = invertTree(temp);
    
    return root;
};
