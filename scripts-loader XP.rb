# -*- coding: utf-8 -*-
  #==============================================================================
  # ** ORMS Converter v1.1.0
  #------------------------------------------------------------------------------
  # By Joke @biloumaster <joke@biloucorp.com>
  # GitHub: https://github.com/RMEx/scripts-externalizer
  #------------------------------------------------------------------------------
  # Adapted to RMXP by Az' (very few modifications to match Ruby 1.8 & RMXP)
  #------------------------------------------------------------------------------
  # Loads all scripts in the Scripts folder
  #
  # To add a script: create a newscript.rb in the folder, and add his name
  # in the _list.rb
  #
  # To add a folder: create a new folder, add the name of the folder in _list.rb
  # with a "/" to the end of the name, create a new _list.rb in the folder
  #==============================================================================
  
  module XT_CONFIG
    #==============================================================================
    # ** CONFIGURATION
    #==============================================================================
  
    LOAD_FROM = Dir.pwd + "/Scripts"  # Load the scripts from the folder you want.
                             # Can be "C:/.../MyScripts/" or "../../MyScripts/"
  end
  
  #==============================================================================
  # ** Loader
  #------------------------------------------------------------------------------
  #  Load all scripts
  #==============================================================================
  
  module Loader 
    #--------------------------------------------------------------------------
    # * Extend self
    #--------------------------------------------------------------------------
    extend self
    #--------------------------------------------------------------------------
    # * Run the loader
    #--------------------------------------------------------------------------
    def run
      read_list(XT_CONFIG::LOAD_FROM + "/")
    end
    #--------------------------------------------------------------------------
    # * Read a file
    #--------------------------------------------------------------------------
    def read(file)
      File.open(file, 'r') { |f| f.read }
    end
    #--------------------------------------------------------------------------
    # * Read a list and load all the elements
    #--------------------------------------------------------------------------
    def read_list(path)
      @list = read(path + "_list.rb").split("\n")
      @list.each do |e|
        e.strip!
        print (e)
        print(e[-1])


        next if e[0] == 35  # ASCII Code for Sharp (#)
        if e[-1] == 47      # ASCII Code for Slash (/)
          print (path + e)
          read_list(path + e)
        else
          Kernel.send(:load, path + e + ".rb")
        end
      end
    end
  end
  
  Loader.run