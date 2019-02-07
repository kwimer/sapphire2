Selectize.prototype.updateOriginalInput = (opts = {}) ->
    if this.tagType == 1
        options = []
        for item in @.items
            label = this.options[item]?[this.settings.labelField] || ""
            options.push("<option value=\"#{item}\" selected=\"selected\">#{label}</option>")
        if !options.length && !this.$input.attr('multiple')
            options.push('<option value="" selected="selected"></option>')
        this.$input.html(options.join(''))
    else
        @.$input.val(this.getValue())
        @.$input.attr('value',this.$input.val())

    if (this.isSetup)
        if (!opts.silent)
            this.trigger('change', this.$input.val());