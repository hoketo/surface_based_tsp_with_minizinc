include "globals.mzn";

predicate global_tree_connectivity() =
    let {
        var root_candidates: root_node;
    } in 
    (
        tree(
            T,
            E,
            u_dual_edges,
            v_dual_edges,
            root_node,
            x,
            y
        )
        /\
        sum(n in 1..T)(bool2int(x[n])) = N - 2
        /\
        sum(e in 1..E)(bool2int(y[e])) = N - 3
    );