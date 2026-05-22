if rdk_status == true
    % H_sim: homography matrix for the simulation environment
    % homography with 4 points on a plane
    % image                        simulation_world
    % camara_calibration/Top_L:
        i1 = [ 142 ,  124 ];      w1 = [   29 , -473 ];
    % camara_calibration/Top_R:
        i2 = [ 439 ,  124 ];      w2 = [ -209 , -473 ];
    % camara_calibration/Bot_L:
        i3 = [ 156 ,  327 ];      w3 = [   29 , -296 ];
    % camara_calibration/Bot_R:
        i4 = [ 428 ,  327 ];      w4 = [ -209 , -296 ];
    % generating the homography matrix
    p1 = [i1(1), i2(1), i3(1), i4(1); i1(2), i2(2), i3(2), i4(2) ];
    p2 = [w1(1), w2(1), w3(1), w4(1); w1(2), w2(2), w3(2), w4(2)];
    % homography matrix in the simulated world
    H_sim = homography(p1, p2);
    
    % H_real: homography matrix for the real world
    % image                        real_world
    % TBD: insert corresponding points %not used
    % H_real = homography(p1, p2);
    
    if rdk_real_robot == 1
        H_used = H_sim %H_real %not created!
    else
        H_used = H_sim
    end
    
    % distance above the table to grip the block
    z_grip = 0;
    
    % Red block
    try
        % Calculate center point in world coordinates 
        m_red_center_sim = homtrans(H_used,m_red_center); 
        
        % Transition matrix with translation only
        T_red_1 = [ 1, 0, 0, m_red_center_sim(1);
        	        0, 1, 0, m_red_center_sim(2);
        	        0, 0, 1, z_grip;
        	        0, 0, 0, 1                    ];
        
        % Transition matrix with orientation
        T_red_2 = T_red_1 * rotz(-1 * m_red(1).theta);
        
        % Updating the RDK frame
        Frame = RDK.Item('red_part_calculated_frame');
        Frame.setPose( T_red_2 );
    catch ME
        disp("No red block found!")
    end
    
    % Green block
    try
        % Calculate center point in world coordinates 
        m_green_center_sim = homtrans(H_used,m_green_center); 
        
        % Transition matrix with translation only
        T_green_1 = [ 1, 0, 0, m_green_center_sim(1);
        	          0, 1, 0, m_green_center_sim(2);
        	          0, 0, 1, z_grip;
        	          0, 0, 0, 1                    ];
        
        % Transition matrix with orientation
        T_green_2 = T_green_1 * rotz(-1 * m_green(1).theta);
        
        % Updating the RDK frame
        Frame = RDK.Item('green_part_calculated_frame');
        Frame.setPose( T_green_2 );
    catch ME
        disp("No green block found!")
    end
    
    % Blue block
    try
        % Calculate center point in world coordinates 
        m_blue_center_sim = homtrans(H_used,m_blue_center); 
        
        % Transition matrix with translation only
        T_blue_1 = [ 1, 0, 0, m_blue_center_sim(1);
        	         0, 1, 0, m_blue_center_sim(2);
        	         0, 0, 1, z_grip;
        	         0, 0, 0, 1                    ];
        
        % Transition matrix with orientation
        T_blue_2 = T_blue_1 * rotz(-1 * m_blue(1).theta);
        
        % Updating the RDK frame
        Frame = RDK.Item('blue_part_calculated_frame');
        Frame.setPose( T_blue_2 );
    catch ME
        disp("No blue block found!")
    end

end

if rdk_status == true
    % Go to the home position (defined in RoboDK) and open the gripper
    %Go_home()
    %Open_gripper('_')
    RDK_Ur5e_HOME()
    RDK_HandE_DO("activate",["" ""])
    RDK_HandE_DO("open",["" ""])
    
    % Pick the red block
    RDK_Ur5e_MoveL('app_red_calculated_target');
    RDK_Ur5e_MoveL('pick_red_calculated_target');
    RDK_HandE_DO("open_20mm",["pick" "red"])
    RDK_Ur5e_MoveL('app_red_calculated_target');
    
    % Place the red block
    RDK_Ur5e_MoveL('app_place_target');
    RDK_Ur5e_MoveL('place_red_target');
    %Open_gripper('red');
    RDK_HandE_DO("open",["place" "red"])
    RDK_Ur5e_MoveL('app_place_target');
    
    % Pick the green block
    RDK_Ur5e_MoveL('app_green_calculated_target');
    RDK_Ur5e_MoveL('pick_green_calculated_target');
    RDK_HandE_DO("open_20mm",["pick" "green"])
    RDK_Ur5e_MoveL('app_green_calculated_target');
    
    % Place the green block
    RDK_Ur5e_MoveL('app_place_target');
    RDK_Ur5e_MoveL('place_green_target');
    RDK_HandE_DO("open",["place" "green"])
    RDK_Ur5e_MoveL('app_place_target');
    
    % Pick the blue block
    RDK_Ur5e_MoveL('app_blue_calculated_target');
    RDK_Ur5e_MoveL('pick_blue_calculated_target');
    RDK_HandE_DO("open_20mm",["pick" "blue"])
    RDK_Ur5e_MoveL('app_blue_calculated_target');
    
    % Place the blue block
    RDK_Ur5e_MoveL('app_place_target');
    RDK_Ur5e_MoveL('place_blue_target');
    RDK_HandE_DO("open",["place" "blue"])
    RDK_Ur5e_MoveL('app_place_target');
    
    % Go to the home position and open gripper
    %Go_home()
    %Open_gripper('_')
    RDK_Ur5e_HOME()
    RDK_HandE_DO("open",["" ""])
    %
    robot.Disconnect();
end
