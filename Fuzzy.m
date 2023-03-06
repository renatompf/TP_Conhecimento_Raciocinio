function [ new_priceFuzzy ] = Fuzzy()
    new_price = mamfis;

   new_price = addInput(new_price,[-3 3],'Name','symboling');
   new_price = addInput(new_price,[65 256],'Name','normalizedLosses');
    new_price = addInput(new_price,[60.3 72.3],'Name','width');
   new_price = addInput(new_price,[48 288],'Name','horsePower');
    new_price = addInput(new_price,[13 49],'Name','cityMPG');
    new_price = addInput(new_price,[16 54],'Name','highwayMPG');
    new_price = addOutput(new_price,[5118 45400],'Name','price');

    new_price = addMF(new_price,"symboling", "gaussmf",[1 3],'Name',"perigo");
    new_price = addMF(new_price,"symboling", "gaussmf",[-3 1],'Name',"seguro");

    new_price = addMF(new_price,"normalizedLosses", "gaussmf",[65 160.5],'Name',"gasto_baixo");
    new_price = addMF(new_price,"normalizedLosses", "gaussmf",[161 256],'Name',"gasto_elevado");

    new_price = addMF(new_price,"width", "gaussmf",[60.3 66.3],'Name',"pequeno");
    new_price = addMF(new_price,"width", "gaussmf",[66.3  72.3],'Name',"grande");

    new_price = addMF(new_price,"horsePower", "gaussmf",[48 128],'Name',"pouco");
    new_price = addMF(new_price,"horsePower", "gaussmf",[128 208],'Name',"médio");
    new_price = addMF(new_price,"horsePower", "gaussmf",[208 288],'Name',"muito");


    new_price = addMF(new_price,"cityMPG", "gaussmf",[13 22],'Name',"baixo");
    new_price = addMF(new_price,"cityMPG", "gaussmf",[22 26],'Name',"médio");
    new_price = addMF(new_price,"cityMPG", "gaussmf",[26 49],'Name',"alto");


    new_price = addMF(new_price,"highwayMPG", "gaussmf",[16 23],'Name',"baixo");
    new_price = addMF(new_price,"highwayMPG", "gaussmf",[23 30],'Name',"médio");
    new_price = addMF(new_price,"highwayMPG", "gaussmf",[30 54],'Name',"alto");

    new_price = addMF(new_price,"price", "gaussmf",[5118 15188],'Name',"barato");
    new_price = addMF(new_price,"price", "gaussmf",[15188 25258],'Name',"médio");
    new_price = addMF(new_price,"price", "gaussmf",[25258 35328],'Name',"médio caro");
    new_price = addMF(new_price,"price", "gaussmf",[35328 45400],'Name',"caro");

    %se as normalize losses forem altas ou symboling perigo ou horsepower pouco então vale pouco
    %se as normalize losses forem baixas e highway medio entao preço medio
    %se widht for alto e symboling seguro e o city_mpg medio e horsepower for
    %muito então o preço é carro
    %nr linhas = 3 regras
    %nr colunas = nr variaveis + 2
    regras = [1 2 0 1 0 0 1 1 2
              0 1 0 0 0 2 2 1 1
              2 0 2 3 2 0 4 1 1];

%     regras = [1 2 0  1 1 2
%                0 1 0  2 1 1
%                2 0  0 4 1 1];

    new_price = addRule(new_price,regras);

     for symboling=-3:3
         for normalizedLosses=65:256
              for width=60.3:72.3
                for horsePower=48:288
                   for cityMPG=13:49
                       for highwayMPG=16:54
                            entrada=[symboling normalizedLosses width horsePower cityMPG highwayMPG];
                       %     entrada=[  width  cityMPG highwayMPG];
                            new_priceFuzzy = evalfis(entrada,new_price);
                            fprintf('symboling = %d\normalizedLosses = %d\n width = %d\horsePower = %d\n cityMPG = %d\n highwayMPG = %d\n price = %d\n\n',symboling, normalizedLosses, width, horsePower,cityMPG,highwayMPG, new_priceFuzzy); %out já é o valor desfuzificado
                      %      fprintf(' width = %d\n cityMPG = %d\n highwayMPG = %d\n price = %d\n\n',width, cityMPG,highwayMPG, new_priceFuzzy); 
                       end
                   end
                end
             end 
          end 
     end    
      
end