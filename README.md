# Bem

Ruby library for working with BEM(http://bem.info/) in rails projects.

## Installation

Add this line to your application's Gemfile:

    gem 'bem'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bem
    
Then you must create config file:

    $ rails g bem:install

And spring config file if you want to use bem command with `spring` as `spring bem create`

    $ rails g bem:spring
    
After that stop `spring`

    $ spring stop
    
And now you can use command `spring bem create` instead of just `bem create`. `spring` command significantly increase speed of blocks creation.

## Usage

You can create blocks, elements, modificators, levels and manifests with command `bem create`

This command create structure like that

    levelname
        block-name
            __element-name
                _mode-name.scss
                    block-name__element-name_mod-name_value.scss
                block-name__element-name.scss
            _mod-name
                block-name_mod-name_value.scss
            block_name.css.sass

Which is exactly the same as shown here http://bem.info/tools/bem/bem-tools/levels/

It accepts these options:
   
    Options:
        -b, [--block=BLOCK]              # Create or use given block.
        -e, [--element=ELEMENT]          # Create or use given element.
        -m, [--modificator=MODIFICATOR]  # Create modificator.
        -v, [--value=VALUE]              # Value for modificator.
        -l, [--level=LEVEL]              # Create or use given level.
        -a, [--manifest=MANIFEST]        # Manifests to append level
        -j, [--js], [--no-js]            # Do create assets with javascripts
                                         # Default: true
        -s, [--css], [--no-css]          # Do create assets with stylesheets
                                         # Default: true

It will automatically include appropriate information in corresponding levels and manifests.
For adjust technologies and css directives use config/initializers/bem.rb

For detail information about this command:

    $ bem help create
    
For destroy blocks, elements, modificators, levels and manifests use command `bem destroy`. It makes undo of `bem create` command. It accepts these options:

    Options:
        -b, [--block=BLOCK]        # Destroy or use given block.
        -e, [--element=ELEMENT]    # Destroy or use give element.
        -m, [--mod=MOD]            # Destroy modificator.
        -v, [--value=VALUE]        # Value for modificator.
        -l, [--level=LEVEL]        # Destroy or use given level.
        -a, [--manifest=MANIFEST]  # Manifests to append level

For detail information about this command:

    $ bem help destroy
    
This application https://github.com/gkopylov/bem_with_rails_and_less_example_app was created for demonstrate of using this gem.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/bem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
