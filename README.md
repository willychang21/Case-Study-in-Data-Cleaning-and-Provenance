# Case-Study-in-Data-Cleaning-and-Provenance
## CS 513 – FINAL PROJECT
TEAM 169 - CHIRANJEEVI (CHIRU) KOILOTH, CHUN CHIEH (WILLY) CHANG, AARON BARRIE
### 1. DATASET CHOSEN
Our team has chosen the New York Public Library Historical Menu dataset1, also known as the New York Public Library “What’s on the menu?” dataset.
### 2. DESCRIPTION OF DATASET
The Historical Menu dataset is delivered as a set of four CSV files where each file is representative of an entity in the dataset:
1. Menu.csv
2. MenuPage.csv 
3. Dish.csv
4. MenuItem.csv

Overall, this dataset describes a collection of menus and dishes that exist within a crowdsourced data set produced by the New York Public Library. Each menu is made of a collection of Menu Pages. Each Menu Page is made of a collection of Menu Items. Each Menu Item relates a Menu Page to a Dish, along with pricing information.

The Menu, Menu Page, and Menu Item entities could be considered hierarchical. Each menu represents a single physical document. Each Page belongs to precisely one Menu. Each Menu Item belongs to precisely one Menu Page. The Dish entity is the only entity that can belong to one or many Menu Items, and therefore indirectly belong to one or many Menu Pages, and finally could indirectly belong to one or many Menus.



