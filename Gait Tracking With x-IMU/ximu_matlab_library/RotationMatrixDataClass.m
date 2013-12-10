classdef RotationMatrixDataClass < TimeSeriesDataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_RotationMatrix.csv';
        RotationMatrix = [];
    end

    %% Public methods
    methods (Access = public)
        function obj = RotationMatrixDataClass(varargin)
            fileNamePrefix = varargin{1};
            for i = 2:2:nargin
                if  strcmp(varargin{i}, 'SampleRate'), obj.SampleRate = varargin{i+1};
                else error('Invalid argument.');
                end
            end
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.RotationMatrix = zeros(3, 3, obj.NumPackets);
            obj.RotationMatrix(1,1,:) = data(:,2);
            obj.RotationMatrix(1,2,:) = data(:,3);
            obj.RotationMatrix(1,3,:) = data(:,4);
            obj.RotationMatrix(2,1,:) = data(:,5);
            obj.RotationMatrix(2,2,:) = data(:,6);
            obj.RotationMatrix(2,3,:) = data(:,7);
            obj.RotationMatrix(3,1,:) = data(:,8);
            obj.RotationMatrix(3,2,:) = data(:,9);
            obj.RotationMatrix(3,3,:) = data(:,10);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
        function obj = Plot(obj)
            error('This method is unimplemented.');
        end
    end
end