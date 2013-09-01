classdef DigitalIODataClass < DataBaseClass

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

    %% Public 'read-only' properties

    properties (SetAccess = private)
        FileNameAppendage = '_DigitalIO.csv';
    end

    %% Public methods

    methods (Access = public)
        function obj = Import(obj, fileNamePrefix)
            data = obj.ImportCSV(strcat(fileNamePrefix, obj.FileNameAppendage), 9);
            obj.AX0 = data(:,1);
            obj.AX1 = data(:,2);
            obj.AX2 = data(:,3);
            obj.AX3 = data(:,4);
            obj.AX4 = data(:,5);
            obj.AX5 = data(:,6);
            obj.AX6 = data(:,7);
            obj.AX7 = data(:,8);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
        function fig = Plot(obj)

            % Create time vector and units if SampleRate known
            if(isempty(obj.Time))
                time = 1:obj.NumSamples;
                xLabel = 'Sample';
            else
                time = obj.Time;
                xLabel = 'Time (s)';
            end

            % Plot data
            fig =  figure('Number', 'off', 'Name', 'DigitalIO');
            hold on;
            plot(time, obj.AX0, 'r');
            plot(time, obj.AX1, 'g');
            plot(time, obj.AX2, 'b');
            plot(time, obj.AX3, 'k');
            plot(time, obj.AX4, ':r');
            plot(time, obj.AX5, ':g');
            plot(time, obj.AX6, ':b');
            plot(time, obj.AX7, ':k');
            title('Digital I/O');
            xlabel(xLabel);
            ylabel('State (Binary)');
            legend('AX0', 'AX1', 'AX2', 'AX3', 'AX4', 'AX5', 'AX6', 'AX7');
            hold off;
        end
    end

end

%% End of class