% Adding file paths
addpath("Images\")
addpath("Matlab_files\")
addpath("Robodk_files\")

%generating a readable backup of the main.mlx file!
FHWS_BACKUP_MLX("main.mlx") 

%clear workspace
clc
clear
close all force
% there is no function to clear the output window for the live script
% right-click and select "Clear all output"

% Setting rdk_status as a global variable to use it with all *.m scripts (speed reasons)
global rdk_status

% Flag: image processing with or without RoboDK
rdk_status = false;

manual_img_name = "Snap_real_wB.png"; % only used if RoboDK_off

% default Simulation image files
%-------------------------------
% Snap_sim.jpg
% Snap_sim_w2Red.jpg
% Snap_sim_w2Red2close.jpg

% default Real image files
%-------------------------
% Snap_real.png
% Snap_real_bright.png
% Snap_real_bright_2.png
% Snap_real_dark.png
% Snap_real_dark_2.png
% Snap_real_wB.png
% Snap_real_wB_bright.png
% Snap_real_wB_dark.png

% Flag: robot motion in simulation or on the real robot
% only used if rdk_status=RoboDK_on
rdk_real_robot = false ;

% Starting RoboDK and loading simulation cell
if rdk_status == true
    global RDK; % setting RoboDK as global to use it with all *.m scripts (speed reasons)
    RDK = Robolink(); % starting RoboDK library
    
    path_rdk = strcat( pwd , '\Robodk_files\'); % setting RoboDK path
    copyfile Robodk_files\ur5e_station.rdk Robodk_files\ur5e_station_temp.rdk % copy of station to protect against unintended changes
    RDK.AddFile([path_rdk, 'ur5e_station_temp.rdk']); % open RoboDK and station
    
    % Set the RoboDK to simulation or real_robot motion
    RDK.setParam('RUN_MODE', num2str(rdk_real_robot))
    
    % Set image folder for camera
    RDK.setParam('PATH_MATLAB', pwd)
    RDK.setParam('PATH_MATLAB_IMAGES', strcat( pwd , '\Images\'))
    
    % Set simulation or real_robot motion
    if rdk_real_robot == false
        RDK.setRunMode(RDK.RUNMODE_SIMULATE)
    else
        RDK.setRunMode(RDK.RUNMODE_RUN_ROBOT) % !! not working yet !! (You can not call py-Programm in real mode :( )
    end
    
    %robot = RDK.Item('UR5e'); % select UR5e node in RoboDK
    %robot.Disconnect()
    robot = RDK.Item('UR5e'); % select UR5e node in RoboDK
    pause(1);
    robot.Connect()
    RDK.setSimulationSpeed(0.5) % set simulation speed
end

% Move the robot to default picture position and take a picture
if rdk_status == true
    RDK_Ur5e_HOME() % move robot to default picture position
    RDK_REALSENSE_SNAP() % take picture
    % set simulation or real_robot as picture input
    if rdk_real_robot == true
        im = iread('Snap_real.png','single');
    else
        im = iread('Snap_sim.jpg','single');
    end
else
    % No RoboDK, we work on a stored image
    im = iread(manual_img_name,'single');
end

disp("Camera image (raw)")
image_raw = imtool(im);
image_raw.Name = "camera image (raw)"
close(image_raw) % closes external image window - comment out if you want to keep it open