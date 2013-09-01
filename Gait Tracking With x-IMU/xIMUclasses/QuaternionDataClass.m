classdef QuaternionDataClass < DataBaseClass

    %% Public 'read-only' properties

    properties (SetAccess = private)
        Quaternion = [];
    end

    %% Public 'read-only' properties

    properties (SetAccess = private)
        FileNameAppendage = '_Quaternion.csv';
    end

    %% Public methods

    methods (Access = public)
        function obj = Import(obj, fileNamePrefix)
            data = obj.ImportCSV(strcat(fileNamePrefix, obj.FileNameAppendage), 1);
            obj.Quaternion = data(:,1:4);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
        function obj = Plot(obj)
            error('This method is unimplemented.');
        end
    end

end

%% End of class