function [route, Overallroute, v, SI ] = SIPP_test( start,goal,A,mu, label)
% v number of expanded nodes

wmax = 3; 
tmax = 3;

[nodes,nodes] = size(A);
Graph = graph(A);
 h = zeros(nodes,1);

% g vector, costs  vector updted everytime
g = inf(nodes,1);

% F total cost vector
f = inf(nodes,1);

% time vector 
time = inf(nodes,1);

% FLAG FOR VISITED
% visited = false(nodes,1);

% Parent  vector to retain parents of explored nodes
parent = zeros(nodes,1);

% Safe intervals intialization
k = 1000;  % max time
SI = zeros(nodes,k);
for i = 1:length(start)
SI(start(i),1) = 1;%% 1 means occupied
% SI(start(3),1) =1;
end

%% main loop for robots

number = length(start); % please insert number of robots
 
for robot = 1:number
% Initialize with start node
for i = 1:nodes
   temp = heuristic(i,Graph,goal(robot));
 h(i)=temp;
end

    s = start(robot);
    dest = goal(robot); % destination of the current robot
    g(s) = 0;
    f(s) = g(s)+h(s);
    time(s) = 1;
 
    % keep track of the number of nodes that are expanded
     v = 0;
     % Actual time
     counter = 1;
current = start(robot);
%% main loop for single robot
while true
    % selects next node to explore
    visited = current;
    [min_t, min_time] = min(time(:));
    [min_f, current] = min(f(:));
    if ((current == dest) || isinf(min_f))                                  %goal arrived?
        break
    end

    f(current) = inf;
    
%% For every neighbour node verify safety intervals, visited and not goal     
    
    Neighbours = neighbors(Graph,current);
    n = length(Neighbours);
       for i = 1:n
           tr = t2travel(current,Neighbours(i),label);
           t = time(current)+ tr;
           w = e2travel(current,Neighbours(i),label);
           if Neighbours(i) ~= visited  && SI(Neighbours(i),t) ==0 
                Neighbours(i) = Neighbours(i);
                cost2arrive(Neighbours(i)) = mu*(w/wmax)+(1-mu)*(tr/tmax); % equation for cost
                g(Neighbours(i)) =  g(current)+ cost2arrive(Neighbours(i));
                f(Neighbours(i)) =  g(Neighbours(i))+ h(Neighbours(i));
                if parent(Neighbours(i)) == 0
                parent(Neighbours(i)) = current;
                else
                parent(Neighbours(i)) = parent(Neighbours(i));  
                end
                time(Neighbours(i)) = time(current)+ tr;
            end
       end    
    
v = v+1;         
counter = counter + 1;
end

%% Construct the path
 if (isinf(f(dest)))
        route = [];
    else
        route = [dest]

        while (parent(route(1)) ~= 0)
            route = [parent(route(1)), route]
        end% 
%  end

Overallroute(robot).route = route;

 %% Update the safe intervals
 for i=1:length(route)
    SI(route(i),time(route(i))) = 1; 
%     if route(i) == route(length(route))
%            SI(route(i), time(route(i)):1000) = 1;
%     end
 end

 end
  f= inf(nodes,1);
  g = inf(nodes,1);
  time = inf(nodes,1);
  parent = zeros(nodes,1);
end
