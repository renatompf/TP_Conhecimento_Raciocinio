function [case_library] = retain(case_library, new_case, car_index)

  %  price = case_library{car_index, 26};
    
    if ~isfield (new_case,'symboling')
        new_case.symboling = case_library{car_index, 1};
    end
    
    if ~isfield(new_case, 'normalizedLosses')
        new_case.normalizedLosses = case_library{car_index, 2};
    end
       
    if ~isfield(new_case, 'make')
        new_case.make = case_library{car_index, 3};
    end
       
    if ~isfield(new_case, 'fuelType')
        new_case.fuelType = case_library{car_index, 4};
    end
       
    if ~isfield(new_case, 'aspiration')
        new_case.aspiration = case_library{car_index, 5};
    end
    
    if ~isfield(new_case, 'numOfDoors')
        new_case.numOfDoors = case_library{car_index, 6};
    end
       
    if ~isfield(new_case, 'bodyStyle')
        new_case.bodyStyle = case_library{car_index, 7};
    end
       
    if ~isfield(new_case, 'driveWheels')
        new_case.driveWheels = case_library{car_index, 8};
    end
             
    if ~isfield(new_case, 'engineLocation')
        new_case.engineLocation = case_library{car_index, 9};
    end
       
    if ~isfield(new_case, 'wheelBase')
        new_case.wheelBase = case_library{car_index, 10};
    end
       
    if ~isfield(new_case, 'length')
        new_case.length = case_library{car_index, 11};
    end
             
    if ~isfield(new_case, 'width')
        new_case.width = case_library{car_index, 12};
    end
             
    if ~isfield(new_case, 'height')
        new_case.height = case_library{car_index, 13};
    end
        
    if ~isfield(new_case, 'curbWeight')
        new_case.curbWeight = case_library{car_index, 14};
    end
          
    if ~isfield(new_case, 'engineType')
        new_case.engineType = case_library{car_index, 15};
    end
      
    if ~isfield(new_case, 'numbOfCylinders')
        new_case.numbOfCylinders = case_library{car_index, 16};
    end

    if ~isfield(new_case, 'engineSize')
        new_case.engineSize = case_library{car_index, 17};
    end
       
    if ~isfield(new_case, 'fuelSystem')
        new_case.fuelSystem = case_library{car_index, 18};
    end
             
    if ~isfield(new_case, 'bore')
        new_case.bore = case_library{car_index, 19};
    end
             
    if ~isfield(new_case, 'stroke')
        new_case.stroke = case_library{car_index, 20};
    end
             
    if ~isfield(new_case, 'compressionRatio')
        new_case.compressionRatio = case_library{car_index, 21};
    end
             
    if ~isfield(new_case, 'horsePower')
        new_case.horsePower = case_library{car_index, 22};
    end
             
    if ~isfield(new_case, 'peakRPM')
        new_case.peakRPM = case_library{car_index, 23};
    end
             
    if ~isfield(new_case, 'cityMPG')
        new_case.cityMPG = case_library{car_index, 24};
    end
                         
    if ~isfield(new_case, 'highwayMPG')
        new_case.highwayMPG = case_library{car_index, 25};
    end
    
     for i=1:size(case_library,1)
        k = i + 1;
     end
    
    new_row = {new_case.symboling, new_case.normalizedLosses, new_case.make, ...
                        new_case.fuelType, new_case.aspiration, new_case.numOfDoors, ...
                        new_case.bodyStyle, new_case.driveWheels, new_case.engineLocation, new_case.wheelBase, ...
                        new_case.lenght, new_case.width, new_case.height, new_case.curbWeight, ...
                        new_case.engineType, new_case.numbOfCylinders, new_case.engineSize, new_case.fuelSystem, ...
                        new_case.bore, new_case.stroke, new_case.compressionRatio, new_case.horsePower, ...
                        new_case.peakRPM, new_case.cityMPG, new_case.highwayMPG, new_case.price, k
              };

    case_library = [case_library; new_row];

    disp(new_case.price);
            
    fprintf('Add the new case to the library? (y/n)\n');
    option = input('Option: ', 's');

    if option == 'y' || option == 'Y'          
        writetable(case_library, 'cars.csv'); 
    end
end