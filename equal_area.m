function [maxwell,vr,p] = equal_area(p_eq, T)
   %maxwell area correction function
    p = @(v) ((8 * T) ./ (3 .* v - 1)) - 3 ./ v.^2;
    vdWp = [1, -(1/3) * (1+(8*T/p_eq)), (3/p_eq), - (1/p_eq)];
    vr = sort(roots(vdWp));
    area1 = (vr(2) - vr(1)) * p_eq - integral(p, vr(1), vr(2));
    area2 = integral(p, vr(2), vr(3)) - (vr(3) - vr(2)) * p_eq;
    maxwell = abs(area1 - area2);

end
