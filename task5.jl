#=
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки) 

РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры
=#

function mark_angles(r::Robot)
    num_steps=[]
    while isborder(r,Sud)==false || isborder(r,West) # Робот - не в юго-западном углу
        push!(num_steps, moves!(r, West)) # - добавляется в конец массива новый элемент
        push!(num_steps, moves!(r, Sud))
    end
    # УТВ: Робот - в юго-западном углу и в num_steps - закодирован пройденный путь
    for side in (Nord,Ost,Sud,West)
        moves!(r,side) # возвращаемый результат игнорируется
        putmarker!(r)
    end
    # УТВ: Маркеры поставлены и Робот - в юго-западном углу
    for (i,n) in enumerate(reverse!(num_steps)) # встроенная функция reverse! переворачивает массив задом на перед
        side = isodd(i) ? Ost : Nord # odd - нечетный
        moves!(r,side,n)
    end
    #УТВ: Робот - в исходном положении
end

#=
Последний цикл в этой функции эквивалентен следующему:

    i=0
    for n in reverse!(num_steps)
        i+=1
        side = isodd(i) ? Ost : Nord # odd - нечетный
        moves!(r,side,n)
    end

=#

# перемещает Робота в заданном направлении до упора и возвращает число сделанных шагов
function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

# Перемещает Робота в заданном направлении на заданное число шагов
moves!(r::Robot,side::HorizonSide,num_steps::Int) = for _ in 1:num_steps move!(r,side) end