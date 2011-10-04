homeTemplate = require('templates/home')

class exports.HomeView extends Backbone.View
    id: 'home-view'

    render: ->
        $('body').html $(@el).html homeTemplate()

        @drawInputImage(@drawOutputImage)


    drawInputImage: (callback=(->)) ->
        canvas = document.getElementById('input')
        ctx = canvas.getContext('2d')

        img = new Image()
        img.onload = ->
            ctx.drawImage(img, 0, 0)

            Pixastic.process(canvas, 'edges')
            _.delay((-> callback(ctx.getImageData(0, 0, 1, canvas.height))), 2000)
        img.src = 'images/gradients/double.png'


    drawOutputImage: (imageData, id="output") ->
        canvas = document.getElementById(id)
        ctx = canvas.getContext('2d')

        pixels = []
        for i in [0...imageData.data.length] by 4
            pixel =
                red: imageData.data[i]
                green: imageData.data[i+1]
                blue: imageData.data[i+2]
                alpha: imageData.data[i+3]

            pixels.push(pixel)

        for i in [0...pixels.length]
            pixel = pixels[i]
            sum = pixel.red + pixel.green + pixel.blue
            val = sum / 3
            ctx.fillRect(0, i, val, 1)
