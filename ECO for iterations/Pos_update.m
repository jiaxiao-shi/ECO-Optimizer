
%------------------------------------------------------------------------------------------------------------
%  Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for global optimization.
%  
%  Author: Boyu Ma*, Jiaxiao Shi*, Yiming Ji, Zhengpu Wang
%  
%  Programmer: Boyu Ma (mby9702@163.com), Jiaxiao Shi (jiaxiao364@gmail.com)
%                                                                   
%  Developed in Matlab2023a                                                                                                     
%------------------------------------------------------------------------------------------------------------

function [Pos,Fit,Best_pos,Best_fit] = Pos_update(pos_old, pos_fitold, pos_new, Best_pos, Best_fit, fobj)

% Update the best solution and value of the current individual
pos_fitnew = fobj(pos_new);

if pos_fitnew < pos_fitold
    Pos = pos_new;
    Fit = pos_fitnew;
    % Update the best solution and value of the objective function
    if pos_fitnew < Best_fit
        Best_pos = pos_new;
        Best_fit = pos_fitnew;
    end
else
    Pos = pos_old;
    Fit = pos_fitold;
end

end