int: N;
int: P;
int: T;
int: E;

array[1..E] of 1..T: u_dual_edges;
array[1..E] of 1..T: v_dual_edges;

array[int] of 1..T: subtree_node_indices;
array[1..N] of int: subtree_node_indices_start;
array[1..N] of int: subtree_node_indices_length;

array[int] of 1..E: subtree_edge_indices;
array[1..N] of int: subtree_edge_indices_start;
array[1..N] of int: subtree_edges_length;

array[int] of 1..E: u_of_subtree_edges;
array[int] of 1..E: v_of_subtree_edges;


array[1..T] of int: triangle_perimeters;
array[1..E] of int: dual_edge_costs;

array[int] of 1..T: pe_triangle_incidence_indices;
array[1..P] of int: pe_triangle_incidence_start;
array[1..P] of int: pe_triangle_incidence_length;
