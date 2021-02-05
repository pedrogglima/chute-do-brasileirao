import { Controller } from "stimulus";
import uuidv4 from "uuid/v4";

export default class extends Controller {
  static targets = [];

  connect() {
    if (this.data.has("pid")) {
      const timeId = uuidv4();
      this.data.set("pid", timeId);

      setTimeout(function () {
        const flashs = document.querySelectorAll(".flash-message-pid");

        flashs.forEach((el) => {
          const pid = el.getAttribute("data-flash-message-pid");

          const pidIsPresent = !(pid == null || pid === "");

          if (pidIsPresent && timeId == pid) {
            el.remove();
          }
        });
      }, 12000);
    } else {
      console.error("flash message pid not found");
    }
  }
}
