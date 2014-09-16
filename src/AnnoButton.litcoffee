
AnnoButton
==========

    ((root, factory) ->
      if typeof define is 'function' and define.amd
        define ['jquery'], factory
      else if typeof exports is 'object'
        module.exports = factory require 'jquery'
      else
        root.AnnoButton = factory root.$
      return
    ) @, ($) ->

      class AnnoButton

        constructor: (options) ->
          for key,val of options
            this[key]=val

        buttonElem: (anno) ->
          return $("<button class='anno-btn'></button>").
            html( @textFn(anno) ).
            addClass( @className ).
            click( (evt) => @click.call(anno, anno, evt) )

        textFn: (anno) ->
          if @text? then @text
          else if anno._chainNext? then 'Next' else 'Done'

        text: null

        className: ''

`click` is called when your button is clicked.  Note, the `this` keyword is
bound to the parent Anno object.

        click: (anno, evt) ->
          if anno._chainNext?
            anno.switchToChainNext()
          else
            anno.hide()

These are some handy presets that you can use by adding `AnnoButton.NextButton`
to your Anno object's `buttons` list.

        @NextButton: new AnnoButton(
          text: 'Next'
          click: () -> @switchToChainNext()
        )

        @DoneButton: new AnnoButton({ text: 'Done' , click: () -> @hide()  })

        @BackButton: new AnnoButton(
          text: 'Back'
          className: 'anno-btn-low-importance'
          click: () -> @switchToChainPrev()
        )

      return AnnoButton
