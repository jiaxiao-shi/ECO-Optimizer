%------------------------------------------------------------------------------------------------------------
%  Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for global optimization.
%  
%  Author: Boyu Ma*, Jiaxiao Shi*, Yiming Ji, Zhengpu Wang
%  
%  Programmer: Boyu Ma (mby9702@163.com), Jiaxiao Shi (jiaxiao364@gmail.com)
%                                                                   
%  Developed in Matlab2023a                                                                                                     
%------------------------------------------------------------------------------------------------------------

clear all;
clc;

% Parameters setting
Pop_size = 30; 
Max_it = 500; 
Run_times = 25;

% Create result directory if it doesn't exist
if ~exist('./results', 'dir')
    mkdir('./results');
end

% List of benchmark functions
Function_list = {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8',  ...
                 'F9', 'F10', 'F11', 'F12', 'F13', 'F14', 'F15',  ...
                 'F16', 'F17', 'F18', 'F19', 'F20', 'F21', 'F22', 'F23'}; 


for func_idx = 1:length(Function_list)
    Function_name = Function_list{func_idx};  % Select the current function

    % Load details of the benchmark function
    [Low, Up, dim, fobj] = Get_BenchFunctions(Function_name);   

    % Pre-allocate matrices to store results for the current function
    All_ECO_curve = zeros(Run_times, Max_it);     % To store ECO_curve for each run
    All_Best_pos  = zeros(Run_times, dim);        % To store Best_pos for each run
    All_Best_fit  = zeros(Run_times, 1);          % To store Best_fit for each run

    % Run ECO for Run_times independent runs
    for run = 1:Run_times
        [Best_pos, Best_fit, ECO_curve] = ECO(Pop_size, Max_it, Low, Up, dim, fobj);

        % Store the results for this run
        All_ECO_curve(run, :) = ECO_curve;  % Store the curve of best fitness values
        All_Best_pos(run, :)  = Best_pos;   % Store the best position found
        All_Best_fit(run)     = Best_fit;   % Store the best fitness value
    end

    % Generate unique filenames for the current function
    ECO_curve_filename = ['./results/Convergence_curve_classic_', Function_name, '.csv'];
    Best_pos_filename  = ['./results/Best_pos_classic_', Function_name, '.csv'];
    Best_fit_filename  = ['./results/Best_fit_classic_', Function_name, '.csv'];

    % Save the results for the current function to CSV files
    writematrix(All_ECO_curve, ECO_curve_filename);   % Save ECO_curve to CSV
    writematrix(All_Best_pos,  Best_pos_filename);    % Save Best_pos to CSV
    writematrix(All_Best_fit,  Best_fit_filename);    % Save Best_fit to CSV

    % Optionally, display the best result for the current function
    fprintf([Function_name, '\tMin: ', num2str(min(All_Best_fit)), '\tAve: ', num2str(mean(All_Best_fit), 20), '\tStd: ', num2str(std(All_Best_fit), 20), '\n']);
end

