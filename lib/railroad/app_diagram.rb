# RailRoad - RoR diagrams generator
# http://railroad.rubyforge.org
#
# Copyright 2007-2008 - Javier Smaldone (http://www.smaldone.com.ar)
# See COPYING for more details

# Root class for RailRoad diagrams
class AppDiagram

  def initialize(options)
    @options = options
    @graph = DiagramGraph.new
    @graph.show_label = @options.label

    STDERR.print "Loading application environment\n" if @options.verbose
    load_environment

    STDERR.print "Loading application classes\n" if @options.verbose
    load_classes
  end

  # Print diagram
  def print
    if @options.output
      old_stdout = STDOUT.dup
      begin
        STDOUT.reopen(@options.output)
      rescue
        STDERR.print "Error: Cannot write diagram to #{@options.output}\n\n"
        exit 2
      end
    end

    STDOUT.print to_s
    
    if @options.output
      STDOUT.reopen(old_stdout)
    end
  end # print

  def to_s
    if @options.xmi 
        STDERR.print "Generating XMI diagram\n" if @options.verbose
    	@graph.to_xmi
    elsif @options.yuml 
        STDERR.print "Generating yuml diagram\n" if @options.verbose
    	@graph.to_yuml
    else
        STDERR.print "Generating DOT graph\n" if @options.verbose
        @graph.to_dot 
    end
  end
    

  private 

  # Prevents Rails application from writing to STDOUT
  def disable_stdout
    @old_stdout = STDOUT.dup

    # Ruby 1.8.x and 1.9.x compatibility.
    if RUBY_VERSION >= "1.9"
      current_platform = RUBY_PLATFORM
    else
      current_platform = PLATFORM
    end

    STDOUT.reopen(current_platform =~ /mswin/ ? "NUL" : "/dev/null")
  end

  # Restore STDOUT  
  def enable_stdout
    STDOUT.reopen(@old_stdout)
  end


  # Print error when loading Rails application
  def print_error(type)
    STDERR.print "Error loading #{type}.\n  (Are you running " +
                 "#{APP_NAME} on the aplication's root directory?)\n\n"
  end

  # Load Rails application's environment
  def load_environment
    begin
      disable_stdout

      # Ruby 1.8.x and 1.9.x compatibility.
      if RUBY_VERSION >= "1.9"
        environment = CURRENT_PATH + "/config/environment.rb"
      else
        environment = "config/environment"
      end

      require environment

      enable_stdout
    rescue LoadError
      enable_stdout
      puts Dir.pwd
      print_error "application environment"
      raise
    end
  end

  # Extract class name from filename
  def extract_class_name(base, filename)
    # this is will handle directory names as namespace names
    filename.reverse.chomp(base.reverse).reverse.chomp(".rb").camelize
  end

end # class AppDiagram
