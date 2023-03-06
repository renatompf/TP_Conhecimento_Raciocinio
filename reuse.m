function [new_price] = reuse(retrieved_cases, new_case)

    x1 = retrieved_cases{:,1}; % Symboling
    x2 = retrieved_cases{:,2}; % Normalized Losses
    x19 = retrieved_cases{:,19}; %Bore
    x21 = retrieved_cases{:,21}; %Compression-Ratio
    x22 = retrieved_cases{:,22}; % hp
    x23 = retrieved_cases{:,23}; % peak-rpm
    x24 = retrieved_cases{:,24}; % City-MPG
    x25 = retrieved_cases{:,25}; % Highway-MPG
    
    y = retrieved_cases{:,26}; % Prices
    
    % Multiple Regression
    % Adapted from https://www.mathworks.com/examples/matlab/mw/matlab-ex88655142-multiple-regression
    
    X = [ones(size(x1)) x1 x2 x19 x21 x22 x23 x24 x25]; %[1 vars independentes]
    
    b = X\y; %calcular coeficientes bs
    
    new_price = b(1) + b(2) * new_case.symboling + b(3) * new_case.normalizedLosses ...
        + b(4) * new_case.bore + b(5) * new_case.compressionRatio + b(6) * new_case.horsePower ...
        + b(7) * new_case.peakRPM + b(8) * new_case.cityMPG + b(9) * new_case.highwayMPG;
    
    fprintf(['Based on the attributes Symboling, Make, Fuel-Type, Aspiration, Number of Doors, Body Style, Drive-Wheels, Number o fCylinders, Fuel System, Horsepower and Peak-RPM of the retrieved cases,\n', ...
                'the estimated price for the new case is %.2f, instead of %.2f.'], new_price, new_case.price);

end
