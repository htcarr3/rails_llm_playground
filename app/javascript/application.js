// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "raif"

const afterRenderEvent = new Event("turbo:after-stream-render");
addEventListener("turbo:before-stream-render", (event) => {
    const originalRender = event.detail.render

    event.detail.render = function (streamElement) {
        originalRender(streamElement)
        document.dispatchEvent(afterRenderEvent);
    }
})
