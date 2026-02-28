% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TSP HELPERS
%
% Requires (from data):
%   n_dual_edges, u_dual_edges, v_dual_edges
%
% Requires (for root_candidates / TV / EV):
%   N, T, tris
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sparse list of edges where triangle t is the 'to' node (index 2)
array[1..T] of set of int: IncE_To = [
    { e | e in 1..E where v_dual_edges[e] = t } | t in 1..T
];

% Sparse list of edges where triangle t is the 'from' node (index 1)
array[1..T] of set of int: IncE_From = [
    { e | e in 1..E where u_dual_edges[e] = t } | t in 1..T
];

% --- root restriction heuristic (Fully Sparse)

% Find the minimum degree using the new array
int: min_degree = min(subtree_node_indices_length);

% Identify the pivot vertex
int: pivot_v = min([ i | i in 1..N where subtree_node_indices_length[i] = min_degree ]);

% 4. Extract root candidates using the sparse index map
set of int: root_candidates = { 
    subtree_node_indices[j] 
    | j in subtree_node_indices_start[pivot_v] .. 
           subtree_node_indices_start[pivot_v] + subtree_node_indices_length[pivot_v] - 1 
};
