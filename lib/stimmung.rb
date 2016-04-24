#encoding: utf-8

class Stimmung
  attr_accessor :words

  def initialize(*dicts)
    @words = Hash.new(0.0)
    directory = File.dirname(__FILE__)
    dicts = %w(emoticons.txt german.txt).map! {|file| File.join(directory, file)} if dicts.empty?
    load_dictionary(*dicts)
  end

  def score(str)
    str.downcase.gsub(/(\w{3,})(\W)(?=\s|$)/, '\1').split(/\s|\b(?=\W)/).reduce(0.0) {|s,e| s += @words[e]}
  end

  def load_dictionary(*files)
    files.each do |file|
      File.foreach(file, :encoding => 'UTF-8') do |line|
        score, text = line.chomp!.split
        @words[text.downcase.freeze] = score.to_f
      end
    end
  end
end
