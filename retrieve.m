function[retrieved_indexes,similarities,new_case] = retrieve(case_library, new_case, threshold)

   weighting_factors = [1 3 5 5 3 4 2 4 1 1 2 2 2 2 4 3 2 3 2 2 2 4 3 3 3]; 

  flag=1;
    
      if isfield(new_case,'make')
            make_sim = get_make_similarities();
      end  
     
       if isfield(new_case,'fuelType')
        fuel_sim = get_fuelType_similarities();
       end  
    
       if isfield(new_case,'aspiration')
        aspiration_sim = get_aspiration_similarities();
       end  
       
       if isfield(new_case,'bodyStyle')
        body_style_sim = get_bodyStyle_similarities();
       end  
      
       if isfield(new_case,'numOfDoors')
        num_of_doors_sim = get_numOfDoors_similarities();
       end 
       
       if isfield(new_case,'driveWheels')
    drive_wheels_sim = get_driveWheels_similarities();
       end 
       
       if isfield(new_case,'engineLocation')
    engine_location_sim = get_engineLocation_similarities();
       end 
   
          if isfield(new_case,'engineType')
   engine_type_sim = get_engineType_similarities();
          end 
       
        if isfield(new_case,'numbOfCylinders')
    Num_of_Cilinders_sim = get_numbOfCylinders_similarities();
       end 
       
     if isfield(new_case,'fuelSystem')
            fuel_system.sim = get_fuelSystem_similarities();
     end 
       
    max_values = get_max_values(case_library);
       
    retrieved_indexes = [];
    similarities = [];
    to_remove=[]; %fica com os indices dos pesos a remover
     
       if ~isfield (new_case,'symboling')
        to_remove=[to_remove 1];
       end
    
       if ~isfield(new_case, 'normalizedLosses')
           to_remove=[to_remove 2];
       end
       
       if ~isfield(new_case, 'make')
          to_remove=[to_remove 3];
       end
       
       if ~isfield(new_case, 'fuelType')
          to_remove=[to_remove 4];
       end
       
       if ~isfield(new_case, 'aspiration')
          to_remove=[to_remove 5];
       end
          if ~isfield(new_case, 'numOfDoors')
           to_remove=[to_remove 6];
          end
       
             if ~isfield(new_case, 'bodyStyle')
           to_remove=[to_remove 7];
             end
       
        if ~isfield(new_case, 'driveWheels')
           to_remove=[to_remove 8];
             end
             
    if ~isfield(new_case, 'engineLocation')
           to_remove=[to_remove 9];
             end
       
    if ~isfield(new_case, 'wheelBase')
           to_remove=[to_remove 10];
             end
       
   if ~isfield(new_case, 'lenght')
           to_remove=[to_remove 11];
   end
             
        if ~isfield(new_case, 'width')
           to_remove=[to_remove 12];
        end
             
         if ~isfield(new_case, 'height')
           to_remove=[to_remove 13];
         end
        
          if ~isfield(new_case, 'curbWeight')
           to_remove=[to_remove 14];
          end
          
           if ~isfield(new_case, 'engineType')
           to_remove=[to_remove 15];
           end
      
            if ~isfield(new_case, 'numbOfCylinders')
           to_remove=[to_remove 16];
            end
       
             
             if ~isfield(new_case, 'engineSize')
           to_remove=[to_remove 17];
             end
       
               if ~isfield(new_case, 'fuelSystem')
           to_remove=[to_remove 18];
               end
             
                 if ~isfield(new_case, 'bore')
           to_remove=[to_remove 19];
                 end
             
                   if ~isfield(new_case, 'stroke')
           to_remove=[to_remove 20];
                   end
             
                     if ~isfield(new_case, 'compressionRatio')
           to_remove=[to_remove 21];
                     end
             
                       if ~isfield(new_case, 'horsePower')
           to_remove=[to_remove 22];
                       end
             
                         if ~isfield(new_case, 'peakRPM')
           to_remove=[to_remove 23];
                         end
             
                           if ~isfield(new_case, 'cityMPG')
           to_remove=[to_remove 24];
                           end
                         
                             if ~isfield(new_case, 'highwayMPG')
           to_remove=[to_remove 25];
                             end
                                                     
 weighting_factors(to_remove)=[];
 
 
 for i=1:size(case_library,1)
        
        distances = zeros(1,25);
        
         if isfield (new_case,'symboling') %so vai fazer se tiver definido o symboling type na query
        distances(1,1) = calculate_euclidean_distance(case_library{i,'symboling'} / max_values('symboling'), ... 
                                new_case.symboling / max_values('symboling'));
         end 
        
         
        if isfield(new_case, 'normalizedLosses')
        distances(1,2) = calculate_euclidean_distance(case_library{i,'normalizedLosses'} / max_values('normalizedLosses'), ... 
                                new_case.normalizedLosses / max_values('normalizedLosses'));
        
        end
         
        if isfield (new_case,'make')
        distances(1,3) = calculate_local_distance(make_sim, ...
                                case_library{i,'make'}, new_case.make);
        end
        
        if isfield(new_case,'fuelType')
        distances(1,4) = calculate_local_distance(fuel_sim, ...
                                case_library{i,'fuelType'}, new_case.fuelType);
         
        end
    
    if isfield(new_case,'aspiration')
        distances(1,5) = calculate_local_distance(aspiration_sim, ...
                                case_library{i,'aspiration'}, new_case.aspiration);
    end
    
    if isfield(new_case,'numOfDoors')
        distances(1,6) = calculate_local_distance(num_of_doors_sim, ...
                                case_library{i,'numOfDoors'}, new_case.numOfDoors);
    end
    
    if isfield(new_case,'bodyStyle')
        distances(1,7) = calculate_local_distance(body_style_sim, ...
                                case_library{i,'bodyStyle'}, new_case.bodyStyle);
    end
    
        if isfield(new_case,'driveWheels')
        distances(1,8) = calculate_local_distance(drive_wheels_sim, ...
                                case_library{i,'driveWheels'}, new_case.driveWheels);
        end
        
        if isfield(new_case,'engineLocation')
        distances(1,9) = calculate_local_distance(engine_location_sim, ...
                                case_library{i,'engineLocation'}, new_case.engineLocation);
        end
    
            if isfield(new_case,'wheelBase')
        distances(1,10) = calculate_euclidean_distance(case_library{i,'wheelBase'} / max_values('length'), ... 
                                new_case.wheelBase / max_values('wheelBase'));
            end
    
                if isfield(new_case,'length')
        distances(1,11) = calculate_euclidean_distance(case_library{i,'lenght'} / max_values('length'), ... 
                                new_case.length / max_values('length'));
                end
                
                if isfield(new_case,'width')
        distances(1,12) = calculate_euclidean_distance(case_library{i,'width'} / max_values('width'), ... 
                                new_case.width / max_values('width'));
                end
                
                if isfield(new_case,'height')
        distances(1,13) = calculate_euclidean_distance(case_library{i,'height'} / max_values('height'), ... 
                                new_case.height / max_values('height'));
                end
                
                if isfield(new_case,'curbWeight')
        distances(1,14) = calculate_euclidean_distance(case_library{i,'curbWeight'} / max_values('curbWeight'), ... 
                                new_case.curbWeight / max_values('curbWeight'));
                end
                
                 if isfield(new_case,'engineType')
        distances(1,15) = calculate_local_distance(engine_type_sim, ...
                                case_library{i,'engineType'}, new_case.engineType);
                 end
            
                  if isfield(new_case,'numbOfCylinders')
        distances(1,16) = calculate_local_distance(Num_of_Cilinders_sim, ...
                                case_library{i,'numbOfCylinders'}, new_case.numbOfCylinders);
                  end
                
                  
                  if isfield(new_case,'engineSize')
        distances(1,17) = calculate_euclidean_distance(case_library{i,'engineSize'} / max_values('engineSize'), ... 
                                new_case.engineSize / max_values('engineSize'));
                  end
                  
                  if isfield(new_case,'fuelSystem')
        distances(1,18) = calculate_local_distance(fuel_system.sim, ...
                                case_library{i,'fuelSystem'}, new_case.fuelSystem);
                  end
                  
                
                    if isfield(new_case,'bore')
        distances(1,19) = calculate_euclidean_distance(case_library{i,'bore'} / max_values('bore'), ... 
                                new_case.bore / max_values('bore'));
                    end
    
                  if isfield(new_case,'stroke')
        distances(1,20) = calculate_euclidean_distance(case_library{i,'stroke'} / max_values('stroke'), ... 
                                new_case.stroke / max_values('stroke'));
                  end
                
                    if isfield(new_case,'compressionRatio')
        distances(1,21) = calculate_euclidean_distance(case_library{i,'compressionRatio'} / max_values('compressionRatio'), ... 
                                new_case.compressionRatio / max_values('compressionRatio'));
                    end
                
                      if isfield(new_case,'horsePower')
        distances(1,22) = calculate_euclidean_distance(case_library{i,'horsePower'} / max_values('horsePower'), ... 
                                new_case.horsePower / max_values('horsePower'));
                      end
                
                        if isfield(new_case,'peakRPM')
        distances(1,23) = calculate_euclidean_distance(case_library{i,'peakRPM'} / max_values('peakRPM'), ... 
                                new_case.peakRPM / max_values('peakRPM'));
                        end
                    
                  if isfield(new_case,'cityMPG')
        distances(1,24) = calculate_euclidean_distance(case_library{i,'cityMPG'} / max_values('cityMPG'), ... 
                                new_case.cityMPG / max_values('cityMPG'));
                  end
                
                    if isfield(new_case,'highwayMPG')
        distances(1,25) = calculate_euclidean_distance(case_library{i,'highwayMPG'} / max_values('highwayMPG'), ... 
                                new_case.highwayMPG / max_values('highwayMPG'));
                    end
                
                   
    distances(to_remove)=[]; %para os dois vetores terem o mm tamanho
    
                            
        final_similarity = 1 - ((distances *   weighting_factors') / sum(weighting_factors));
        
        if final_similarity >= threshold
            retrieved_indexes = [retrieved_indexes i];
            similarities = [similarities final_similarity];
            
        end
        
        
        fprintf('Caso %d tem similaridade de %.2f%%...\n', i,final_similarity*100);
 end
 
  function [make_sim] =  get_make_similarities()
   
     make_sim.categories = categorical({'alfa-romero', 'audi', 'bmw', 'chevrolet', 'dodge', 'honda', 'isuzu', 'jaguar','mazda','mercedes-benz','mercury','mitsubishi','nissan','peugot','plymouth','porsche','saab','subaru','toyota','volkswagen','volvo','renault'});
 
    make_sim.similarities = [
%     'alfa-romero',     'audi', 'bmw', 'chevrolet', 'dodge', 'honda',  'isuzu' 'jaguar','mazda','mercedes-benz','mercury','mitsubishi','nissan','peugot','plymouth','porsche','saab','subaru','toyota','volkswagen''volvo''renault'
           1.0            0.4     0.4     0.7         0.2       0.8       0.1     0.2       0.7      0.4           0.3         0.5        0.8       0.8      0.2        0.5    0.2     0.2      0.9         0.6      0.5    0.5 % Alfa-romeo
           0.4            1.0     0.9     0.6         0.5       0.5       0.4     0.6       0.7      0.9           0.3         0.4        0.4       0.7      0.2        0.7    0.1     0.3      0.6         0.6      0.7    0.3    % Audi
           0.4            0.9     1.0     0.8         0.9       0.8       0.2     0.6       0.6      0.8           0.5         0.6        0.5       0.6      0.4        0.7    0.3     0.3      0.6         0.6      0.6    0.3    % bmw
           0.7            0.6     0.8     1.0         0.8       0.5       0.1     0.2       0.7      0.6           0.4         0.7        0.7       0.7      0.3        0.5    0.2     0.2      0.5         0.6      0.8    0.3     % chevrolet
           0.2            0.5     0.9     0.8         1.0       0.2       0.1     0.4       0.4      0.7           0.3         0.7        0.4       0.5      0.4        0.6    0.2     0.1      0.5         0.4      0.5    0.4    % dodge
           0.8            0.5     0.8     0.5         0.2       1.0       0.8     0.3       0.7      0.4           0.4         0.6        0.7       0.7      0.3        0.4    0.7     0.3      0.7         0.6      0.6    0.6    % honda
           0.1            0.4     0.2     0.1         0.1       0.8       1.0     0.2       0.4      0.4           0.6         0.6        0.5       0.4      0.2        0.2    0.4     0.7      0.5         0.5      0.4    0.5    % isuzu
           0.2            0.6     0.6     0.2         0.4       0.3       0.2     1.0       0.4      0.5           0.6         0.4        0.3       0.4      0.6        0.6    0.4     0.2      0.4         0.5      0.5    0.4    % jaguar
           0.7            0.7     0.6     0.7         0.4       0.7       0.4     0.4       1.0      0.5           0.6         0.6        0.7       0.7      0.4        0.4    0.8     0.3      0.7         0.5      0.6    0.4    %'mazda'
           0.4            0.9     0.8     0.6         0.7       0.4       0.4     0.5       0.5      1.0           0.8         0.5        0.5       0.7      0.5        0.6    0.4     0.4      0.5         0.6      0.5    0.5    %'mercede-benz',
           0.3            0.3     0.5     0.4         0.3       0.4       0.6     0.6       0.6      0.8           1.0         0.5        0.4       0.4      0.4        0.6    0.3     0.1      0.3         0.4      0.3    0.3    %'mercury',
           0.5            0.4     0.6     0.7         0.7       0.6       0.6     0.4       0.6      0.5           0.5         1.0        0.6       0.6      0.4        0.5    0.3     0.6      0.5         0.6      0.4    0.4    %'mitsubishi',
           0.8            0.4     0.5     0.7         0.4       0.7       0.5     0.3       0.7      0.5           0.4         0.6        1.0       0.6      0.4        0.4    0.7     0.3      0.8         0.7      0.6    0.6    %'nissan',
           0.8            0.7     0.6     0.7         0.5       0.7       0.4     0.4       0.7      0.7           0.4         0.6        0.6       1.0      0.2        0.4    0.6     0.5      0.7         0.7      0.5    0.4    %'peugeot',
           0.2            0.2     0.4     0.3         0.4       0.3       0.2     0.6       0.4      0.5           0.4         0.4        0.4       0.2      1.0        0.6    0.3     0.2      0.4         0.4      0.4    0.3    %'plymouth',
           0.5            0.7     0.7     0.5         0.6       0.4       0.2     0.6       0.4      0.6           0.6         0.5        0.4       0.4      0.6        1.0    0.2     0.1      0.4         0.4      0.4    0.3    %'porsche',
           0.2            0.1     0.3     0.2         0.2       0.7       0.4     0.4       0.8      0.4           0.3         0.3        0.7       0.6      0.3        0.2    1.0     0.2      0.6         0.5      0.5    0.3    %'saab',
           0.2            0.3     0.3     0.2         0.1       0.3       0.7     0.2       0.3      0.4           0.1         0.6        0.3       0.5      0.2        0.1    0.2     1.0      0.6         0.4      0.3    0.3    %'subaru',
           0.9            0.6     0.6     0.5         0.5       0.7       0.5     0.4       0.7      0.5           0.3         0.5        0.8       0.7      0.4        0.4    0.6     0.6      1.0         0.5      0.6    0.6    %'toyota',
           0.6            0.6     0.6     0.6         0.4       0.6       0.5     0.5       0.5      0.6           0.4         0.6        0.7       0.7      0.4        0.4    0.5     0.4      0.5         1.0      0.6    0.6    %'volkswagen',
           0.5            0.7     0.6     0.8         0.5       0.6       0.4     0.5       0.6      0.5           0.3         0.4        0.6       0.5      0.4        0.4    0.5     0.3      0.6         0.6      1.0    0.5    %'volvo'
           0.5            0.3     0.3     0.3         0.4       0.6       0.5     0.4       0.4      0.5           0.3         0.4        0.6       0.4      0.3        0.3    0.3     0.3      0.6         0.6      0.5    1.0    %renault
    ];
 end 
        
%         
 function [fuel_sim] = get_fuelType_similarities()
  
    fuel_sim.categories = categorical({'gas', 'diesel'});
    
    fuel_sim.similarities = [
        %gas   %diesel
         1.0     0.6       %gas
         0.6     1.0       %disel
];
 end
 
 
  function [aspiration_sim] = get_aspiration_similarities()
  
    aspiration_sim.categories = categorical({'std', 'turbo'});
    
    aspiration_sim.similarities = [
       % std   %turbo
         1.0     0.5          %std
         0.5     1.0          %turbo
];
  end
 
  
    function [body_style_sim] = get_bodyStyle_similarities()
  
    body_style_sim.categories = categorical({'convertible', 'hatchback','sedan','wagon','hardtop'});
    
    body_style_sim.similarities = [
       % convertible   %hatchback  %sedan  %wagon
         1.0               0.3      0.8      0.1   0.3   %convertible
         0.3               1.0      0.8      0.3   0.2   %hatchback
         0.8               0.8      1.0      0.1   0.7   %sedan
         0.1               0.3      0.1      1.0   0.4   %wagon
         0.3               0.2      0.7      0.4   1.0
];
    end
  
    
function [num_of_doors_sim] = get_numOfDoors_similarities()
  
    num_of_doors_sim.categories = categorical({'two','four'});
    
   num_of_doors_sim.similarities = [
        %two   %four  
         1.0    0.1  %two
         0.1    1.0  %four
];
        end
  
        
 function [drive_wheels_sim] = get_driveWheels_similarities()
  
    drive_wheels_sim.categories = categorical({'rwd', 'fwd','4wd'});
    
   drive_wheels_sim.similarities = [
%        rwd   %fwd    %4wd
         1.0    0.1     0.5    %rwd
         0.1    1.0     0.7    %fwd
         0.5    0.7     1.0    %4wd
         
];
end
        
               
  function [engine_location_sim] = get_engineLocation_similarities()
  
    engine_location_sim.categories = categorical({'front', 'rear'});
    
   engine_location_sim.similarities = [
%        front  %rear  
         1.0     0.2     %front
         0.2     1.0     %rear 
];
  end
  
  
    function [engine_type_sim] = get_engineType_similarities()
  
    engine_type_sim.categories = categorical({'dohc', 'ohcv', 'dohcv', 'l', 'ohc', 'ohcf', 'rotor'}); %%%%%%%%%%%%
    
   engine_type_sim.similarities = [
%        dohc  %ohcv %dohcv  %ohc  %rotor  %ohcf  l  
         1.0    0.2   0.5    0.6     0.5     0.4   0.3    %dohc
         0.2    1.0   0.3    0.5     0.4     0.5   0.6    %ohcv
         0.5    0.3   1.0    0.4     0.5     0.4   0.7    %dohcv
         0.6    0.5   0.4    1.0     0.7     0.4   0.5    %ohc
         0.5    0.4   0.5    0.7     1.0     0.4   0.2    %rotor
         0.4    0.5   0.4    0.4     0.4     1.0   0.4    %ohcf
         0.3    0.6   0.7    0.5     0.2     0.4   1.0    %l
];
    end
    
  
    
   function [Num_of_Cilinders_sim] = get_numbOfCylinders_similarities()
  
        Num_of_Cilinders_sim.categories = categorical({'two', 'three','four','five','six','eight','twelve'});

       Num_of_Cilinders_sim.similarities = [
           % two  %three   %four  %five  %six  %eight  %twelve
             1.0    0.6    0.5    0.4   0.3     0.2     0.1     %two
             0.6    1.0    0.6    0.5   0.4     0.3     0.2     %three
             0.5    0.6    1.0    0.6   0.5     0.4     0.3     %four
             0.4    0.5    0.6    1.0   0.6     0.5     0.4     %five
             0.3    0.4    0.5    0.6   1.0     0.6     0.5     %six
             0.2    0.3    0.4    0.5   0.6     1.0     0.6     %eight
             0.1    0.2    0.3    0.4   0.5     0.6     1.0     %twelve
    ];
  end
        
        
    function [fuel_system_sim] = get_fuelSystem_similarities()
  
   fuel_system_sim.categories = categorical({'mpfi', '2bbl','1bbl','spfi','4bbl','idi','mfi','spdi'});
    
   fuel_system_sim.similarities = [
        %mpfi  %2bbl   %1bbl  %spfi  %4bbl  %idi  %mfi  %spdi 
         1.0   0.2      0.2    0.7    0.2    0.2   0.7    0.6   %mpfi
         0.2   1.0      0.5    0.1    0.5    0.3   0.3    0.4    %2bbl
         0.2   0.5      1.0    0.1    0.4    0.3   0.3    0.5   %1bbl
         0.7   0.1      0.1    1.0    0.4    0.5   0.4    0.6   %spfi
         0.2   0.5      0.4    0.4    1.0    0.5   0.5    0.3   %4bbl
         0.2   0.3      0.5    0.5    0.5    1.0   0.4    0.6   %idi
         0.7   0.3      0.3    0.4    0.5    0.4   1.0    0.7   %mfi
         0.6   0.4      0.5    0.6    0.3    0.6   0.7    1.0   %spdi
];
    end 
    
    function [max_values] = get_max_values(case_library)
   
          key_set = {'symboling','normalizedLosses', 'wheelBase','length','width','height','curbWeight','engineSize','bore','stroke','compressionRatio','horsePower','peakRPM','cityMPG','highwayMPG'};
          value_set = {max(case_library{:,'symboling'}), max(case_library{:,'normalizedLosses'}), max(case_library{:,'wheelBase'}),max(case_library{:,'lenght'}),max(case_library{:,'width'}),max(case_library{:,'height'}), max(case_library{:,'curbWeight'}),max(case_library{:,'engineSize'}),max(case_library{:,'bore'}),max(case_library{:,'stroke'}),max(case_library{:,'compressionRatio'}), max(case_library{:,'horsePower'}), max(case_library{:,'peakRPM'}),max(case_library{:,'cityMPG'}),max(case_library{:,'highwayMPG'})};
          max_values = containers.Map(key_set, value_set);
    end
    
    function [res] = calculate_euclidean_distance(valor1, valor2)
    diferenca= valor1-valor2;
    res = sqrt(diferenca * diferenca);
    end

    function [res] = calculate_local_distance(sim, val1, val2)

        i1 = find(sim.categories == val1);
        i2 = find(sim.categories == val2);
        res = 1 - sim.similarities(i1,i2);
    end

end     