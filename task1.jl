#
#
#using HorizonSideRobots
#r = Robot(animate=true)

function mark_kross(r::Robot)
     for side in (Nord,West,Sud,Ost)
         num_steps=get_num_steps_put_markers!(r,side)
         movements!(r,inverse(side),num_steps)
     end
     putmarker!(r)
end


inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))


function get_num_steps_put_markers!(r::Robot,side::HorizonSide)
    num_steps = 0
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
        num_steps += 1
    end
    return num_steps
end




movements!(r::Robot,side::HorizonSide,num_steps::Int)=
    for i in 1:num_steps
        move!(r,side)
    end



