include "globals.mzn";

predicate local_connectivity(int: v) =

let {
        int: TL = subtree_node_indices_length[v]; % Local Fan Size
        int: EL = subtree_edges_length[v];        % Local Edge Count
        
        var 1..TL: local_root;

        array[1..TL] of var bool: xl =
            [ x[i] |
              i in subtree_node_indices[
                  subtree_node_indices_start[v]..subtree_node_indices_start[v] + TL - 1
              ]
            ];
        
        array[1..EL] of var bool: yl =
            [ y[i] |
              i in subtree_edge_indices[
                  subtree_edge_indices_start[v]..subtree_edge_indices_start[v] + EL - 1
              ]
            ];
        
        array[1..EL] of int: ul =
            array1d(1..EL,
                [ u_of_subtree_edges[i] |
                  i in subtree_edge_indices_start[v]..subtree_edge_indices_start[v] + EL - 1
                ]);
        
        array[1..EL] of int: vl =
            array1d(1..EL,
                [ v_of_subtree_edges[i] |
                  i in subtree_edge_indices_start[v]..subtree_edge_indices_start[v] + EL - 1
                ]);
    } in
  % Check if the fan is non-empty (Group Steiner requirement)
  sum(xl) >= 1
  /\
  % Apply Tree constraint to the local structure
  tree(
    TL,
    EL,
    ul,
    vl,
    local_root,
    xl,
    yl
  )