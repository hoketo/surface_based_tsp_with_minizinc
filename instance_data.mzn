% Number of primal vertices (TSP cities).
int: N;

% Number of primal edges in the triangulation.
% Equivalently, the number of primal edge incidences / local edge-groups
% used by the planar edge-based local-connectivity encoding.
int: P;

% Number of triangles in the candidate triangulation.
% These are the main selectable surface elements.
int: T;

% Number of dual edges, i.e. adjacencies between pairs of triangles.
int: E;


% Endpoints of each dual edge in the triangle adjacency graph.
% Edge e connects triangles u_dual_edges[e] and v_dual_edges[e].
array[1..E] of 1..T: u_dual_edges;
array[1..E] of 1..T: v_dual_edges;


% Flattened list of triangle indices incident to each primal vertex.
% For a city v, the slice
%   subtree_node_indices[
%     subtree_node_indices_start[v] ..
%     subtree_node_indices_start[v] + subtree_node_indices_length[v] - 1
%   ]
% gives the triangles containing v.
% This is the local node set of the per-vertex subtree / Euler structure.
array[int] of 1..T: subtree_node_indices;

% Start offset of city v inside subtree_node_indices.
array[1..N] of int: subtree_node_indices_start;

% Number of incident triangles stored for city v.
array[1..N] of int: subtree_node_indices_length;


% Flattened list of dual-edge indices belonging to the local subgraph of each city.
% For a city v, the slice
%   subtree_edge_indices[
%     subtree_edge_indices_start[v] ..
%     subtree_edge_indices_start[v] + subtree_edges_length[v] - 1
%   ]
% gives the dual edges whose two endpoint triangles are both incident to v.
array[int] of 1..E: subtree_edge_indices;

% Start offset of city v inside subtree_edge_indices.
array[1..N] of int: subtree_edge_indices_start;

% Number of local dual edges stored for city v.
array[1..N] of int: subtree_edges_length;

% Local endpoint numbering for the per-city subgraph.
% These describe the local graph induced around a single primal vertex:
% for each entry in subtree_edge_indices, the corresponding local edge joins
% local nodes u_of_subtree_edges[k] and v_of_subtree_edges[k], where the local
% node labels refer to the city-specific slice in subtree_node_indices.
array[int] of 1..E: u_of_subtree_edges;
array[int] of 1..E: v_of_subtree_edges;


% Cost contribution associated with selecting each triangle.
% In the planar simplification this is the perimeter of the triangle, used in
% the objective together with edge-sharing cancellations so that the remaining
% cost equals the induced tour boundary length.
array[1..T] of int: triangle_perimeters;

% Cost / reward correction associated with each dual adjacency.
% Selecting two adjacent triangles cancels the shared primal edge once; these
% values encode that shared-edge contribution in the planar objective.
array[1..E] of int: dual_edge_costs;


% Flattened incidence list from primal triangulation edges to incident triangles.
% For a primal edge p, the slice
%   pe_triangle_incidence_indices[
%     pe_triangle_incidence_start[p] ..
%     pe_triangle_incidence_start[p] + pe_triangle_incidence_length[p] - 1
%   ]
% gives the triangles incident to that primal edge.
% In a planar triangulation this is typically one or two triangles.
array[int] of 1..T: pe_triangle_incidence_indices;

% Start offset of primal edge p inside pe_triangle_incidence_indices.
array[1..P] of int: pe_triangle_incidence_start;

% Number of incident triangles for primal edge p.
array[1..P] of int: pe_triangle_incidence_length;