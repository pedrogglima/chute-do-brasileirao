/*
  This classes only exist to encapsulate the object swiper from swiperjs and to offer a better interface.
*/

class Slides {
  constructor(slides) {
    this.slides = slides;
  }

  remaning(curretIndex) {
    return this.slides.length - curretIndex;
  }

  get length() {
    return this.slides.length;
  }
}

class Pagination {
  constructor(pagination) {
    this.pagination = pagination;
  }

  hasClass(className) {
    return this.pagination.el.classList.contains(className);
  }

  removeClass(className) {
    return this.pagination.el.classList.remove(className);
  }

  addClass(className) {
    return this.pagination.el.classList.add(className);
  }
}

class Swiper {
  constructor(element) {
    this.swiper = element.el.swiper;
  }

  get slides() {
    return new Slides(this.swiper.slides);
  }

  get pagination() {
    return new Pagination(this.swiper.pagination);
  }

  get element() {
    return this.swiper.el;
  }

  get dataset() {
    return this.swiper.el.dataset;
  }

  get currentIndex() {
    return this.swiper.activeIndex;
  }

  appendSlide(elements) {
    this.swiper.appendSlide(elements);
  }
}

module.exports = Swiper;
