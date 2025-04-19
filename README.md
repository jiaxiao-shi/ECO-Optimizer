
# Ecological Cycle Optimizer: A novel nature-inspired metaheuristic algorithm for global optimization

<div align="center">

<!-- <table>
<tr>
<td valign="top">
  <strong>Accepted by <em>Expert Systems with Applications</em></strong>
</td>
<td valign="top" width="60">
  <a href="https://arxiv.org/abs/2503.21860">
    <img src='https://img.shields.io/badge/Paper-red?style=for-the-badge&color=B31B1' alt='Paper PDF'>
  </a>
</td>
</tr>
</table> -->
<!-- <table style="border: none; border-collapse: collapse;">
<tr>
<td valign="top">
  <strong>Accepted by <em>Expert Systems with Applications</em></strong>
</td>
<td valign="top" width="60">
  <a href="https://arxiv.org/abs/2503.21860">
    <img src='https://img.shields.io/badge/Paper-red?style=for-the-badge&color=B31B1' alt='Paper PDF'>
  </a>
</td>
</tr>
</table> -->
<!-- <table style="border: none; border-collapse: collapse;">
<tr>
<td valign="top" style="border: none;">
  <strong>Accepted by <em>Expert Systems with Applications</em></strong>
</td>
<td valign="top" width="70" style="border: none;">
  <a href="https://arxiv.org/abs/2503.21860">
    <img src='https://img.shields.io/badge/Paper-red?style=for-the-badge&color=B31B1' alt='Paper PDF'>
  </a>
</td>
</tr>
</table> -->

<!-- <a href="https://github.com/jiaxiao-shi/ECO-Optimizer.git">
  <img src='https://img.shields.io/badge/Paper-red?style=for-the-badge&color=B31B1' alt='Paper PDF'>
</a> -->

Submitted to <strong><em>Expert Systems with Applications</em></strong>
<!-- <strong>Accepted by <em>Expert Systems with Applications</em></strong> -->


✉️[Boyu Ma*](mailto:mby9702@163.com), ✉️[Jiaxiao Shi*](mailto:jiaxiao364@gmail.com),  Yiming Ji and Zhengpu Wang.

<strong><em>State Key Laboratory of Robotics and Systems, Harbin Institute of Technology</em></strong>

<!-- <hr style="height:4px; border-width:0; background-color:#E6F2FF"> -->
<!-- <hr style="height:4px; border-width:0; background-color:#B0E0E6"> -->
<!-- <hr style="height:4px; border-width:0; background-color:#ADD8E6"> -->
<hr style="height:4px; border-width:0; background-color:#AFEEEE">
<!-- <hr style="height:4px; border-width:0; background-color:#D4F1F9"> -->
<!-- <hr style="height:4px; border-width:0; background-color:#0000FF"> -->

</div>

<p align="center">
  <img src="assets/Ecosystem.jpg" alt="teaser" width="100%">
</p>

## 📚 Table of Contents
1. [Installation](#Installation)
2. [Usage](#Usage)
3. [Results](#Results)
4. [Collaboration & Support](#Collaboration--Support)
5. [Ciatation](#Ciatation)

## 🛠️ Installation
<a id="Installation"></a>

Run the following command to download our code:
``` shell
git clone https://github.com/jiaxiao-shi/ECO-Optimizer.git
```

Our code are developed in **Matlab2023a**, please make sure the API and syntax are compatible with your software.

The structure of our project is:

``` shell
ECO-Matlab
├── assets
│   └── images & support documents
├── ECO for FEs
│   └── main functions
├── ECO for iterations
│   └── main functions
└── README.md
```

To properly run **ECO** on your computer, please refer to [Usage](#Usage).

## 🔎 Usage
<a id="Usage"></a>

### Introduction

There are two versions of ECO for different purpose of use and evaluations:

- ECO for FEs
- ECO for iterations

The function name and structure of these two versions are exactly the same. If you want to apply ECO in solving <span style="color: green;">optimization problems</span>, please refer to the functions in `./ECO for iterations/`. If you want to evaluate the performance of ECO with a standard criteria of <span style="color: red;">maximun function evaluations (MaxFEs)</span>, please use the functions in `./ECO for FEs/`.

As for the optimization functions, we use the <strong><span style="color: blue;">23 classic optimization functions</span></strong> as benchmark. It is defined in **`Get_BenchFunctions.m`**. You can simply edit this file if you want to adopt other benchmarks or customized optimization functions.

Simply, you can run **`main.m`** in any of these two directories to start applying ECO in solving optimization functions. The core of **`main.m`** is the code below, which will call **`ECO.m`** for the implementation of ECO.

``` matlab
[Best_pos, Best_fit, ECO_curve] = ECO(Pop_size, Max_it, MaxFEs, Low, Up, dim, fobj);
```

The `Function_list` in **`main.m`** are used together with **`Get_BenchFunctions.m`**, and `fobj` refers to the objective of functions defined in **`Get_BenchFunctions.m`**.

``` matlab
Function_list = {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8',  ...
                 'F9', 'F10', 'F11', 'F12', 'F13', 'F14', 'F15',  ...
                 'F16', 'F17', 'F18', 'F19', 'F20', 'F21', 'F22', 'F23'}; 

for func_idx = 1:length(Function_list)
    % Get the detail information of current optimization function
    Function_name = Function_list{func_idx};  
    [Low, Up, dim, fobj] = Get_BenchFunctions(Function_name); 
    ...
end
```

ECO will be excuted for $N$ times indepently on each optimization function. After finished solving one optimization function, ECO will record the $N$ times of the:
- Convergence curve
- Best coordinates of search particles
- Best fitness value

``` matlab
Run_times = 25;
for run = 1:Run_times
    [Best_pos, Best_fit, ECO_curve] = ECO(Pop_size, Max_it, MaxFEs, Low, Up, dim, fobj);
    % Store the results for this run
    All_ECO_curve(run, :) = ECO_curve;      % Store the curve of best fitness values
    All_Best_pos(run, :)  = Best_pos;       % Store the best position found
    All_Best_fit(run)     = Best_fit;       % Store the best fitness value
end
```

And these results will be written in to `csv` files in `./results`:

``` matlab
Function_name = Function_list{func_idx};

% Generate unique filenames for the current function
ECO_curve_filename = ['./results/Convergence_curve_classic_', Function_name, '.csv'];
Best_pos_filename  = ['./results/Best_pos_classic_', Function_name, '.csv'];
Best_fit_filename  = ['./results/Best_fit_classic_', Function_name, '.csv'];

% Save the results for the current function to csv files
writematrix(All_ECO_curve, ECO_curve_filename);
writematrix(All_Best_pos,  Best_pos_filename);
writematrix(All_Best_fit,  Best_fit_filename);
```


### ECO for iterations

Adjust the parameter in `main.m` to run **ECO**:

``` matlab
Max_it = 500; 

if dim == 30
    Max_it = 5556;
elseif dim == 2
    Max_it = 370;
elseif dim == 3
    Max_it = 556;
elseif dim == 4
    Max_it = 741;
elseif dim == 6
    Max_it = 1111;
end
```

### ECO for FEs

Usually, the performance of **metaheuristic algorithms (MHS)** are evaluate with uniform criteria, one is the termination condition. Although many MHS are designed by iterative methods (including ECO), it is unfair to set a maximum times of iterations as a standard termination condition because of the different search mechanism of MHS. Thus, **IEEE CEC** defined an uniform termination criteria: <span style="color: red;">maximun function evaluations (MaxFEs)</span>. Once the solution of current search particles is calculated, FEs adds one, until finally reachs MaxFEs.

As a result, to evaluate the performance of ECO, you can simply ajust **$MaxFEs$** in `main.m` to run **ECO**:

``` matlab
% Parameters setting
Pop_size = 30; 
Run_times = 25;
MaxFEs = 10000 * dim;
```

### Parameters of ECO

In **`main.m`**

``` matlab
Pop_size = 30;
```

In **`ECO.m`**

``` matlab
% Proportion of producers, herbivores, carnivores, and omnivores in the population
P_producer = 0.2;
P_herbivore = 0.3;
P_carnivore = 0.3;
% P_omnivore = 0.2;
```

## 📝 Results
<a id="Results"></a>

In our experiments.

For detailed information, please refer to our [paper](https://github.com/jiaxiao-shi/ECO-Optimizer.git).

## 🌍 Collaboration & Support
<a id="Collaboration--Support"></a>

💡 If you have any qustions regarding the conceptualization of ECO, please contact [Boyu Ma](mailto:mby9702@163.com). For implemention, programming and simulation problems, please contact [Jiaxiao Shi](mailto:jiaxiao364@gmail.com).

🤝 Please feel feel to contact us if you wish to work together for future studies or applications, we are open to all forms of collaborative engagements.