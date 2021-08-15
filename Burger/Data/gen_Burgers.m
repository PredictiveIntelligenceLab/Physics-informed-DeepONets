% number of realizations to generate
N = 10;

% parameters for the Gaussian random field
gamma = 4;
tau = 5;
sigma = 25^(2);

% viscosity
visc = 0.01;

% grid size
s = 4096;
steps = 100;
nn = 101;

input = zeros(N, nn);
if steps == 1
    output = zeros(N, s);
else
    output = zeros(N, steps, nn);
end

tspan = linspace(0,1,steps+1);
x = linspace(0,1, s+1);
X = linspace(0,1, nn);

for j=1:N
    u0 = GRF(s/2, 0, gamma, tau, sigma, "periodic");
    u = Burgers(u0, tspan, s, visc);
    
    u0_eval = u0(X);
    input(j,:) = u0_eval;
    
    if steps == 1
        output(j,:) = u.values;
    else
        for k=1:(steps+1)
            output(j,k,:) = u{k}(X);
        end
    end
    
    disp(j);
end
save('Burger.mat', 'input', 'output', 'tspan',  'gamma', 'tau', 'sigma')

