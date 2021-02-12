import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input"];

  inc_value(e) {
    this.inputTargets.forEach((el) => {
      if (el.dataset.id == e.target.dataset.id) {
        let val = parseInt(el.value);
        if (!isNaN(val)) {
          val += 1;
          el.value = val;
        }
      }
    });
  }

  dec_value(e) {
    this.inputTargets.forEach((el) => {
      if (el.dataset.id == e.target.dataset.id) {
        let val = parseInt(el.value);
        if (!isNaN(val) && val > 0) {
          val -= 1;
          el.value = val;
        }
      }
    });
  }
}
