class ServerAddresses {
  static const serverAddress =
      "https://happ-meal-backend-jtzoo.ondigitalocean.app";

  //authToken api
  static const authToken = "/auth/signin";

  //endpoint for sign up
  static const signUp = "/auth/signup";
  static const changePassword = "/auth/change-password";
  static const user = "/user";
  static const getUser = "/user/profile";
  static const bmi = "/user/bmi";
  static const userOverview = "/user/overview";
  static const userAllergic = "/user/allergic";
  static const userFavorite = "/user/favorite";
  static const userDisliked = '/user/dislike';

  //create group
  static const createGroup = "/group";

  //retrieve group
  static const getGroupByUser = "/group/by-user";
  static const addMember = "/group/add-member";
  static const removeMember = "/group/remove-member";

  //get member
  static String getMembersInGroup(int groupId) {
    return "/group/member/$groupId";
  }

  //food
  static const food = "/dish";
  static const foodIngredient = '/dish/ingredient';

  //meal
  static const menuDetail = "/menu/";
  static const addDish = "/menu/add-dish";
  static const removeDish = "/menu/remove-dish";
  static const trackDish = "/menu/track";
  static const untrackDish = "/menu/untrack";
  static const updateDish = "/menu/update-dish";
  static const menuGroup = "/menu/group";
  static const addDishGroup = "/menu/group/add-dish";
  static const recommendFood = "/menu/recommend";

  //ingredient
  static const ingredient = "/ingredient";
  static const ingredientCompatible = "/ingredient/incompatible";

  //shopping list
  static const shoppingList = "/shoppingList";
  static const addIngredientToShoppingList = "/shoppingList/add-ingredient";
  static const removeIngredientShoppingList = "/shoppingList/remove-ingredient";
  static const checkIngredient = "/shoppingList/check";
  static const uncheckIngredient = "/shoppingList/uncheck";
  static const updateIngredient = "/shoppingList/update-ingredient";
  static const getGroupIngredient = "/shoppingList/group";
  static const addGroupIngredientToShoppingList =
      "/shoppingList/group/add-ingredient";
  static const getShoppingListByUser = "/shoppingList/by-user";
  static const getShoppingListByGroup = "/shoppingList/by-group";
  static const getIngredient = "/shoppingList/individual";

  //measurement
  static const measurement = "/measurement";

  //classification
  static const classification = "/classification";

  //weight-record
  static const weightRecord = "/weight-record";

  //marketer
  static const shoppingListDetail = "/shoppingList/detail";
  static const assignMarketer = "/shoppingList/assign-marketer";
  static const unassignMarketer = "/shoppingList/unassign-marketer";

  //test notification
  static const notification = "/notification";

  //location
  static const location = '/location';
}
