$:.unshift File.join(File.dirname(__FILE__), '../..')
require 'railroad'

namespace :doc do
  namespace :diagrams do
    desc "Draw model diagrams"
    task :models, [:options] => :environment do |t, args|
      doc_diagrams_generate(ModelsDiagram, 'models', "-a -m -t -M #{args[:options]}", 'neato')
    end

    desc "Draw controller diagrams"
    task :controllers, [:options] do |t, args|
      doc_diagrams_generate(ControllersDiagram, 'controllers', "-C #{args[:options]}", 'neato')
    end

    desc "Draw states diagrams"
    task :states, [:options]  do |t, args|
      doc_diagrams_generate(AasmDiagram, 'states', "-A #{args[:options]}", 'dot')
    end

    desc "Draw Hobo::Lifecycle diagrams"
    task :lifecycle, [:options]  do |t, args|
      doc_diagrams_generate(LifecycleDiagram, 'lifecycle', "-L #{args[:options]}", 'dot')
    end
end

  desc "Draw controllers, models & states diagrams"
  task :diagrams => %w(diagrams:models diagrams:controllers diagrams:states diagrams:lifecycle)
end

def doc_diagrams_generate(generator, type, opts, dot_cmd)
  options = OptionsStruct.new
  options.parse "-v -j -l -i #{opts}".split(' ')
  
  output_dir = "doc/diagrams"

  FileUtils.mkdir(output_dir) unless File.exist?(output_dir)

  diagram = generator.new options
  diagram.generate
  f=open("#{output_dir}/#{type}.dot", "w")
  f.write(diagram.to_s)
  f.close

  sh "#{dot_cmd} -Tpng #{output_dir}/#{type}.dot -o #{output_dir}/#{type}.png"
  sh "#{dot_cmd} -Tsvg #{output_dir}/#{type}.dot | sed 's/font-size:14.00/font-size:11px/g' > #{output_dir}/#{type}.svg"
end

