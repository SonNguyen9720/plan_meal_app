class ServerAddresses {
  static const serverAddress = "https://happy-meal-backend.herokuapp.com";

  //authToken api
  static const authToken = "/auth/signin";

  //endpoint for sign up
  static const signUp = "/auth/signup";

  //create group
  static const createGroup = "/group";

  //retrieve group
  static const getGroup = "/group/by-user";
  static const addMember = "/group/add-member";
  static const removeMember = "/group/remove-member";

  //get member
  static String getMembersInGroup(int groupId) {
    return "/group/member/$groupId";
  }

  //food
  static const food = "/dish";

  //meal
  static const menuDetail = "/menu/";
  static const addDish = "/menu/add-dish";
  static const removeDish = "/menu/remove-dish";
  static const trackDish = "/menu/track";
  static const updateDish = "/menu/update-dish";

  //ingredient
  static const ingredient = "/ingredient";

  //shopping list
  static const shoppingList = "/shoppingList";
  static const addIngredientToShoppingList = "/shoppingList/add-ingredient";
  static const removeIngredientShoppingList = "/shoppingList/remove-ingredient";
  static const checkIngredient = "/shoppingList/check";
  static const uncheckIngredient = "/shoppingList/uncheck";
  static const updateIngredient = "/shoppingList/update-ingredient";

  //measurement
  static const measurement = "/measurement";

  //classification
  static const classification = "/classification";

}
