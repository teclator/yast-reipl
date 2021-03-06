# encoding: utf-8

# ------------------------------------------------------------------------------
# Copyright (c) 2006 Novell, Inc. All Rights Reserved.
#
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of version 2 of the GNU General Public License as published by the
# Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, contact Novell, Inc.
#
# To contact Novell about this file by physical or electronic mail, you may find
# current contact information at www.novell.com.
# ------------------------------------------------------------------------------

# File:	clients/reipl.ycp
# Package:	Configuration of reipl
# Summary:	Main file
# Authors:	Mark Hamzy <hamzy@us.ibm.com>
#
# $Id$
#
# Main file for reipl configuration. Uses all other files.
module Yast
  class InstReiplClient < Client
    def main
      Yast.import "UI"

      #**
      # <h3>Configuration of reipl</h3>

      textdomain "reipl"

      Yast.import "Reipl"
      Yast.import "GetInstArgs"
      Yast.import "Mode"
      Yast.import "Wizard"

      Yast.include self, "reipl/complex.rb"
      Yast.include self, "reipl/dialogs.rb"

      # The main ()
      Builtins.y2milestone("Reipl module started ----------------------------------------")

      @args = GetInstArgs.argmap

      if Ops.get_string(@args, "first_run", "yes") != "no"
        Ops.set(@args, "first_run", "yes")
      end

      Wizard.HideAbortButton if Mode.mode == "firstboot"

      @ret = nil

      Reipl.Read

      @ret = Convert.to_symbol(ConfigureDialog())

      # Finish
      Builtins.y2milestone("Reipl module finished ----------------------------------------")

      @ret 

      # EOF
    end
  end
end

Yast::InstReiplClient.new.main
