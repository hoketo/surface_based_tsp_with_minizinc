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

% data schema
include "instance_data.mzn";

% Load Helper Functions (depends on problem data)
include "instance_utilities.mzn";

include "variables.mzn";
include "objective.mzn";

solve minimize objective;
 
% ================================================================================
% Constraints
% ================================================================================

% Dual Edge Consistency
constraint forall(e in 1..E) (
  y[e] <-> (x[u_dual_edges[e]] /\ x[v_dual_edges[e]])
);

% Degree constraints, for each primal edge
constraint forall(p in 1..P
                  where pe_triangle_incidence_length[p] > 2)(
  sum(i in 0..pe_triangle_incidence_length[p]-1)(
    bool2int(x[ pe_triangle_incidence_indices[ pe_triangle_incidence_start[p] + i ] ])
  ) <= 2
);

% --------------------------------------------------------------------------------
% Global Connectivity
% --------------------------------------------------------------------------------

%%
% activate only one of the global connectivity alternatives.
% only change the include file, no need to change the constraint.
%%

include "global_connectivity/custom_tree_implementation_float.mzn";
% include "global_connectivity/custom_tree_implementation_int.mzn";
% include "global_connectivity/global_tree_native.mzn";

%%
%%

constraint global_tree_connectivity();


% --------------------------------------------------------------------------------
% Local Connectivity (Steiner Group Constraint per Vertex)
% --------------------------------------------------------------------------------

%%
% activate only one of the local-connectivity alternatives.
% only change the include file, no need to change the constraint.
%%

include "local_connectivity/euler_filter.mzn";
% include "local_connectivity/local_tree.mzn";

%%
%%

constraint forall(v in 1..N) (
    local_connectivity(v)
);

% ================================================================================
% Output
% ================================================================================

output ["Obj: ", show(objective), "\n"];