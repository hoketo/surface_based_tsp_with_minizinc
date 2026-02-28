var int: objective = cost_triangle_perimeters - profit_internal_edges;

var int: cost_triangle_perimeters =
    sum(t in 1..T)(bool2int(x[t]) * triangle_perimeters[t]);

var int: profit_internal_edges =
    2 * sum(e in 1..E)(bool2int(y[e]) * dual_edge_costs[e]);
