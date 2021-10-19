# Reject functions very much like select, but selects only the values that return false or nil from the block
# instead of true. So here, the return value will be [1, 2, 3]. It selects every value because puts always
# returns nil.
