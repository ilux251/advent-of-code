DIAL_START = 50
FILEPATH = ARGV[0]
ROTATIONS = File.readlines(FILEPATH)

def rotation_char(rotation)
    return rotation[0]
end

def rotation_number(rotation)
    return rotation.sub(/L|R/, '').to_i
end

def rotate(current_pointer, rotation) 
    if (rotation_char(rotation) == "L")
        current_pointer -= rotation_number(rotation)
    else
        current_pointer += rotation_number(rotation)
    end

    return current_pointer
end

def count_direct_pointer_to_zero(rotations)
    current_pointer = DIAL_START
    zero_counter = 0

    rotations.each { | rotation | 
        current_pointer = rotate(current_pointer, rotation)

        current_pointer %= 100

        if (current_pointer == 0)
            zero_counter += 1
        end
    }

    return zero_counter
end

def count_passed_zero_pointer(rotations)
    current_pointer = DIAL_START
    passed_zero_pointer = 0

    rotations.each { | rotation | 
        previous_pointer = current_pointer

        current_pointer = rotate(current_pointer, rotation)

        if (current_pointer < 0)
            passed_zero_pointer += (current_pointer.ceildiv(100) * -1) + 1
        elsif (current_pointer == 0)
            passed_zero_pointer += 1
        else
            passed_zero_pointer += current_pointer / 100
        end

        if (previous_pointer == 0 && current_pointer < 0)
            passed_zero_pointer -= 1
        end

        current_pointer %= 100
    }

    return passed_zero_pointer
end

puts "Counter for direct pointing to zero: #{ count_direct_pointer_to_zero(ROTATIONS) }"
puts "Counter for passed zero pointer: #{ count_passed_zero_pointer(ROTATIONS) }"