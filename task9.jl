#=
ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер. Робот - в произвольной клетке поля.
РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.
=#
function find_marker(r::Robot)
    num_steps_max=10
    side=Nord
    num_step_turn=1
    while ismarker(r)==false
        for _ in 1:11
            find_marker(r,side,num_steps_max)
            if ismarker(r)==false
            move!(r,Ost)
            side=inverse(side)
            end
        end
    end
end

function find_marker(r::Robot,side::HorizonSide,num_steps_max::Int)
    for _ in 1:num_steps_max
        if ismarker(r)
            return nothing
        end
        move!(r,side)
    end
end
inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))


    
