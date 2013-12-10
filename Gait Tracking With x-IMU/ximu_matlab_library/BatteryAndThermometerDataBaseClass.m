classdef BatteryAndThermometerDataBaseClass < TimeSeriesDataBaseClass

    %% Abstract public 'read-only' properties
    properties (Abstract, SetAccess = private)
        FileNameAppendage;
    end

    %% Public 'read-only' properties
    properties (SetAccess = private)
        Battery = [];
        Thermometer = [];
    end

    %% Abstract protected properties
    properties (Access = protected)
        ThermometerUnits;
        BatteryUnits;
    end

    %% Protected methods
    methods (Access = protected)
        function obj = Import(obj, fileNamePrefix)
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.Battery = data(:,2);
            obj.Thermometer = data(:,3);
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
                ax(1) = subplot(2,1,1);
                hold on;
                plot(time, obj.Battery);
                xlabel(obj.TimeAxis);
                ylabel(strcat('Voltage (', obj.BatteryUnits, ')'));
                title('Battery Voltmeter');
                hold off;
                ax(2) = subplot(2,1,2);
                hold on;
                plot(time, obj.Thermometer);
                xlabel(obj.TimeAxis);
                ylabel(strcat('Temperature (', obj.ThermometerUnits, ')'));
                title('Thermometer');
                hold off;
                linkaxes(ax,'x');
            end
        end
    end
end