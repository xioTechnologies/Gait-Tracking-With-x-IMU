classdef BattThermDataBaseClass < DataBaseClass

    %% Public 'read-only' properties

    properties (SetAccess = private)
        Battery = [];
        Thermometer = [];
    end

    %% Abstract public 'read-only properties

    properties (Abstract, SetAccess = private)
        FileNameAppendage;
    end

    %% Abstract public methods

    methods (Abstract, Access = public)
        Plot(obj);
    end

    %% Public methods

    methods (Access = public)
        function obj = Import(obj, fileNamePrefix)
            data = obj.ImportCSV(strcat(fileNamePrefix, obj.FileNameAppendage), 1);
            obj.Battery = data(:,1);
            obj.Thermometer = data(:,2);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
    end

    %% Protected methods

    methods (Access = protected)
        function fig = PlotRawOrCal(obj, RawOrCal)

            % Define text dependent on Raw or Cal
            if(strcmp(RawOrCal, 'Raw'))
                figName = 'RawBattTherm';
                batteryUnits = 'lsb';
                thermometerUnits = 'lsb';
            elseif(strcmp(RawOrCal, 'Cal'))
                figName = 'CalBattTherm';
                batteryUnits = 'V';
                thermometerUnits = '^\circC';
            else
                error('Invalid argument.');
            end

            % Create time vector and units if SampleRate known
            if(isempty(obj.Time))
                time = 1:obj.NumSamples;
                xLabel = 'Sample';
            else
                time = obj.Time;
                xLabel = 'Time (s)';
            end

            % Plot data
            fig = figure('Number', 'off', 'Name', figName);
            ax(1) = subplot(2,1,1);
            hold on;
            plot(time, obj.Battery);
            xlabel(xLabel);
            ylabel(strcat('Voltage (', batteryUnits, ')'));
            title('Battery Voltmeter');
            hold off;
            ax(2) = subplot(2,1,2);
            hold on;
            plot(time, obj.Thermometer);
            xlabel(xLabel);
            ylabel(strcat('Temperature (', thermometerUnits, ')'));
            title('Thermometer');
            hold off;
            linkaxes(ax,'x');
        end
    end

end

%% End of class