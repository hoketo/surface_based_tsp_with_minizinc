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

% Active nodes (triangles)
array[1..T] of var bool: x;

% Active edges (shared edges between triangles)
array[1..E] of var bool: y;