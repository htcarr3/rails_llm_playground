import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autoscroll"
export default class extends Controller {
  static targets = ["container"]

  connect() {
    this.isAtBottom = true
    this.scrollToBottom()
    
    // Listen for scroll events to track user position
    this.containerTarget.addEventListener("scroll", this.handleScroll.bind(this))

    // Listen for turbo:before-stream-render to prepare for new content
    document.addEventListener("turbo:before-stream-render", this.handleBeforeStreamRender.bind(this))

    // Listen for turbo:after-stream-render to scroll after new content is added
    document.addEventListener("turbo:after-stream-render", this.handleAfterStreamRender.bind(this))
  }

  disconnect() {
    this.containerTarget.removeEventListener("scroll", this.handleScroll.bind(this))
    document.removeEventListener("turbo:before-stream-render", this.handleBeforeStreamRender.bind(this))
    document.removeEventListener("turbo:after-stream-render", this.handleAfterStreamRender.bind(this))
  }

  handleScroll() {
    // Check if user is at the bottom (with small tolerance for floating point precision)
    const { scrollTop, scrollHeight, clientHeight } = this.containerTarget
    this.isAtBottom = Math.abs(scrollHeight - clientHeight - scrollTop) < 5
  }

  handleBeforeStreamRender(event) {
      this.handleScroll()
  }

  handleAfterStreamRender(event) {
    // Only auto-scroll if this stream render is for our messages container
    if (!this.isAtBottom) {
      // Use requestAnimationFrame to ensure DOM has updated
      requestAnimationFrame(() => {
        this.scrollToBottom()
      })
    }
  }

  scrollToBottom() {
    this.containerTarget.scrollTop = this.containerTarget.scrollHeight
  }

  // Action to manually scroll to bottom (can be called from other controllers or manually)
  scrollToBottomAction() {
    this.scrollToBottom()
    this.isAtBottom = true
  }
}