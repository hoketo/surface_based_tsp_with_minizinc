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

array[1..T] of set of int: IncE_To = [
    { e | e in 1..E where v_dual_edges[e] = t } | t in 1..T
];

array[1..T] of set of int: IncE_From = [
    { e | e in 1..E where u_dual_edges[e] = t } | t in 1..T
];

int: min_degree = min(subtree_node_indices_length);

% Identify the pivot vertex
int: pivot_v = min([ i | i in 1..N where subtree_node_indices_length[i] = min_degree ]);

set of int: root_candidates = { 
    subtree_node_indices[j] 
    | j in subtree_node_indices_start[pivot_v] .. 
           subtree_node_indices_start[pivot_v] + subtree_node_indices_length[pivot_v] - 1 
};