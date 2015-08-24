class StudentAnswer
  ELIGIBLE_ANSWERS = %w(A B C D).freeze

  def self.key answers
    answers.split('').select! {|a| ELIGIBLE_ANSWERS.include?(a)}
  end
end

class KeySheet
  attr_accessor :answer_collector
  def initialize file
    @file = file
    @answer_collector = Hash.new {|h,k| h[k]=[] }
  end

  def run
    File.foreach(@file) do |line|
      student_key = StudentAnswer.key(line)

      student_key.each_with_index do |ans, i|
        answer_collector[i] << ans 
      end
    end

    analyze_answers
  end

  private

  def analyze_answers
    key = ''
    answer_collector.each do |question, answers|
      key << answers.max
    end

    key
  end
end

puts KeySheet.new('test.txt').run
