% --------------------------------------------------------------------------------
% Surface-based TSP with MiniZinc
% Copyright (c) 2026 Yılmaz Arslanoğlu
%
% This file is licensed under the MIT License.
% You may obtain a copy of the License at
% https://opensource.org/licenses/MIT
%
% See the LICENSE file in the project root for the full license text.
% --------------------------------------------------------------------------------

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