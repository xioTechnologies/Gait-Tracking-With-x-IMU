classdef RawInertialMagneticDataClass < InertialMagneticDataBaseClass

    %% Public 'read-only' properties

    properties (SetAccess = private)
        FileNameAppendage = '_RawInertialMagnetic.csv';
    end

    %% Public methods

    methods (Access = public)
        function obj = RawInertialMagneticDataClass(obj, varargin)
            for i = 1:2:nargin
                if  strcmp(varargin{i}, 'SampleRate'), obj.SampleRate = varargin{i+1};
                else error('Invalid argument.');
                end
            end
        end
        function obj = Plot(obj)
            if(obj.NumSamples == 0)
                error('No data to plot.');
            else
                obj.PlotRawOrCal('Raw');
            end
        end
    end

end

%% End of class