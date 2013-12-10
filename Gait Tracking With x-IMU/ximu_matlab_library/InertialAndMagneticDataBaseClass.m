classdef InertialAndMagneticDataBaseClass < TimeSeriesDataBaseClass

    %% Abstract public 'read-only' properties
    properties (Abstract, SetAccess = private)
        FileNameAppendage;
    end

    %% Public 'read-only' properties
    properties (SetAccess = private)
        Gyroscope = struct('X', [], 'Y', [], 'Z', []);
        Accelerometer = struct('X', [], 'Y', [], 'Z', []);
        Magnetometer = struct('X', [], 'Y', [], 'Z', []);
    end

    %% Abstract protected properties
    properties (Access = protected)
        GyroscopeUnits;
        AccelerometerUnits;
        MagnetometerUnits;
    end

    %% Protected methods
    methods (Access = protected)
        function obj = Import(obj, fileNamePrefix)
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.Gyroscope.X = data(:,2);
            obj.Gyroscope.Y = data(:,3);
            obj.Gyroscope.Z = data(:,4);
            obj.Accelerometer.X = data(:,5);
            obj.Accelerometer.Y = data(:,6);
            obj.Accelerometer.Z = data(:,7);
            obj.Magnetometer.X = data(:,8);
            obj.Magnetometer.Y = data(:,9);
            obj.Magnetometer.Z = data(:,10);
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
                ax(1) = subplot(3,1,1);
                hold on;
                plot(time, obj.Gyroscope.X, 'r');
                plot(time, obj.Gyroscope.Y, 'g');
                plot(time, obj.Gyroscope.Z, 'b');
                legend('X', 'Y', 'Z');
                xlabel(obj.TimeAxis);
                ylabel(strcat('Angular rate (', obj.GyroscopeUnits, ')'));
                title('Gyroscope');
                hold off;
                ax(2) = subplot(3,1,2);
                hold on;
                plot(time, obj.Accelerometer.X, 'r');
                plot(time, obj.Accelerometer.Y, 'g');
                plot(time, obj.Accelerometer.Z, 'b');
                legend('X', 'Y', 'Z');
                xlabel(obj.TimeAxis);
                ylabel(strcat('Acceleration (', obj.AccelerometerUnits, ')'));
                title('Accelerometer');
                hold off;
                ax(3) = subplot(3,1,3);
                hold on;
                plot(time, obj.Magnetometer.X, 'r');
                plot(time, obj.Magnetometer.Y, 'g');
                plot(time, obj.Magnetometer.Z, 'b');
                legend('X', 'Y', 'Z');
                xlabel(obj.TimeAxis);
                ylabel(strcat('Flux (', obj.MagnetometerUnits, ')'));
                title('Magnetometer');
                hold off;
                linkaxes(ax,'x');
            end
        end
    end
end