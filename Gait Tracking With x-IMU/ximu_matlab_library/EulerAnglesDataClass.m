classdef EulerAnglesDataClass < TimeSeriesDataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_EulerAngles.csv';
        Phi = [];
        Theta = [];
        Psi = [];
    end

    %% Public methods
    methods (Access = public)
        function obj = EulerAnglesDataClass(varargin)
            fileNamePrefix = varargin{1};
            for i = 2:2:nargin
                if  strcmp(varargin{i}, 'SampleRate'), obj.SampleRate = varargin{i+1};
                else error('Invalid argument.');
                end
            end
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.Phi = data(:,2);
            obj.Theta = data(:,3);
            obj.Psi = data(:,4);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
        function fig = Plot(obj)
            if(obj.NumPackets == 0)
                error('No data to plot.');
            else
                if(isempty(obj.Time))
                    time = 1:obj.NumPackets;
                else
                    time = obj.Time;
                end
                fig = figure('Name', obj.CreateFigName());
                hold on;
                plot(time, obj.Phi, 'r');
                plot(time, obj.Theta, 'g');
                plot(time, obj.Psi, 'b');
                title('Euler angles');
                xlabel(obj.TimeAxis);
                ylabel('Angle (degrees)');
                legend('\phi', '\theta', '\psi');
                hold off;
            end
        end
    end
end