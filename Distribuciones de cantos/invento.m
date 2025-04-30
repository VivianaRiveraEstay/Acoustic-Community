% Parámetros del algoritmo genético
numIndividuos = 10;  % Número de individuos en la población
numRasgos = 5;  % Número de rasgos
numGeneraciones = 100;  % Número de generaciones
probMutacion = 0.1;  % Probabilidad de mutación

% Generar población inicial de distribuciones de rasgos
poblacion = cell(numIndividuos, 1);
for i = 1:numIndividuos
    poblacion{i} = randn(numRasgos, 1);
end

% Ejecutar el algoritmo genético
for generacion = 1:numGeneraciones
    % Evaluar el solapamiento entre las distribuciones de rasgos
    solapamiento = calcularSolapamiento(poblacion);
    
    % Calcular la aptitud basada en el solapamiento
    aptitudes = calcularFitness(solapamiento);
    
    % Seleccionar individuos para la reproducción basados en la aptitud
    indicesSeleccionados = seleccionar(aptitudes, numIndividuos);
    
    % Reproducir y mutar para generar una nueva generación
    nuevaPoblacion = cell(numIndividuos, 1);
    for i = 1:numIndividuos
        padre1 = poblacion{indicesSeleccionados(i)};
        padre2 = poblacion{indicesSeleccionados(i+1)};
        
        hijo = recombinar(padre1, padre2);
        hijo = mutar(hijo, probMutacion);
        
        nuevaPoblacion{i} = hijo;
    end
    
    % Reemplazar la población anterior con la nueva generación
    poblacion = nuevaPoblacion;
end

% Mostrar las distribuciones de rasgos finales
for i = 1:numIndividuos
    disp(['Individuo ', num2str(i)]);
    disp(poblacion{i});
end

% Función para calcular el solapamiento entre las distribuciones de rasgos
function solapamiento = calcularSolapamiento(poblacion)
    numIndividuos = numel(poblacion);
    solapamiento = zeros(numIndividuos, numIndividuos);
    
    for i = 1:numIndividuos
        for j = i+1:numIndividuos
            solapamiento(i, j) = sum(min(poblacion{i}, poblacion{j}));
            solapamiento(j, i) = solapamiento(i, j);
        end
    end
end

% Función para calcular la aptitud basada en el solapamiento
function aptitudes = calcularFitness(solapamiento)
    numIndividuos = size(solapamiento, 1);
    aptitudes = zeros(numIndividuos, 1);
    
    for i = 1:numIndividuos
        aptitudes(i) = sum(solapamiento(i, :));
    end
    
    aptitudes = 1 - aptitudes / max(aptitudes);
end

% Función para seleccionar individuos para la reproducción
function indicesSeleccionados = seleccionar(aptitudes, numSeleccionados)
    % Seleccionar basado en la aptitud (proporcional)
    totalAptitudes = sum(aptitudes);
    probabilidades = aptitudes / totalAptitudes;
    indicesSeleccionados = randsample(1:length(aptitudes), numSeleccionados, true, probabilidades);
end

% Función para recombinar dos individuos
function hijo = recombinar(padre1, padre2)
    puntoCorte = randi(numel(padre1));
    hijo = [padre1(1:puntoCorte); padre2(puntoCorte+1:end)];
end

% Función para mutar un individuo
function individuoMutado = mutar(individuo, probMutacion)
    numRasgos = numel(individuo);
    for i = 1:numRasgos
        if rand() < probMutacion
            individuo(i) = individuo(i) + randn();
        end
    end
    individuoMutado = individuo;
end

end