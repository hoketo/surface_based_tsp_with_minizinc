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

predicate generic_tree_constraint(
    array[int] of var bool: active_nodes, 
    array[int] of var bool: active_edges, 
    int: tree_size, 
    set of int: valid_roots
) = 
  let {
    array[1..E, 1..2] of var bool: arcs;
    % tree_size >= 1 assumed
    array[1..E, 1..2] of var 0..tree_size-1: flow;
    array[1..T] of var bool: is_root;
  } in (
    % Root Logic
    sum(t in valid_roots)(bool2int(is_root[t])) = 1
    /\
    forall(t in 1..T where not (t in valid_roots)) (is_root[t] = false)
    /\
    forall(t in 1..T)(is_root[t] -> active_nodes[t])
    /\
    % Arc Logic
    forall(e in 1..E) (
        bool2int(arcs[e,1]) + bool2int(arcs[e,2]) = bool2int(active_edges[e])
    )
    /\
    % Flow Capacity
    forall(e in 1..E, d in 1..2) (
        flow[e,d] <= (tree_size - 1) * bool2int(arcs[e,d])
    )
    /\
    % Flow Conservation
    forall(t in 1..T) (
        let {
            var int: flow_in  = sum(e in IncE_To[t])(flow[e,1]) 
                              + sum(e in IncE_From[t])(flow[e,2]);
            var int: flow_out = sum(e in IncE_From[t])(flow[e,1]) 
                              + sum(e in IncE_To[t])(flow[e,2]);
            var int: arcs_in  = sum(e in IncE_To[t])(bool2int(arcs[e,1])) 
                              + sum(e in IncE_From[t])(bool2int(arcs[e,2]));
            var 0..N: root_supply = 
                if is_root[t] then tree_size else 0 endif;
        } in (
            flow_in - flow_out = bool2int(active_nodes[t]) - root_supply
            /\
            arcs_in = bool2int(active_nodes[t]) - bool2int(is_root[t])
        )
    )
  );