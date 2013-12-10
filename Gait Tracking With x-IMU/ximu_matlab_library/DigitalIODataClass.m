classdef DigitalIODataClass < TimeSeriesDataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_DigitalIO.csv';
        Direction = struct('AX0', [], 'AX1', [], 'AX2', [], 'AX3', [], 'AX4', [], 'AX5', [], 'AX6', [], 'AX7', []);
        State = struct('AX0', [], 'AX1', [], 'AX2', [], 'AX3', [], 'AX4', [], 'AX5', [], 'AX6', [], 'AX7', []);
    end

    %% Public methods
    methods (Access = public)
        function obj = DigitalIOdataClass(varargin)
            fileNamePrefix = varargin{1};
            for i = 2:2:nargin
                if  strcmp(varargin{i}, 'SampleRate'), obj.SampleRate = varargin{i+1};
                else error('Invalid argument.');
                end
            end
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.Direction.AX0 = data(:,2);
            obj.Direction.AX1  = data(:,3);
            obj.Direction.AX2  = data(:,4);
            obj.Direction.AX3  = data(:,5);
            obj.Direction.AX4  = data(:,6);
            obj.Direction.AX5  = data(:,7);
            obj.Direction.AX6  = data(:,8);
            obj.Direction.AX7  = data(:,9);
            obj.State.AX0 = data(:,10);
            obj.State.AX1  = data(:,11);
            obj.State.AX2  = data(:,12);
            obj.State.AX3  = data(:,13);
            obj.State.AX4  = data(:,14);
            obj.State.AX5  = data(:,15);
            obj.State.AX6  = data(:,16);
            obj.State.AX7  = data(:,17);
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
                plot(time, obj.State.AX0, 'r');
                plot(time, obj.State.AX1, 'g');
                plot(time, obj.State.AX2, 'b');
                plot(time, obj.State.AX3, 'k');
                plot(time, obj.State.AX4, ':r');
                plot(time, obj.State.AX5, ':g');
                plot(time, obj.State.AX6, ':b');
                plot(time, obj.State.AX7, ':k');
                title('Digital I/O');
                xlabel(obj.TimeAxis);
                ylabel('State (Binary)');
                legend('AX0', 'AX1', 'AX2', 'AX3', 'AX4', 'AX5', 'AX6', 'AX7');
                hold off;
            end
        end
    end
end