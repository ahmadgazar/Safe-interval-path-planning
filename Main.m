
%% New main

clc 
clear all

%% New graph
s = [1 1 2 2 2 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 ...
    9 9 9 10 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 ...
    18 18 18 18 19 20 20 20 21 21 22 22 22 23 23 24 24 24 25 ...
    25 25 26 26];
t = [2 3 1 3 4 1 2 7 2 5 7 8 4 6 9 25 5 24 23 7 18 3 4 6 4 10 9 ...
    5 8 10 8 9 11 10 12 11 13 12 14 13 15 14 16 15 17 16 18 17 19 20 7 ...
    18 18 21 22 22 20 21 23 20 22 6 26 25 6 24 26 5 24 25];
Graph = digraph(s,t);
A =  adjacency(Graph);
Graph = graph(A);
% g2air = [10,17]; %ground to air nodes
% a2ground = [11,16];
% air = [11,12,13,14,15,16]; % air nodes
% heuristic vector

%% Weighting factor

mu = 0.5; % just energy/just time
%% depatable
% Time vector to keep track of earlist arrival time
% h_time = zeros(nodes,1);
% for i = 1:nodes
%    h_time(i) = heuristic_time(i); 
% end
% % g vector for time
% g_time = inf(nodes,1);
% 
% % total time
% f_time = inf(nodes,1);

%% labling nodes according to position
% 
% label = [ 'ground  ';'ground  ';'ground  ';'ground  ';'ground  ';'ground  ' ...
%     ;'ground  ';'ground  ';'ground  ';'g2air   ';'a2ground';'air     ';'air     ' ...
%     ;'air     ';'air     ';'a2ground';'g2air   ';'ground  ';'ground  '; ...
%     'ground';'ground';'ground';'ground';'ground';'ground'; 'ground';'ground'];

% air = 1;
% ground 2;
% a2ground = 3;
% g2air = 4;

label = ['1';'1';'1';'1';'1';'1';'1';'1';'1';'4';'3';'2';'2';'2';'2';'3';'4';'1';'1';'1';'1';'1';'1';'1';'1';'1'];    

%% Main loop

% start and goal of each robot
start = [1 17]; % vector of 1*number
goal = [25 10];  % vector of 1*number

[route, Overallroute, v, SI ] = SIPP_test( start,goal,A,mu, label);

%% Matlab Remote API with VREP

% ------Initializing communication with server----------------
   disp('Program started');
   % vrep=remApi('remoteApi','extApi.h'); % using the header (requires a compiler)
   vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
   vrep.simxFinish(-1); % just in case, close all opened connections
   clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
   
   
    try
      if (clientID>-1)
         disp('Connected to remote API server');

            vrep.simxStartSimulation(clientID,vrep.simx_opmode_oneshot_wait);
            vrep.simxSynchronous(clientID,true)
            fprintf('cliendID value is %i\n',clientID);

            % while we are connected:
            while (vrep.simxGetConnectionId(clientID)~=-1)

                current_route = Overallroute(1).route;
                packedData = vrep.simxPackInts(current_route);
                vrep.simxWriteStringStream(clientID,'route',packedData,vrep.simx_opmode_oneshot);

            end
      else
         disp('Failed connecting to remote API server');
      end
       
      vrep.delete(); % call the destructor!
   catch err
      vrep.simxFinish(clientID); % close the line if still open
      vrep.delete(); % call the destructor!
    end
disp('Program ended');

