import { Controller } from "stimulus";
import { handlerErrorXhr, errorMessage } from "../lib/request";

export default class extends Controller {
  static targets = [""];

  connect() {
    this.load();
  }

  load() {
    if (this.data.has("sidebar")) {
      fetch(this.data.get("sidebar"))
        .then(handlerErrorXhr)
        .then((html) => (this.element.innerHTML = html))
        .catch((error) => {
          console.error(error);

          this.element.innerHTML = errorMessage();
        });
    }
  }
}