
%------------------------------------------------------------------------------------------------------------
%  Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for global optimization.
%  
%  Author: Boyu Ma*, Jiaxiao Shi*, Yiming Ji, Zhengpu Wang
%  
%  Programmer: Boyu Ma (mby9702@163.com), Jiaxiao Shi (jiaxiao364@gmail.com)
%                                                                   
%  Developed in Matlab2023a                                                                                                     
%------------------------------------------------------------------------------------------------------------

% This function transforms the individual solution beyond the feasible region into the search space boundaries.
% Position: solution of the current individual within the boundaries of the search space
% lb: [lb1,lb2,...,lbn], where lbn is the lower bound of variable n
% ub: [ub1,ub2,...,ubn], where ubn is the upper bound of variable n
% dim: dimension of variables

function Position = Boundmapping(Position, lb, ub, dim)
    
% The solution in the search space does not change, 
% and the solution beyond the search space is randomly assigned within the boundaries.
flag = (Position > ub) + (Position < lb);
Position = Position.*(~flag) + (lb+(ub-lb).*rand(1,dim)).*flag;
    
end
