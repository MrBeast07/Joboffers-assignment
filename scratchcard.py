def calculate_points(winning_numbers, your_numbers):
   
    points = 0
    matched_numbers = set() 
    
    
    for number in your_numbers:
       
        if number in winning_numbers and number not in matched_numbers:
          
            points += 1
            matched_numbers.add(number)
           
            points *= 2
    
    return points

def sc():
    while True:
        scratch_card=[input("enter numbers separated by | for spliting winning and your numbers")]
        break

sc()
winning_numbers_str,your_numbers_str=scratch_card.split('|')
winning_numbers = [int(num) for num in winning_numbers_str.split()]
your_numbers = [int(num) for num in your_numbers_str.split()]




points = calculate_points(winning_numbers, your_numbers)
print("Points for the scratch card:", points)
