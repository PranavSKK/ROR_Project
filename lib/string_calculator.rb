class StringCalculator
    def add(numbers)
      return 0 if numbers.empty?
  
      negatives = []
      numbers.split(/[\n,;]/).each do |num|
        num = num.to_i
        if num < 0
          negatives << num
        end
      end
      
      if negatives.any?
        raise "Negative numbers not allowed: #{negatives.join(', ')}"
      end
  
      numbers.split(/[\n,;]/).map(&:to_i).sum
    end
end
  