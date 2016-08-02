Deface::Override.new(:virtual_path => "layouts/naturesoft/application",
                    :name => "add_slides_link_to_nav",
                    :insert_after => "[data-naturesoft-hook='main_nav']",
                    :partial => "overrides/slides_link",
                    :namespaced => true,
                    :original => 'f5fe48b6dc6986328e0b873b3ffa1b228dd52a7c')