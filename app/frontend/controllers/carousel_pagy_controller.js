import Carousel from "stimulus-carousel";
import { handlerErrorXhr, errorMessage } from "../lib/request";
const Swiper = require("../lib/carousel_pagy.js");

/*
  - This controller offers pagination for the stimulus-carousel package (stimulus-carousel is just a wrap for Swiperjs https://swiperjs.com/swiper-api). Here you will find the modules for pagination, for loading the loading bar and the defaults settings for the swiperjs. 
  - Each carousel has one istance of this controller.
  - The loading bar (spinner-border-wrapper, spinner-border, ...) html is not part of the Swiperjs. It was added to work if this project. 
  - You can load the carousel on the following way:
  
  div.swiper-container.swiper-container-initialized.swiper-container-horizontal{ data: { controller: "carousel-pagy", url: products_url, filled: "false", fetching: "false", page: 1, size: 10, last: 10 } }
    div.swiper-wrapper
      = render partial: @products
        div.swiper-pagination
        div.spinner-border-wrapper.d-none{ data: { "carousel-pagy": { target: "loading" } } }
          div.spinner-border.spinner-small
            %span.sr-only

  - The following datasets are required. 
    - url is used to fetch data
    - page is the current page.
    - filled is used to check if all pages were loaded. 
    - fetchting is used to control the state of the loading bar. 
    - size is used to calculate if should or should not fetch more pagy. This 
    value must be equal to the page size fetched.
    - last is the last page number
*/

export default class extends Carousel {
  static targets = ["loading"];

  connect() {
    super.connect();
    const self = this;

    self.initPaginate(self, 10);
    self.initLoading(self);

    const dataset = self.swiper.el.dataset;
    // requires that arguments be defined
    if (
      !(
        dataset.url &&
        dataset.filled &&
        dataset.fetching &&
        dataset.size &&
        dataset.page &&
        dataset.last
      )
    ) {
      self.swiper.destroy();
      console.error("missing arguments on carousel-pagy");
    } else {
      self.swiper.init(this.defaultOptions);
    }
  }

  /* Add async function on the event activeIndexChange: for each item swapped this event is trigged.
     The func only fetches more pages in the following cases
      - if the state filled is false 
      - if the state fetching is false
      - if page number is lesser or equal than the last page number  
      - if (after some swipings) the number of remains slides are greater than the threshold  
      
  */
  initPaginate(self, threshold) {
    self.swiper.on("activeIndexChange", function (e) {
      const swiper = new Swiper(e);
      const slides = swiper.slides;
      const dataset = swiper.dataset;

      // don't fetch pages if
      if (
        dataset.filled == "true" ||
        dataset.fetching == "true" ||
        dataset.page >= dataset.last
      )
        return;

      if (slides.remaning(swiper.currentIndex) <= threshold) {
        self.fetchPage(self, swiper);
      }
    });
  }

  // this method is responsible for show or not the loading bar
  // it uses the async event reachEnd: happens when the last page is reached.
  initLoading(self) {
    self.swiper.on("reachEnd", function (e) {
      const swiper = new Swiper(e);
      const dataset = swiper.dataset;

      if (dataset.fetching == "true") {
        self.showLoading(self, swiper);
      }
    });
  }

  // ================
  // Auxiliar methods
  // ================

  fetchPage(self, swiper) {
    const dataset = swiper.dataset;
    const page = dataset.page + 1;
    const url = dataset.url + "?page=" + page;
    dataset.fetching = "true";

    fetch(url)
      .then(handlerErrorXhr)
      .then((html) => {
        if (html == null || html.trim() === "") {
          dataset.filled = "true";
        } else {
          swiper.appendSlide(html);
        }
        dataset.page = page;
      })
      .catch((error) => {
        self.handleError(error, swiper);
      })
      .finally(() => {
        self.showPagination(self, swiper);
        dataset.fetching = "false";
      });
  }

  handleError(error, swiper) {
    console.error(error);
    swiper.element.innerHTML = errorMessage();
  }

  showPagination(self, swiper) {
    self.displayPagination(swiper);
    self.hideLoading(self);
  }

  showLoading(self, swiper) {
    self.hidePagination(swiper);
    self.displayLoading(self);
  }

  displayPagination(swiper) {
    swiper.pagination.removeClass("d-none");
  }

  displayLoading(self) {
    if (self.hasLoadingTarget) {
      self.loadingTarget.classList.remove("d-none");
    }
  }

  hidePagination(swiper) {
    if (!swiper.pagination.hasClass("d-none")) {
      swiper.pagination.addClass("d-none");
    }
  }

  hideLoading(self) {
    if (self.hasLoadingTarget) {
      if (!self.loadingTarget.classList.contains("d-none")) {
        self.loadingTarget.classList.add("d-none");
      }
    }
  }

  //=========================================
  // Default settings for the swiperjs module
  //=========================================

  get defaultOptions() {
    return {
      slidesPerView: 1,
      spaceBetween: 10,
      pagination: {
        el: ".swiper-pagination",
        dynamicBullets: "true",
      },
      breakpoints: {
        288: {
          slidesPerView: "1",
          spaceBetween: "20",
        },
        640: {
          slidesPerView: "1",
          spaceBetween: "20",
        },
        768: {
          slidesPerView: "1",
          spaceBetween: "20",
        },
        1024: {
          slidesPerView: "2",
          spaceBetween: "20",
        },
      },
    };
  }
}
