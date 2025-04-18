%___________________________________________________________________%
%  Ecological Cycle Optimizer (ECO) source codes version 1.0         %
%                                                                   %
%  Developed in MATLAB R2021a                                       %
%                                                                   %
%  Author and programmer: Boyu Ma                                   %
%                                                                   %
%         e-Mail: mby9702@163.com                                   %
%                                                                   %
%___________________________________________________________________%

% This function transforms the individual solution beyond the feasible region into the search space boundaries.

% The initial parameters interpretation:
%___________________________________________________________________%
% Position: solution of the current individual within the boundaries of the search space
% lb: [lb1,lb2,...,lbn], where lbn is the lower bound of variable n
% ub: [ub1,ub2,...,ubn], where ubn is the upper bound of variable n
% dim: dimension of variables
%___________________________________________________________________%

function Position = Boundmapping(Position,lb,ub,dim)
    
% The solution in the search space does not change, 
% and the solution beyond the search space is randomly assigned within the boundaries.
flag=(Position > ub) + (Position < lb);
Position = Position.*(~flag) + (lb+(ub-lb).*rand(1,dim)).*flag;
    
end
