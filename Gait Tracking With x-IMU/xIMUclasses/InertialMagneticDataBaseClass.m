classdef InertialMagneticDataBaseClass < DataBaseClass

    %% Public 'read-only' properties

    properties (SetAccess = private)
        Gyroscope = struct('X', [], 'Y', [], 'Z', []);
        Accelerometer = struct('X', [], 'Y', [], 'Z', []);
        Magnetometer = struct('X', [], 'Y', [], 'Z', []);
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
            obj.Gyroscope.X = data(:,1);
            obj.Gyroscope.Y = data(:,2);
            obj.Gyroscope.Z = data(:,3);
            obj.Accelerometer.X = data(:,4);
            obj.Accelerometer.Y = data(:,5);
            obj.Accelerometer.Z = data(:,6);
            obj.Magnetometer.X = data(:,7);
            obj.Magnetometer.Y = data(:,8);
            obj.Magnetometer.Z = data(:,9);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
    end

    %% Protected methods

    methods (Access = protected)
        function fig = PlotRawOrCal(obj, RawOrCal)

            % Define text dependent on Raw or Cal
            if(strcmp(RawOrCal, 'Raw'))
                figName = 'RawInertialMagnetic';
                gyroscopeUnits = 'lsb';
                accelerometerUnits = 'lsb';
                magnetometerUnits = 'lsb';
            elseif(strcmp(RawOrCal, 'Cal'))
                figName = 'CalInertialMagnetic';
                gyroscopeUnits = '^\circ/s';
                accelerometerUnits = 'g';
                magnetometerUnits = 'G';
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
            ax(1) = subplot(3,1,1);
            hold on;
            plot(time, obj.Gyroscope.X, 'r');
            plot(time, obj.Gyroscope.Y, 'g');
            plot(time, obj.Gyroscope.Z, 'b');
            legend('X', 'Y', 'Z');
            xlabel(xLabel);
            ylabel(strcat('Angular rate (', gyroscopeUnits, ')'));
            title('Gyroscope');
            hold off;
            ax(2) = subplot(3,1,2);
            hold on;
            plot(time, obj.Accelerometer.X, 'r');
            plot(time, obj.Accelerometer.Y, 'g');
            plot(time, obj.Accelerometer.Z, 'b');
            legend('X', 'Y', 'Z');
            xlabel(xLabel);
            ylabel(strcat('Acceleration (', accelerometerUnits, ')'));
            title('Accelerometer');
            hold off;
            ax(3) = subplot(3,1,3);
            hold on;
            plot(time, obj.Magnetometer.X, 'r');
            plot(time, obj.Magnetometer.Y, 'g');
            plot(time, obj.Magnetometer.Z, 'b');
            legend('X', 'Y', 'Z');
            xlabel(xLabel);
            ylabel(strcat('Flux (', magnetometerUnits, ')'));
            title('Magnetometer');
            hold off;
            linkaxes(ax,'x');
        end
    end

end

%% End of class