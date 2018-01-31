col = 1;
rowin = 1;
roweq = 1;
cs = @(s1,s2)strcmp(s1,s2);

V = {'1','2','3','4','5','6'};

%% Define E
tuples = { ...
    { 'e12' '1' '2' 1 }, ...
    { 'e23' '2' '3' 1 }, ...
    { 'e24' '2' '4' 1 }, ...
    { 'e45' '4' '5' 1 }, ...
    { 'e46' '4' '6' 1}};
E = {};

for tuple=tuples
    e = tuple{1}{1};
    E{end+1} = e;
    E_s.(e) = tuple{1}{2};
    E_t.(e) = tuple{1}{3};
    E_c.(e) = tuple{1}{4};
end

%% Define K

tuples = { 
    { 'k0' '3' '6'},... 
    { 'k1' '1' '4'} };  %% demand is vague!
K = {};
for tuple=tuples
    k = tuple{1}{1};
    K{end+1} = k;
    K_s.(k) = tuple{1}{2};
    K_t.(k) = tuple{1}{3};
%     K_d.(k) = tuple{1}{4};
end


% Define the flows with their constraints.
for k=K
    for e=E
        f.(k{1}).(e{1}) = col;
        bu(col) = Inf;
        bl(col) = 0;
        col = col+1;
    end
end
%% Define the conservation constraint. 


for v=V
%for w = V
    for k=K
        s = K_s.(k{1});
        t = K_t.(k{1});
%         d = K_d.(k{1});
            for e=E
                if cs(E_s.(e{1}),v{1})
%                     i =  str2double(e{1});
%                     j =  str2double(k{1});
                    Aeq(roweq,f.(k{1}).(e{1})) = -1;
                end
                if cs(E_t.(e{1}),v{1}) 
                    Aeq(roweq,f.(k{1}).(e{1})) = 1;
                end
            end
    %end
   end
        beq(roweq) = 0;
        roweq = roweq+1;
end
