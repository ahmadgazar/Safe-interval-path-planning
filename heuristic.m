function [ temp ] = heuristic( s,Graph,goal)
% computes the hueritsitc of s
% g2air = [10,17]; %ground to air nodes
% a2ground = [11,16];
% air = [11,12,13,14,15,16];
p = shortestpath(Graph,s,goal);
n = length(p);
    temp = n;

end


