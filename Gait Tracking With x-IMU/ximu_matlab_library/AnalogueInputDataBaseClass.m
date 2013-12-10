classdef AnalogueInputDataBaseClass < TimeSeriesDataBaseClass

    %% Abstract public 'read-only' properties
    properties (Abstract, SetAccess = private)
        FileNameAppendage;
    end

    %% Public 'read-only' properties
    properties (SetAccess = private)
        AX0 = [];
        AX1 = [];
        AX2 = [];
        AX3 = [];
        AX4 = [];
        AX5 = [];
        AX6 = [];
        AX7 = [];
    end

    %% Abstract protected properties
    properties (Access = protected)
        ADCunits;
    end

    %% Protected methods
    methods (Access = protected)
        function obj = Import(obj, fileNamePrefix)
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.AX0 = data(:,2);
            obj.AX1 = data(:,3);
            obj.AX2 = data(:,4);
            obj.AX3 = data(:,5);
            obj.AX4 = data(:,6);
            obj.AX5 = data(:,7);
            obj.AX6 = data(:,8);
            obj.AX7 = data(:,9);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
    end

    %% Public methods
    methods (Access = public)
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
                plot(time, obj.AX0, 'r');
                plot(time, obj.AX1, 'g');
                plot(time, obj.AX2, 'b');
                plot(time, obj.AX3, 'k');
                plot(time, obj.AX4, ':r');
                plot(time, obj.AX5, ':g');
                plot(time, obj.AX6, ':b');
                plot(time, obj.AX7, ':k');
                xlabel(obj.TimeAxis);
                ylabel(strcat('Voltage (', obj.ADCunits, ')'));
                title('Analogue Input');
                hold off;
            end
        end
    end
end