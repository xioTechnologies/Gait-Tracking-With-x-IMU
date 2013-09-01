classdef DataBaseClass < handle

    %% Public properties

    properties (Access = public)
        SampleRate = 0;
    end

    %% Public 'read-only' properties

    properties (SetAccess = private)
        NumSamples = 0;
        Time = [];
    end

    %% Abstract public 'read-only properties

    properties (Abstract, SetAccess = private)
        FileNameAppendage;
    end

    %% Abstract public methods

    methods (Abstract, Access = public)
        Import(obj, fileNamePrefix);
        Plot(obj);
    end

    %% Get/set methods

    methods
        function obj = set.SampleRate(obj, sampleRate)
            obj.SampleRate = sampleRate;
            if(obj.SampleRate == 0)
                obj.Time = [];
            elseif(obj.NumSamples ~= 0)
                obj.Time = (0:obj.NumSamples-1)' * (1/obj.SampleRate);
            end
        end
    end

    %% Private methods

    methods (Access = protected)
        function data = ImportCSV(obj, fileName, firstColumn)
            data = dlmread(fileName, ',', 1, (firstColumn-1));
            [obj.NumSamples dummy] = size(data);
        end
    end

end

%% End of class