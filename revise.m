function [car, new_case] = revise(retrieved_cases, new_case, new_price)
    
   % retrieved_codes = retrieved_cases{:,1};
    code = str2double('-');
        
  %  while isnan(code) || fix(code) ~= code || ismember(code, retrieved_codes) == 0
        fprintf('From the retrieved cases, which is the one that better matches your vehicle?\n');
        code = str2double(input('Car Code: ','s'));
 %   end
    
    car = fix(code);
    
    
    %Symboling
    fprintf('\nUpdate your Car Symboling with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New Symboling','s'));
        while v < -3 || v > 3
            v = str2double(input('New Symboling','s'));
        end
        new_case.symboling = v;
    end
    
    %Normalized Losses 
    fprintf('\nUpdate your Car Normalized Losses with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New Normalized Losses','s'));
        while v < 65 || v > 256
            v = str2double(input('New Normalized Losses','s'));
        end
        new_case.normalizedLosses  = v;
    end
    
    %Make
    fprintf('\nUpdate your car Maker with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    lista = {'alfa-romero', 'audi', 'bmw', 'chevrolet', 'dodge', 'honda', 'isuzu', 'jaguar', 'mazda', 'mercedes-benz', 'mercury', 'mitsubishi',...
    	'nissan', 'peugot', 'plymouth', 'porsche', 'renault', 'saab', 'subaru', 'toyota', 'volkswagen', 'volvo'};
    if option == 'y' || option == 'Y'
        v = input('New maker', 's');
        while sum(ismember(lista, v)) < 1
            v = input('New maker', 's');
        end
        new_case.make = v;
    end
    
    %Fuel type
    fprintf('\nUpdate your car fuel type with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    lista = {'diesel', 'gas'};
    if option == 'y' || option == 'Y'
        v = input('New fuel type', 's');
        while sum(ismember(lista, v)) < 1
            v = input('New fuel type', 's');
        end
        new_case.fuelType = v;
    end
    
    %Aspiration
    fprintf('\nUpdate your car aspiration with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    lista = {'std', 'turbo'};
    if option == 'y' || option == 'Y'
        v = input('New aspiration', 's');
        while sum(ismember(lista, v)) < 1
            v = input('New aspiration', 's');
        end
        new_case.aspiration = v;
    end
    
    %Number of Doors
    fprintf('\nUpdate your car number of doors with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    lista = {'four', 'two'};
    if option == 'y' || option == 'Y'
        v = input('New number of doors', 's');
        while sum(ismember(lista, v)) < 1
            v = input('New number of doors', 's');
        end
        new_case.numOfDoors  = v;
    end
    
    %body styke
    fprintf('\nUpdate your car body style with the new estimated value? (y/n)\n');
    lista = {'hardtop', 'wagon', 'sedan', 'hatchback', 'convertible'};
    if option == 'y' || option == 'Y'
        v = input('New body style', 's');
        while sum(ismember(lista, v)) < 1
            v = input('New body style', 's');
        end
        new_case.bodyStyle = v;
    end
    
    %drive-wheels
    fprintf('\nUpdate your car drive-wheels with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    lista = {'4wd', 'fwd', 'rwd'};
    if option == 'y' || option == 'Y'
        v = input('New drive-wheels', 's');
        while sum(ismember(lista, v)) < 1
            v = input('New drive-wheels', 's');
        end
        new_case.driveWheels = v;
    end
    
    %Engine-location
    fprintf('\nUpdate your car engine location with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    lista = {'front', 'rear'};
    if option == 'y' || option == 'Y'
        v = input('New engine location', 's');
        while sum(ismember(lista, v)) < 1
            v = input('New engine location', 's');
        end
        new_case.engineLocation = v;
    end
    
        %wheelBase  
    fprintf('\nUpdate your Car Wheel Base with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New wheel Base','s'));
        while v < 86.6 || v > 120.9
            v = str2double(input('New wheel Base','s'));
        end
        new_case.wheelBase = v;
    end
    
    %lenght 
    fprintf('\nUpdate your Car lenght  with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New lenght ','s'));
        while v < 141.1 || v > 208.1
            v = str2double(input('New lenght ','s'));
        end
        new_case.lenght = v;
    end
    
    %width  
    fprintf('\nUpdate your Car width  with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New width ','s'));
        while v < 60.3 || v > 72.3
            v = str2double(input('New width ','s'));
        end
        new_case.width  = v;
    end
    
        %height  
    fprintf('\nUpdate your Car height with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New height ','s'));
        while v < 65 || v > 256
            v = str2double(input('New height ','s'));
        end 
        new_case.height = v;
    end
    
     %curbWeight   
    fprintf('\nUpdate your Car curbWeight  with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = input('New curbWeight  ','s');
        while v < 1488 || v > 4066
            v = str2double(input('New curbWeight ','s'));
        end
        new_case.curbWeight  = v;
    end
    
        %Engine Type
    fprintf('\nUpdate your car Engine Type with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    lista = {'dohc', 'dohcv', 'l', 'ohc', 'ohcf', 'ohcv', 'rotor'};
    if option == 'y' || option == 'Y'
        v = input('New Engine Type', 's');
        while sum(ismember(lista, v)) < 1
            v = input('New Engine Type', 's');
        end
        new_case.engineType = v;
    end
    
        %num of cylinder 
    fprintf('\nUpdate your car numOfCylinders  with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    lista = {'eight', 'five', 'four', 'six', 'three', 'twelve', 'two'};
    if option == 'y' || option == 'Y'
        v = input('New numOfCylinders ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('New numOfCylinders ', 's');
        end
        new_case.numOfCylinders  = v;
    end
    
    %Engine size
    fprintf('\nUpdate your Car Engine size with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New Engine size ','s'));
        while v < 65 || v > 256
            v = str2double(input('New Engine size','s'));
        end
        new_case.engineSize  = v;
    end
    
    %fuelSystem 
    fprintf('\nUpdate your car fuelSystem  with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    lista = {'1bbl', '2bbl', '4bbl', 'idi', 'mfi', 'mpfi', 'spdi', 'spfi'};
    if option == 'y' || option == 'Y'
        v = input('New fuelSystem ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('New fuelSystem ', 's');
        end
        new_case.fuelSystem  = v;
    end
    
        %Bore
    fprintf('\nUpdate your Car Bore with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New Bore ','s'));
        while v < 2.54 || v > 3.94
            v = str2double(input('New Bore ','s'));
        end
        new_case.bore  = v;
    end
    
        %stroke 
    fprintf('\nUpdate your Car stroke with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New stroke','s'));
        while v < 2.07 || v > 4.17
            v = str2double(input('New stroke ','s'));
        end
        new_case.stroke = v;
    end
    
        %compressionRatio 
    fprintf('\nUpdate your Car compression Ratio  with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New compression Ratio','s'));
        while v < 7 || v > 23
            v = str2double(input('New compression Ratio ','s'));
        end
        new_case.compressionRatio = v;
    end
    
        %horsePower 
    fprintf('\nUpdate your Car horsePower with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New horsePower ','s'));
        while v < 48 || v > 288
            v = str2double(input('New horsePower ','s'));
        end
        new_case.horsePower  = v;
    end
    
    %peakRPM 
    fprintf('\nUpdate your Car peakRPM  with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New peakRPM ','s'));
        while v < 4150 || v > 6600
            v = str2double(input('New peakRPM ','s'));
        end
        new_case.peakRPM = v;
    end
    
    %cityMPG 
    fprintf('\nUpdate your Car cityMPG  with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New cityMPG ','s'));
        while v < 13 || v > 49
            v = str2double(input('New cityMPG ','s'));
        end
        new_case.cityMPG = v;
    end
    
    %highwayMPG 
    fprintf('\nUpdate your Car highwayMPG with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('New highwayMPG ','s'));
        while v < 16 || v > 54
            v = str2double(input('New highwayMPG ','s'));
        end
        new_case.highwayMPG = v;
    end
    
    fprintf('\nUpdate your car price with the new estimated value? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        new_case.price = new_price;
    end
 
end

