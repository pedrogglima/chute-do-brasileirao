export const errorMessage = (type) => {
  const message =
    "<div id='form_message' class='alert alert-danger'> Ops... ocorreu um erro inesperado. Tente novamente mais tarde ou entre em contato com o suporte.</div>";

  switch (type) {
    case "wrapped":
      return "<div class='col-md-12'>" + message + "</div>";
    case "empty":
      return "<div class='d-block pb-3'></div>";
    default:
      return message;
  }
};

export const handlerErrorXhr = (response) => {
  if (!response.ok) {
    throw Error(response.statusText);
  }
  return response.text();
};
