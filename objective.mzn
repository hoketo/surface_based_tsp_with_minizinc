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

var int: objective = cost_triangle_perimeters - profit_internal_edges;

var int: cost_triangle_perimeters =
    sum(t in 1..T)(bool2int(x[t]) * triangle_perimeters[t]);

var int: profit_internal_edges =
    2 * sum(e in 1..E)(bool2int(y[e]) * dual_edge_costs[e]);
