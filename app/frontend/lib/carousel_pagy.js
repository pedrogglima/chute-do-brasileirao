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

class Dataset {
  constructor(dataset) {
    this.dataset = dataset;
  }

  get url() {
    return this.dataset.url;
  }

  get filled() {
    return this.dataset.filled;
  }

  set filled(val) {
    this.dataset.filled = val;
  }

  get fetching() {
    return this.dataset.fetching;
  }

  set fetching(val) {
    this.dataset.fetching = val;
  }

  get size() {
    return parseInt(this.dataset.size);
  }

  set size(val) {
    this.dataset.size = parseInt(val);
  }

  get page() {
    return parseInt(this.dataset.page);
  }

  set page(val) {
    this.dataset.page = parseInt(val);
  }

  get last() {
    return parseInt(this.dataset.last);
  }

  set last(val) {
    this.dataset.last = parseInt(val);
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

  get dataset() {
    return new Dataset(this.swiper.el.dataset);
  }

  get element() {
    return this.swiper.el;
  }

  get currentIndex() {
    return this.swiper.activeIndex;
  }

  appendSlide(elements) {
    this.swiper.appendSlide(elements);
  }
}

module.exports = Swiper;
