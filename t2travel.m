function [ tr_time ] = t2travel( initial, final,label)
%% this function gets two nodes connected , and computes the time to travel
% air = 2;
% ground 1;
% a2ground = 3;
% g2air = 4;

%% if gr
if label(initial)=='1'
   if label(final)=='1'
      tr_time = 3; 
    elseif label(final) == '2'
            tr_time = 3;
    elseif label(final) == '3'
            tr_time = 3;
    elseif label(final) == '4'
            tr_time = 3;
    end
end

%% if air
if label(initial)=='2'
   if label(final)=='1'
      tr_time = 3; 
    elseif label(final) == '2'
            tr_time = 1;
    elseif label(final) == '3'
            tr_time = 1;
    elseif label(final) == '4'
            tr_time = 3;
    end
end

%% a2g
if label(initial)=='3'
   if label(final)=='1'
      tr_time = 3; 
    elseif label(final) == '2'
            tr_time = 1;
%     elseif label(final) == '3'
%             tr_time = 1;
    elseif label(final) == '4'
            tr_time = 3;
    end
end

%% g2air
if label(initial)=='4'
   if label(final)=='1'
      tr_time = 3; 
    elseif label(final) == '2'
            tr_time = 3;
    elseif label(final) == '3'
            tr_time = 3;
%     elseif label(final) == '4'
%             tr_time = 3;
    end
end
% if label(initial)=='2'
%    if label(final)=='1'
%       tr_time = 1; 
%    end
% end
% if label(initial)=='4'
%                     if label(final)=='1'
%                      tr_time = 3;
%                     else
%                         tr_time = 2;
%                     end
%                 elseif label(initial) == '3'
%                     if label(final)=='1'
%                      tr_time = 1;
%                     else
%                         tr_time = 3;
%                     end
%                 elseif label(initial) == '1'
%                    tr_time = 1;
%                 else 
%                     tr_time = 2;
% end
end

