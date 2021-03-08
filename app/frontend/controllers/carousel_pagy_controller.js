import Carousel from "stimulus-carousel";
import { handlerErrorXhr, errorMessage } from "../lib/request";
const Swiper = require("../lib/carousel_pagy.js");

/*
  Monkey-patch on Stimlus-carousel dependency Swiperjs
  
  From Swiperjs doc.:
    <div class="swiper-slide">
      <img data-src="path/to/picture-1.jpg" class="swiper-lazy" />
      <div class="swiper-lazy-preloader"></div>
    </div>

    As you see:
      - Lazy image source for <img> element should be specified in "data-src" attribute instead of "src"
      - Lazy image source set for <img> element should be specified in "data-srcset" attribute instead of "srcset"
      - Lazy background image source should be specified in "data-background" attribute

  As described above, to make lazy module work with the <img> tag, it must have replaces the datasetss "src" with the dataset "data-src". However, when trying to apply the dataset required by the module, Rails server-side rendering, plus the pre-processor Haml, respond with the following:

    image_tag(data: { src: product.avatar }, class: "swiper-lazy")
    outputs: <img src="image-path.png" class="swiper-lazy" />

    or,

    "<img data-src=/"#{product.avatar}/" class=/"swiper-laze/" />".html_safe
    outputs: <img src="image-path.png" class="swiper-lazy" />

    or,

    %img{"data-src" => "#{product.avatar}", class: "swiper-lazy"}
    outputs: <img src="image-path.png" class="swiper-lazy" />

  As seem above, Rails escapes the dataset "data-src" to "src", and because of that the Lazy module fails to work.

  The monkey patch consist of changing the searched dataset "data-src" to "data-src-url" on the Swiperjs package. 
  
  Package version: stimulus-carousel: "2.0.0"
  The changes are on:
    node_modules/swiper/cjs/components/lazy/lazy.js (lines 39 and 73)
    node_modules/swiper/esm/components/lazy/lazy.js (lines 29 and 63)
*/

/*
  About this controlller

  - This controller offers dynamic pagination for the stimulus-carousel package (stimulus-carousel is just a wrap for Swiperjs https://swiperjs.com/swiper-api). Here you will find the modules for pagination, for loading the preloader and the defaults settings for Swiperjs. 
  - Each carousel has one istance of this controller.
  if this project. 
  - You can load the carousel on the following way (p.s there are some extract html and css added to work with this project e.g spinner):
  
  div.swiper-container.swiper-container-initialized.swiper-container-horizontal{ data: { controller: "carousel-pagy", url: products_url, filled: "false", fetching: "false", page: 1, size: 10, last: 10 } }
    div.swiper-wrapper
      = render partial: @products
        div.swiper-pagination
        div.spinner-border-wrapper.d-none{ data: { "carousel-pagy": { target: "loading" } } }
          div.spinner-border.spinner-small
            %span.sr-only

  - The following datasets are required to work with this controller. 
    - url: used to fetch data
    - page: the current page.
    - filled: state to check if all pages were loaded. 
    - fetchting: state to check if a fetch was already made. 
    - size: the default length of each page fetched. 
    - last: the number of the last page.
*/

export default class extends Carousel {
  static targets = ["loading"];

  connect() {
    super.connect();
    const self = this;

    self.initDynamicPagination(self, 10);
    self.initReachEndLoader(self);

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
     The method only fetches more pages in the following cases:
      - if the state filled is false: it means all pages were fetched.
      - if the state fetching is false: shouldn't make more than one fetch per time.
      - if page number is lesser or equal than the last page number: used to check only on the first fetch. 
      - if (after some swipings) the number of remains slides are greater than the threshold: guarantees that a new fetch will be made before the last item be reached. 
      
  */
  initDynamicPagination(self, threshold) {
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

  // Responsible for showing or not the preloader for the last item on the carousel.
  initReachEndLoader(self) {
    self.swiper.on("reachEnd", function (e) {
      const swiper = new Swiper(e);
      const dataset = swiper.dataset;

      if (dataset.fetching == "true") {
        self.showLoading(self, swiper);
      }
    });
  }

  // ================
  // Aux methods
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
      preloadImages: false,
      lazy: {
        enable: true,
        loadOnTransitionStart: true,
        preloaderClass: "swiper-lazy-preloader",
      },
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
