
class Parse
  def self.parse(string)
    res = []
    string.each_line do |l|
      if l[0] == ':'
        res.push(h1: l[2..-1])
      else
        cur = res[-1]
        if /\{.*\}/.match?(l)
          inputs = cur[:inputs] || []
          cur[:inputs]  = [*(cur[:inputs] || []), l.chomp]
        end
        cur[:p] = cur[:p].nil? ? l : cur[:p] + l
      end
    end

    res
  end
end
