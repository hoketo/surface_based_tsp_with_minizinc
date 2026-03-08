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

predicate local_connectivity(int: v) =
  let {
      int: ns_start = subtree_node_indices_start[v];
      int: ns_len   = subtree_node_indices_length[v];
      
      int: ms_start = subtree_edge_indices_start[v];
      int: ms_len   = subtree_edges_length[v];

      var int: local_active_node_count = sum(j in ns_start .. ns_start + ns_len - 1)(
          bool2int( x[ subtree_node_indices[j] ] )
      );

      var int: local_active_edge_count = sum(j in ms_start .. ms_start + ms_len - 1)(
          bool2int( y[ subtree_edge_indices[j] ] )
      );
  } in
      local_active_node_count >= 1 /\
      local_active_node_count - local_active_edge_count = 1;
      