function [] = cbr()
    similarity_threshold = input('Similarity_Threshold: ');
    while(similarity_threshold > 1 || similarity_threshold < 0)
        similarity_threshold = input('Similarity_Threshold: ');
    end
    
    formatSpec = '%f%f%C%C%C%C%C%C%C%f%f%f%f%f%C%C%f%C%f%f%f%f%f%f%f%f';

    case_library = readtable('cars.csv', ...
        'Delimiter', ';', ...
        'Format', formatSpec);
     
    fprintf('Deseja filtrar por uma marca a libraria? (y/n)\n');
    option = input('Option: ', 's');
    lista = {'alfa-romero', 'audi', 'bmw', 'chevrolet', 'dodge', 'honda', 'isuzu', 'jaguar', 'mazda', 'mercedes-benz', 'mercury', 'mitsubishi',...
    	'nissan', 'peugot', 'plymouth', 'porsche', 'renault', 'saab', 'subaru', 'toyota', 'volkswagen', 'volvo'};
    if option == 'y' || option == 'Y'
        v = input('Make ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Make ', 's');
        end
        case_library = filtraCaseLibrary(v, case_library);
    end 
    
    case_library.Properties.VariableNames = {'symboling', 'normalizedLosses', 'make', 'fuelType', 'aspiration', 'numOfDoors', 'bodyStyle', 'driveWheels', 'engineLocation', 'wheelBase', 'lenght', 'width', 'height', 'curbWeight', 'engineType', 'numbOfCylinders', 'engineSize', 'fuelSystem', 'bore', 'stroke', 'compressionRatio', 'horsePower', 'peakRPM', 'cityMPG', 'highwayMPG', 'price'};
 
    k = 0;
    for i=1:size(case_library,1)
        k = i;
    end
    
    case_library.ID = rand(k,1);
    
     for i=1:size(case_library,1)
         case_library{i, 27} = i;
    end

    disp(case_library);
    
   % new_case = preencheNovoCaso();
   
    % New case data
    new_case.symboling = 0;
    new_case.normalizedLosses = 100;
    new_case.make = 'audi';
    new_case.fuelType = 'diesel';
    new_case.aspiration = 'turbo';
    new_case.numOfDoors = 'four';
    new_case.bodyStyle = 'sedan';
    new_case.driveWheels = '4wd';
    new_case.engineLocation = 'front';
    new_case.wheelBase = 100.2;
    new_case.lenght = 150.7;
    new_case.width = 65.9;
    new_case.height = 49.8;
    new_case.curbWeight = 2201;
    new_case.engineType = 'ohc';
    new_case.numbOfCylinders = 'six';
    new_case.engineSize = 231;
    new_case.fuelSystem = '2bbl';
    new_case.bore = 3.01;
    new_case.stroke = 2.27;
    new_case.compressionRatio = 18;
    new_case.horsePower = 120;
    new_case.peakRPM = 5234;
    new_case.cityMPG = 37;
    new_case.highwayMPG = 22;
    new_case.price = 10000;
    disp(new_case);
    
    fprintf('\nStarting retrieve phase...\n\n');
    
    [retrieved_indexes, similarities, new_case] = retrieve(case_library, new_case, similarity_threshold);
    

    retrieved_cases = case_library(retrieved_indexes, :);
   
    retrieved_cases.Similarity = similarities';

    fprintf('\nRetrieve phase completed...\n\n');
    
    disp(retrieved_cases);
    
    
    %Encontra os valores de similaridade mais altos ----------------------
    valorMaisAlto = 0;
    valorAnterior = 0;
    arrayMaiorSimilaridade = [];
    
    fprintf('\nDo you want to see the N most similar cases? (y/n)\n');
    option = input('Option: ', 's');
    if option == 'y' || option == 'Y'
        v = str2double(input('N: ','s'));
        while v < 0 || k > 6600
            v = str2double(input('N: ','s'));
        end
        N = v;
        for j = 1:N
            if j == 1
                for i=1:size(case_library,1)
                     if valorAnterior < retrieved_cases.Similarity(i)
                        valorAnterior = retrieved_cases.Similarity(i);
                     end
                end
            elseif j > 1
                for i=1:size(case_library,1)
                     if valorMaisAlto < retrieved_cases.Similarity(i) && valorAnterior > retrieved_cases.Similarity(i)
                        valorMaisAlto = retrieved_cases.Similarity(i);
                     end
                end
                valorAnterior = valorMaisAlto;
                valorMaisAlto = 0;

            end
           arrayMaiorSimilaridade(end+1) = valorAnterior;

        end

        for j = 1:N
            for i=1:size(case_library,1)

                if arrayMaiorSimilaridade(j) == retrieved_cases.Similarity(i)
                    disp(retrieved_cases(i,:));
                end
            end
        end
    end
   
    %---------------------------------------------------------------------
    
    maiorSim = 0;
    maiorPreco = 0;
    
    for i=1:size(retrieved_cases,1)
        if retrieved_cases.Similarity(i) > maiorSim
           maiorSim = retrieved_cases.Similarity(i);
           maiorPreco = retrieved_cases.price(i);
        end
    end
    
    if maiorSim >= 0.95
        new_price = maiorPreco;
    else
        fprintf('\nStarting reuse phase...\n\n');    
  
      %new_price = reuse(retrieved_cases, new_case);
      
      
      new_price = Fuzzy();
  
        fprintf('\n\nReuse phase completed...\n');
    end
    %new_case.price = new_price;
     
     fprintf('\nStarting revise phase...\n\n');
% 
     [journey, new_case] = revise(retrieved_cases, new_case, new_price);
%     
     final_index = find(case_library{:,27} == journey);
%     
     fprintf('\nRevise phase completed...\n');
%     
     fprintf('\nStarting retain phase...\n\n');
% 
     case_library = retain(case_library, new_case, final_index);
%     
     fprintf('\nRetain phase completed...\n\n');
%     
     disp(case_library(size(case_library,1), :));

end

function [new_case] = preencheNovoCaso()
    %Symboling
    fprintf('\nInsert your Car Symboling:\n');
        v = str2double(input('Symboling ','s'));
        while v < -3 || v > 3
            v = str2double(input('Symboling ','s'));
        end
        disp(v);
        new_case.symboling = v;
    
    %Normalized Losses 
    fprintf('\nInsert your Car Normalized Losses:\n');
        v = str2double(input('Normalized Losses ','s'));
        while v < 65 || v > 256
            v = str2double(input('Normalized Losses ','s'));
        end
        new_case.normalizedLosses  = v;

    
    %Make
    fprintf('\nInsert your car Maker:\n');
    lista = {'alfa-romero', 'audi', 'bmw', 'chevrolet', 'dodge', 'honda', 'isuzu', 'jaguar', 'mazda', 'mercedes-benz', 'mercury', 'mitsubishi',...
    	'nissan', 'peugot', 'plymouth', 'porsche', 'renault', 'saab', 'subaru', 'toyota', 'volkswagen', 'volvo'};
        v = input('Maker ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Maker ', 's');
        end
        new_case.make = v;
    
    %Fuel type
    fprintf('\nInsert your car fuel type:\n');
    lista = {'diesel', 'gas'};
        v = input('Fuel type ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Fuel type ', 's');
        end
        new_case.fuelType = v;
    
    %Aspiration
    fprintf('\nInsert your car aspiration:\n');
    lista = {'std', 'turbo'};
        v = input('Aspiration ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Aspiration ', 's');
        end
        new_case.aspiration = v;
    
    %Number of Doors
    fprintf('\nInsert your car number of doors:\n');
    lista = {'four', 'two'};
        v = input('Number of doors ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Number of doors ', 's');
        end
        new_case.numOfDoors  = v;
    
    %body styke
    fprintf('\nInsert your car body style:\n');
    lista = {'hardtop', 'wagon', 'sedan', 'hatchback', 'convertible'};
        v = input('Body style ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Body style ', 's');
        end
        new_case.bodyStyle = v;
    
    %drive-wheels
    fprintf('\nInsert your car drive-wheels:\n');
    lista = {'4wd', 'fwd', 'rwd'};
        v = input('Drive-wheels ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Drive-wheels ', 's');
        end
        new_case.driveWheels = v;
    
    %Engine-location
    fprintf('\nInsert your car engine location:\n');
    lista = {'front', 'rear'};
        v = input('Engine location ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Engine location ', 's');
        end
        new_case.engineLocation = v;

    
        %wheelBase  
    fprintf('\nInsert your Car Wheel Base:\n');
        v = str2double(input('Wheel Base ','s'));
        while v < 86.6 || v > 120.9
            v = str2double(input('Wheel Base ','s'));
        end
        new_case.wheelBase = v;

    
    %lenght 
    fprintf('\nInsert your Car lenght:\n');
        v = str2double(input('Lenght ','s'));
        while v < 141.1 || v > 208.1
            v = str2double(input('Lenght ','s'));
        end
        new_case.lenght = v;
    
    %width  
    fprintf('\nInsert your Car width:\n');
        v = str2double(input('Width ','s'));
        while v < 60.3 || v > 72.3
            v = str2double(input('Width ','s'));
        end
        new_case.width  = v;
    
        %height  
    fprintf('\nInsert your Car height:\n');
        v = str2double(input('Height ','s'));
        while v < 47.8 || v > 59.8
            v = str2double(input('Height ','s'));
        end
        new_case.height = v;

     %curbWeight   
    fprintf('\nInsert your Car curbWeight:\n');
        v = str2double(input('curbWeight ','s'));
        while v < 1488 || v > 4066
            v = str2double(input('curbWeight ','s'));
        end
        new_case.curbWeight  = v;
    
        %Engine Type
    fprintf('\nInsert your car Engine Type:\n');
    lista = {'dohc', 'dohcv', 'l', 'ohc', 'ohcf', 'ohcv', 'rotor'};
        v = input('Engine Type ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Engine Type ', 's');
        end
        new_case.engineType = v;

        %num of cylinder 
    fprintf('\nInsert your car numOfCylinders:\n');
    lista = {'eight', 'five', 'four', 'six', 'three', 'twelve', 'two'};
        v = input('Number of Cylinders ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Number of Cylinders ', 's');
        end
        new_case.numOfCylinders  = v;
    
    %Engine size
    fprintf('\nInsert your Car Engine size:\n');
        v = str2double(input('Engine size ','s'));
        while v < 65 || v > 256
            v = str2double(input('Engine size','s'));
        end
        new_case.engineSize  = v;
    
    %fuelSystem 
    fprintf('\nInsert your car fuelSystem:\n');
    lista = {'1bbl', '2bbl', '4bbl', 'idi', 'mfi', 'mpfi', 'spdi', 'spfi'};
        v = input('Fuel System ', 's');
        while sum(ismember(lista, v)) < 1
            v = input('Fuel System ', 's');
        end
        new_case.fuelSystem  = v;
    
        %Bore
    fprintf('\nInsert your Car Bore:\n');
        v = str2double(input('Bore ','s'));
        while v < 2.54 || v > 3.94
            v = str2double(input('Bore ','s'));
        end
        new_case.bore  = v;
    
        %stroke 
    fprintf('\nInsert your Car stroke:\n');
        v = str2double(input('Stroke ','s'));
        while v < 2.07 || v > 4.17
            v = str2double(input('Stroke ','s'));
        end
        new_case.stroke = v;
    
        %compressionRatio 
    fprintf('\nInsert your Car compression Ratio:\n');
        v = str2double(input('Compression Ratio ','s'));
        while v < 7 || v > 23
            v = str2double(input('Compression Ratio ','s'));
        end
        new_case.compressionRatio = v;
    
        %horsePower 
    fprintf('\nInsert your Car horsePower:\n');
        v = str2double(input('horsePower ','s'));
        while v < 48 || v > 288
            v = str2double(input('horsePower ','s'));
        end
        new_case.horsePower  = v;
    
    %peakRPM 
    fprintf('\nInsert your Car peakRPM:\n');
        v = str2double(input('peakRPM ','s'));
        while v < 4150 || v > 6600
            v = str2double(input('peakRPM ','s'));
        end
        new_case.peakRPM = v;
    
    %cityMPG 
    fprintf('\nInsert your Car cityMPG:\n');
        v = str2double(input('cityMPG ','s'));
        while v < 13 || v > 49
            v = str2double(input('cityMPG ','s'));
        end
        new_case.cityMPG = v;
    
    %highwayMPG 
    fprintf('\nInsert your Car highwayMPG:\n');
        v = str2double(input('highwayMPG ','s'));
        while v < 16 || v > 54
            v = str2double(input('highwayMPG ','s'));
        end
        new_case.highwayMPG = v;
    
    %price
    fprintf('\nInsert your car price:\n');
        v = str2double('-');
        while isnan(v)
             v = str2double(input('New value for price ', 's'));
        end
        new_case.price = v;
end

function [case_library] = filtraCaseLibrary(v, case_library)
    [index_row, index_col] = find(case_library{:,3} ~= v);

    case_library( index_row, : ) = [];
end


