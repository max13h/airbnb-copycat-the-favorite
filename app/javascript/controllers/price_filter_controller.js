import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="price-filter"
export default class extends Controller {
  static targets = ["max", "value"]

  setPrice() {
    this.maxTarget.innerText = `${this.valueTarget.value}€`
 this.valueTarget.value }
}
