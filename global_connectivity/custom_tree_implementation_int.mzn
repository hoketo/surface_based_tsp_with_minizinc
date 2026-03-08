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

include "../tree_implementation/single_commodity_flow_int.mzn";

predicate global_tree_connectivity() =
  generic_tree_constraint(x, y, N-2, root_candidates);