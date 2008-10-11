UnitController
==============

UnitController stubs view rendering to help with unit testing controller.

Loading UnitController:

    gem "unit_controller"
    require "unit_controller"
  
In the setup method for your test case:
  
    def setup
      @controller = SampleController.new
      @request = ActionController::TestRequest.new
      @response = ActionController::TestResponse.new
      @controller.do_not_render_view
    end  

Development
-----------

Active development occurs on the [GitHub](http://github.com/dan-manges/unit-controller). Changes are also pushed to the Rubyforge git repository.

For bugs/patches/etc please use the [Rubyforge tracker](http://rubyforge.org/tracker/?group_id=5086)

Maintainer
----------
[Dan Manges](http://www.dcmanges.com)

Contributors
------------

* David Vollbracht

License
-------
Released under the MIT license
