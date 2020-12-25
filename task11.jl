#=
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)

РЕЗУЛЬТАТ: Робот - в исходном положении, и в 4-х приграничных клетках, две из которых имеют ту же широту, а две - ту же долготу, что и Робот, стоят маркеры.
=#
function mark_centers(r::Robot)
    num_steps = through_rectangles_into_angle(r,(Sud,West))
    # УТВ: Робот - в юго-западном углу и в num_steps - закодирован пройденный путь
    num_steps_to_ost = sum(num_steps[1:2:end])
    num_steps_to_nord = sum(num_steps[2:2:end])

    #---------------------
    movements!(r,Nord,num_steps_to_nord)
    putmarker!(r)
    num_steps_to_sud = movements!(r,Nord)

    movements!(r,Ost,num_steps_to_ost)
    putmarker!(r)
    num_steps_to_west = movements!(r,Ost)

    movements!(r,Sud,num_steps_to_sud)
    putmarker!(r)
    movements!(r,Sud) # возвращаемое значение игнорируется

    movements!(r,Sud,num_steps_to_west)
    putmarker!(r)
    movements!(r,Sud) # возвращаемое значение игнорируется
    # УТВ: Маркеры поставлены и Робот - в юго-западном углу
    #-------------------

    movements!(r,(Ost,Nord),num_steps)
    #УТВ: Робот - в исходном положении
end
function through_rectangles_into_angle(r::Robot,angle::NTuple{2,HorizonSide})
    num_steps=[]
    while isborder(r,angle[1])==false || isborder(r,angle[2]) # Робот - не в юго-западном углу
        push!(num_steps, movements!(r, angle[2]))
        push!(num_steps, movements!(r, angle[1]))
    end
    return num_steps
end
function movements!(r::Robot,sides::HorizonSide,num_steps::Vector{Int})
    for (i,n) in enumerate(num_steps)
        movements!(r, sides[mod(i-1, length(sides))+1], n)
    end
end
movements!(r::Robot,side::HorizonSide)=
    while isborder(r,side)==false
        move!(r,side)
    end
    