classdef RotationMatrixDataClass < DataBaseClass

    %% Public 'read-only' properties

    properties (SetAccess = private)
        RotationMatrix = [];
    end

    %% Public 'read-only' properties

    properties (SetAccess = private)
        FileNameAppendage = '_RotationMatrix.csv';
    end

    %% Public methods

    methods (Access = public)
        function obj = Import(obj, fileNamePrefix)
            data = obj.ImportCSV(strcat(fileNamePrefix, obj.FileNameAppendage), 1);
            obj.RotationMatrix = zeros(3, 3, obj.NumSamples);
            obj.RotationMatrix(1,1,:) = data(:,1);
            obj.RotationMatrix(1,2,:) = data(:,2);
            obj.RotationMatrix(1,3,:) = data(:,3);
            obj.RotationMatrix(2,1,:) = data(:,4);
            obj.RotationMatrix(2,2,:) = data(:,5);
            obj.RotationMatrix(2,3,:) = data(:,6);
            obj.RotationMatrix(3,1,:) = data(:,7);
            obj.RotationMatrix(3,2,:) = data(:,8);
            obj.RotationMatrix(3,3,:) = data(:,9);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
        function obj = Plot(obj)
            error('This method is unimplemented.');
        end
    end

end

%% End of class