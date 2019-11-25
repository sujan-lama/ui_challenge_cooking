final List<Food> foodList = [
  Food(
      foodName: 'Roasted beetroot & egg salad',
      cookingTime: '35 mins',
      cookingDifficulty: 'Medium',
      foodEffect: 'Healthy',
      foodType: 'Non-Vegetarian',
      foodAssetsPath: 'assets/11.png',
      foodDescription:
          'This vegetarian salad with creamy dill dressing and crunchy hazelnuts makes a great lunch, or light main course.',
      foodIngredient: [
        "16 ounces egg noodles, cooked according to directions on package",
        "2 large onions, diced.",
        "1 -1 1⁄2 lb cabbage, shredded (about 1/2 head)",
        "salt and fresh cracked black pepper, lots and lots and I mean LOTS.",
        "1⁄4 cup salted butter.",
        "4 tablespoons olive oil.",
        "1 cup green peas, frozen."
      ],
      cookingMethod: [
        "Melt butter and olive oil in pan over med high heat.",
        "Saute onions till golden brown, 5-10 minutes.",
        "Add cabbage cook till soft, 15 minutes.",
        "Mix in noodles and frozen peas; season with lots and lots of pepper and salt to taste. (Key here is lots of pepper.).",
        "Cook 2 minutes and serve.",
      ]),
  Food(
      foodName: 'Tuna & red cabbage',
      cookingTime: '20 mins',
      cookingDifficulty: 'Medium',
      foodEffect: 'Spicy',
      foodType: 'Vegetarian',
      foodAssetsPath: 'assets/8.png',
      foodDescription:
          'Serve this crunchy, colourful side dish with fish or chicken - toss with a lemon and sesame seed dressing before serving.',
      foodIngredient: [
        "2 tablespoons butter, divided.",
        "3 eggs, whisked.",
        "2 medium carrots, small dice.",
        "1 small onion, small dice.",
        "3 cloves garlic, minced.",
        "1 cup frozen peas, thawed.",
        "4 cups cooked and chilled rice, (I either use white or brown rice)",
        "3 tablespoons low sodium soy sauce."
      ],
      cookingMethod: [
        "In a 3-quart sized saucepan, rinse uncooked rice with cool water until it runs clear, then drain off excess water.",
        "Add 2 cups of water to the washed rice",
        "Bring water to a boil and then turn down heat to a simmer and cover with a lid.",
        "Simmer rice for 10 to 12 minutes, or until all of the water is absorbed and rice is tender.",
        "Remove rice from the heat and allow to sit covered for 5 to 10 minutes.",
        "Fluff rice with a fork and allow to cool to room temperature while preparing the other fried rice ingredients.",
        "Heat a wok or large skillet over high heat.",
        "Add 1 tablespoon of vegetable oil, once hot add in the rice.",
        "Stir-fry the rice to evenly coated with oil, then spread and lightly press around the pan.",
        "Allow to cook for 30 seconds, then stir. Repeat the spreading and stirring every 30 seconds for 5 minutes total, to encourage some light browning on the rice.",
        "Make a large well in the center of the pan and add in 2 teaspoons of vegetable oil.",
        "Add onion, garlic, and carrots, stir-fry in the center of the pan for 1 minute, then mix with rice to combine.",
        "Make a large well in the center, add in 1 1/2 teaspoon vegetable oil and 1/2 teaspoon sesame oil.",
        "Pour in whisked eggs, allow to sit for about 30 seconds, then gradually stir to create small scrambled egg pieces, stir to combine with the rice.",
        "Add in soy sauce, stir to combine.",
        "Add peas, stir to combine, and cook until warmed through, about 2 minutes.",
        "Taste rice and season with salt and white pepper as desired.",
        "Garnish rice with green onions, serve immediately.",
      ]),
  Food(
      foodName: 'Grilled aubergine tabbouleh',
      cookingTime: '25 mins',
      cookingDifficulty: 'Easy',
      foodEffect: 'Healthy',
      foodType: 'Any',
      foodAssetsPath: 'assets/4.png',
      foodDescription:
          'A vegan tabbouleh with all the flavours of summer. The coconut and tahini dressing adds a creamy, nutty element to this winning couscous.',
      foodIngredient: [],
      cookingMethod: [
        "In a 3-quart sized saucepan, rinse uncooked rice with cool water until it runs clear, then drain off excess water.",
        "Add 2 cups of water to the washed rice",
        "Bring water to a boil and then turn down heat to a simmer and cover with a lid.",
        "Simmer rice for 10 to 12 minutes, or until all of the water is absorbed and rice is tender.",
        "Remove rice from the heat and allow to sit covered for 5 to 10 minutes.",
        "Fluff rice with a fork and allow to cool to room temperature while preparing the other fried rice ingredients.",
        "Heat a wok or large skillet over high heat.",
        "Add 1 tablespoon of vegetable oil, once hot add in the rice.",
        "Stir-fry the rice to evenly coated with oil, then spread and lightly press around the pan.",
        "Allow to cook for 30 seconds, then stir. Repeat the spreading and stirring every 30 seconds for 5 minutes total, to encourage some light browning on the rice.",
        "Make a large well in the center of the pan and add in 2 teaspoons of vegetable oil.",
        "Add onion, garlic, and carrots, stir-fry in the center of the pan for 1 minute, then mix with rice to combine.",
        "Make a large well in the center, add in 1 1/2 teaspoon vegetable oil and 1/2 teaspoon sesame oil.",
        "Pour in whisked eggs, allow to sit for about 30 seconds, then gradually stir to create small scrambled egg pieces, stir to combine with the rice.",
        "Add in soy sauce, stir to combine.",
        "Add peas, stir to combine, and cook until warmed through, about 2 minutes.",
        "Taste rice and season with salt and white pepper as desired.",
        "Garnish rice with green onions, serve immediately.",
      ]),
];

class Food {
  String foodName;
  String cookingDifficulty;
  String cookingTime;
  String foodEffect;
  String foodType;
  String foodAssetsPath;
  String foodDescription;
  List<String> foodIngredient;
  List<String> cookingMethod;

  Food(
      {this.foodName,
      this.cookingDifficulty,
      this.cookingTime,
      this.foodEffect,
      this.foodType,
      this.foodAssetsPath,
      this.foodDescription,
      this.foodIngredient,
      this.cookingMethod});
}
