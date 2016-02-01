/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {boolean}
 */
 
 // Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).
 
var checkEqual = function(p,q) {
    if (p === null && q === null) {
        return true;
    } else if ( p === null || q === null ) {
        return false;
    } else if ( p.val != q.val) {
        return false;
    }
    
    return checkEqual(p.left, q.right) && checkEqual(p.right, q.left);
}
var isSymmetric = function(root) {
    if (!root) {
        return true;
    }
    
    return checkEqual(root.left, root.right);
};
