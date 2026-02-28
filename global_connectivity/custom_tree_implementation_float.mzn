include "../tree_implementation/single_commodity_flow_float.mzn";

predicate global_tree_connectivity() =
  generic_tree_constraint(x, y, N-2, root_candidates);