.open ./../ProjectPhaseII-NoConstraints.db

/*****************************************
    NO CONSTRAINT SECTION
*****************************************/
DROP TABLE Menu;
DROP TABLE Dish;
DROP TABLE MenuPage;
DROP TABLE MenuItem;

-- Create Menu table
CREATE TABLE Menu (
    id                   INTEGER PRIMARY KEY,
    name                 TEXT,
    sponsor              TEXT,
    event                TEXT,
    venue                TEXT,
    place                TEXT,
    physical_description TEXT,
    occasion             TEXT,
    notes                TEXT,
    call_number          TEXT,
    keywords             TEXT,
    language             TEXT,
    date                 TEXT,
    location             TEXT,
    location_type        TEXT,
    currency             TEXT,
    currency_symbol      TEXT,
    status               TEXT,
    page_count           INTEGER,
    dish_count           INTEGER
);


-- Create Dish table
CREATE TABLE Dish (
    id             INTEGER PRIMARY KEY,
    name           TEXT,
    description    TEXT,
    menus_appeared INTEGER,
    times_appeared INTEGER,
    first_appeared INTEGER,
    last_appeared  INTEGER,
    lowest_price   NUMERIC,
    highest_price  NUMERIC
);

-- Create MenuPage table
CREATE TABLE MenuPage (
    id          INTEGER PRIMARY KEY,
    menu_id     INTEGER,
    page_number INTEGER,
    image_id    INTEGER,
    full_height INTEGER,
    full_width  INTEGER,
    uuid        TEXT
);


-- Create MenuItem table
CREATE TABLE MenuItem (
    id           INTEGER PRIMARY KEY,
    menu_page_id INTEGER,
    price        NUMERIC,
    high_price   NUMERIC,
    dish_id      INTEGER,
    created_at   TEXT,
    updated_at   TEXT,
    xpos         NUMERIC,
    ypos         NUMERIC
);

DELETE FROM Menu;
DELETE FROM Dish;
DELETE FROM MenuPage;
DELETE FROM MenuItem;

.import --csv --skip 1 ../../01-RawDataSet/Menu.csv Menu
.import --csv --skip 1 ../../01-RawDataSet/Dish.csv Dish
.import --csv --skip 1 ../../01-RawDataSet/MenuPage.csv MenuPage
.import --csv --skip 1 ../../01-RawDataSet/MenuItem.csv MenuItem


/*****************************************
    CONSTRAINT CHECK QUERIES
*****************************************/

SELECT COUNT(*) as 'count', 'Menu_TotalRows' as 'Name' FROM Menu
UNION
SELECT COUNT(*) as 'count', 'Dish_TotalRows' as 'Name' FROM Dish
UNION
SELECT COUNT(*) as 'count', 'MenuItem_TotalRows' as 'Name' FROM MenuItem
UNION
SELECT COUNT(*) as 'count', 'MenuPage_TotalRows' as 'Name' FROM MenuPage;

/*****************************************
    MENU CONSTRAINTS
*****************************************/

-- total rows
/* TABLE Menu TOTAL ROWS */ SELECT COUNT(*)  as 'count', 'Menu_TotalRows' as 'Name' FROM (SELECT id FROM Menu) UNION
/* TABLE Menu MISSING OR EMPTY Id */ SELECT COUNT(*)  as 'count', 'Menu_MissingId' as 'Name' FROM (SELECT id FROM Menu WHERE id is null or id = '') UNION 
/* TABLE Menu MISSING OR EMPTY Name */ SELECT COUNT(*)  as 'count', 'Menu_MissingName' as 'Name' FROM (SELECT id FROM Menu WHERE name is null or name = '') UNION 
/* TABLE Menu MISSING OR EMPTY Sponsor */ SELECT COUNT(*)  as 'count', 'Menu_MissingSponsor' as 'Name' FROM (SELECT id FROM Menu WHERE sponsor is null or sponsor = '') UNION 
/* TABLE Menu MISSING OR EMPTY Event */ SELECT COUNT(*)  as 'count', 'Menu_MissingEvent' as 'Name' FROM (SELECT id FROM Menu WHERE event is null or event = '') UNION 
/* TABLE Menu MISSING OR EMPTY Venue */ SELECT COUNT(*)  as 'count', 'Menu_MissingVenue' as 'Name' FROM (SELECT id FROM Menu WHERE venue is null or venue = '') UNION 
/* TABLE Menu MISSING OR EMPTY Place */ SELECT COUNT(*)  as 'count', 'Menu_MissingPlace' as 'Name' FROM (SELECT id FROM Menu WHERE place is null or place = '') UNION 
/* TABLE Menu MISSING OR EMPTY PhysicalDescription */ SELECT COUNT(*)  as 'count', 'Menu_MissingPhysicalDescription' as 'Name' FROM (SELECT id FROM Menu WHERE physical_description is null or physical_description = '') UNION 
/* TABLE Menu MISSING OR EMPTY Occasion */ SELECT COUNT(*)  as 'count', 'Menu_MissingOccasion' as 'Name' FROM (SELECT id FROM Menu WHERE occasion is null or occasion = '') UNION 
/* TABLE Menu MISSING OR EMPTY Notes */ SELECT COUNT(*)  as 'count', 'Menu_MissingNotes' as 'Name' FROM (SELECT id FROM Menu WHERE notes is null or notes = '') UNION 
/* TABLE Menu MISSING OR EMPTY CallNumber */ SELECT COUNT(*)  as 'count', 'Menu_MissingCallNumber' as 'Name' FROM (SELECT id FROM Menu WHERE call_number is null or call_number = '') UNION 
/* TABLE Menu MISSING OR EMPTY Keywords */ SELECT COUNT(*)  as 'count', 'Menu_MissingKeywords' as 'Name' FROM (SELECT id FROM Menu WHERE keywords is null or keywords = '') UNION 
/* TABLE Menu MISSING OR EMPTY Language */ SELECT COUNT(*)  as 'count', 'Menu_MissingLanguage' as 'Name' FROM (SELECT id FROM Menu WHERE language is null or language = '') UNION 
/* TABLE Menu MISSING OR EMPTY Date */ SELECT COUNT(*)  as 'count', 'Menu_MissingDate' as 'Name' FROM (SELECT id FROM Menu WHERE date is null or date = '') UNION 
/* TABLE Menu MISSING OR EMPTY Location */ SELECT COUNT(*)  as 'count', 'Menu_MissingLocation' as 'Name' FROM (SELECT id FROM Menu WHERE location is null or location = '') UNION 
/* TABLE Menu MISSING OR EMPTY LocationType */ SELECT COUNT(*)  as 'count', 'Menu_MissingLocationType' as 'Name' FROM (SELECT id FROM Menu WHERE location_type is null or location_type = '') UNION 
/* TABLE Menu MISSING OR EMPTY Currency */ SELECT COUNT(*)  as 'count', 'Menu_MissingCurrency' as 'Name' FROM (SELECT id FROM Menu WHERE currency is null or currency = '') UNION 
/* TABLE Menu MISSING OR EMPTY CurrencySymbol */ SELECT COUNT(*)  as 'count', 'Menu_MissingCurrencySymbol' as 'Name' FROM (SELECT id FROM Menu WHERE currency_symbol is null or currency_symbol = '') UNION 
/* TABLE Menu MISSING OR EMPTY Status */ SELECT COUNT(*)  as 'count', 'Menu_MissingStatus' as 'Name' FROM (SELECT id FROM Menu WHERE status is null or status = '') UNION 
/* TABLE Menu MISSING OR EMPTY PageCount */ SELECT COUNT(*)  as 'count', 'Menu_MissingPageCount' as 'Name' FROM (SELECT id FROM Menu WHERE page_count is null or page_count = '') UNION 
/* TABLE Menu MISSING OR EMPTY DishCount */ SELECT COUNT(*)  as 'count', 'Menu_MissingDishCount' as 'Name' FROM (SELECT id FROM Menu WHERE dish_count is null or dish_count = '')
-- MENU: non-unique ID
UNION SELECT COUNT(*)  as 'count', 'Menu_NonUniqueID' as 'Name' FROM (SELECT COUNT(*), id FROM Menu GROUP BY id HAVING COUNT(*) >= 2)
-- MENU: null ID
UNION SELECT COUNT(*)  as 'count', 'Menu_NullID' as 'Name' FROM (SELECT id FROM Menu WHERE id IS NULL)
-- Menu: no pages
UNION SELECT COUNT(*)  as 'count', 'Menu_ZeroPages' as 'Name' FROM (SELECT id FROM Menu WHERE page_count = 0 or page_count IS NULL)
-- Menu: no dishes
UNION SELECT COUNT(*)  as 'count', 'Menu_ZeroDishes' as 'Name' FROM (SELECT id FROM Menu WHERE dish_count = 0 or dish_count IS NULL)
-- Menu: date too early
UNION SELECT COUNT(*)  as 'count', 'Menu_OutlierDateEarly' as 'Name' FROM (SELECT id FROM Menu WHERE datetime(date) < datetime('1850-01-01'))
-- Menu: date too late
UNION SELECT COUNT(*)  as 'count', 'Menu_OutlierDateLate' as 'Name' FROM (SELECT id FROM Menu WHERE datetime(date) > datetime('2023-08-01'))
-- MENU: not referenced by any pages relationally 
UNION SELECT COUNT(*)  as 'count', 'Menu_RelationallyReferencedByZeroPages' as 'Name' FROM (SELECT id FROM Menu WHERE id NOT IN (select menu_id from MenuPage));

/* TABLE Dish TOTAL ROWS */ SELECT COUNT(*)  as 'count', 'Dish_TotalRows' as 'Name' FROM (SELECT id FROM Dish) UNION
/* TABLE Dish MISSING OR EMPTY Id */ SELECT COUNT(*)  as 'count', 'Dish_MissingId' as 'Name' FROM (SELECT id FROM Dish WHERE id is null or id = '') UNION 
/* TABLE Dish MISSING OR EMPTY Name */ SELECT COUNT(*)  as 'count', 'Dish_MissingName' as 'Name' FROM (SELECT id FROM Dish WHERE name is null or name = '') UNION 
/* TABLE Dish MISSING OR EMPTY Description */ SELECT COUNT(*)  as 'count', 'Dish_MissingDescription' as 'Name' FROM (SELECT id FROM Dish WHERE description is null or description = '') UNION 
/* TABLE Dish MISSING OR EMPTY MenusAppeared */ SELECT COUNT(*)  as 'count', 'Dish_MissingMenusAppeared' as 'Name' FROM (SELECT id FROM Dish WHERE menus_appeared is null or menus_appeared = '') UNION 
/* TABLE Dish MISSING OR EMPTY TimesAppeared */ SELECT COUNT(*)  as 'count', 'Dish_MissingTimesAppeared' as 'Name' FROM (SELECT id FROM Dish WHERE times_appeared is null or times_appeared = '') UNION 
/* TABLE Dish MISSING OR EMPTY FirstAppeared */ SELECT COUNT(*)  as 'count', 'Dish_MissingFirstAppeared' as 'Name' FROM (SELECT id FROM Dish WHERE first_appeared is null or first_appeared = '') UNION 
/* TABLE Dish MISSING OR EMPTY LastAppeared */ SELECT COUNT(*)  as 'count', 'Dish_MissingLastAppeared' as 'Name' FROM (SELECT id FROM Dish WHERE last_appeared is null or last_appeared = '') UNION 
/* TABLE Dish MISSING OR EMPTY LowestPrice */ SELECT COUNT(*)  as 'count', 'Dish_MissingLowestPrice' as 'Name' FROM (SELECT id FROM Dish WHERE lowest_price is null or lowest_price = '') UNION 
/* TABLE Dish MISSING OR EMPTY HighestPrice */ SELECT COUNT(*)  as 'count', 'Dish_MissingHighestPrice' as 'Name' FROM (SELECT id FROM Dish WHERE highest_price is null or highest_price = '')
-- DISH: non-unique ID
UNION SELECT COUNT(*)  as 'count', 'Dish_NonUniqueID' as 'Name' FROM (SELECT COUNT(*), id FROM Dish GROUP BY id HAVING COUNT(*) >= 2)
-- DISH: null ID
UNION SELECT COUNT(*)  as 'count', 'Dish_NullID' as 'Name' FROM (SELECT id FROM Dish WHERE id IS NULL)
-- DISH: no menus appeared
UNION SELECT COUNT(*)  as 'count', 'Dish_ZeroMenusAppeared' as 'Name' FROM (SELECT id FROM Dish WHERE menus_appeared = 0 or menus_appeared IS NULL)
-- DISH: no times appeared
UNION SELECT COUNT(*)  as 'count', 'Dish_ZeroTimesAppeared' as 'Name' FROM (SELECT id FROM Dish WHERE times_appeared = 0 or times_appeared IS NULL)
-- DISH: no first year appeared
UNION SELECT COUNT(*)  as 'count', 'Dish_ZeroFirstAppeared' as 'Name' FROM (SELECT id FROM Dish WHERE first_appeared = 0 or first_appeared IS NULL)
-- DISH: no last year appeared
UNION SELECT COUNT(*)  as 'count', 'Dish_ZeroLastAppeared' as 'Name' FROM (SELECT id FROM Dish WHERE last_appeared = 0 or last_appeared IS NULL)
-- DISH: no low price
UNION SELECT COUNT(*)  as 'count', 'Dish_ZeroLowestPrice' as 'Name' FROM (SELECT id FROM Dish WHERE lowest_price = 0 or lowest_price IS NULL)
-- DISH: no high price
UNION SELECT COUNT(*)  as 'count', 'Dish_ZeroHighestPrice' as 'Name' FROM (SELECT id FROM Dish WHERE highest_price = 0 or highest_price IS NULL)
-- DISH: menu appeared relational zero
UNION SELECT COUNT(*)  as 'count', 'Dish_ZeroMenusAppearedRelational' as 'Name' FROM (SELECT id FROM Dish WHERE id NOT IN (select dish_id from MenuItem))
-- DISH: high price less than low price
UNION SELECT COUNT(*)  as 'count', 'Dish_HighPriceLowerThanLowPrice' as 'Name' FROM (SELECT id FROM Dish WHERE highest_price < lowest_price)
-- DISH: unrealistically high low price
UNION SELECT COUNT(*)  as 'count', 'Dish_VeryHighLowPrice' as 'Name' FROM (SELECT id FROM Dish WHERE lowest_price > 500)
-- DISH: unrealistically high high price
UNION SELECT COUNT(*)  as 'count', 'Dish_VeryHighHighPrice' as 'Name' FROM (SELECT id FROM Dish WHERE highest_price > 500)
-- DISH: unrealistically low low price
UNION SELECT COUNT(*)  as 'count', 'Dish_NegativeLowPrice' as 'Name' FROM (SELECT id FROM Dish WHERE lowest_price < 0)
-- DISH: unrealistically low high price
UNION SELECT COUNT(*)  as 'count', 'Dish_NegativeHighPrice' as 'Name' FROM (SELECT id FROM Dish WHERE highest_price < 0)
-- DISH: sync - times appeared with relational test
UNION SELECT COUNT(*)  as 'count', 'Dish_UnreferencedDishWithAppearedCount' as 'Name' FROM (SELECT id FROM Dish WHERE id NOT IN (select dish_id from MenuItem) and times_appeared > 0);

/* TABLE MenuPage TOTAL ROWS */ SELECT COUNT(*)  as 'count', 'MenuPage_TotalRows' as 'Name' FROM (SELECT id FROM MenuPage) UNION
/* TABLE MenuPage MISSING OR EMPTY Id */ SELECT COUNT(*)  as 'count', 'MenuPage_MissingId' as 'Name' FROM (SELECT id FROM MenuPage WHERE id is null or id = '') UNION 
/* TABLE MenuPage MISSING OR EMPTY MenuId */ SELECT COUNT(*)  as 'count', 'MenuPage_MissingMenuId' as 'Name' FROM (SELECT id FROM MenuPage WHERE menu_id is null or menu_id = '') UNION 
/* TABLE MenuPage MISSING OR EMPTY PageNumber */ SELECT COUNT(*)  as 'count', 'MenuPage_MissingPageNumber' as 'Name' FROM (SELECT id FROM MenuPage WHERE page_number is null or page_number = '') UNION 
/* TABLE MenuPage MISSING OR EMPTY ImageId */ SELECT COUNT(*)  as 'count', 'MenuPage_MissingImageId' as 'Name' FROM (SELECT id FROM MenuPage WHERE image_id is null or image_id = '') UNION 
/* TABLE MenuPage MISSING OR EMPTY FullHeight */ SELECT COUNT(*)  as 'count', 'MenuPage_MissingFullHeight' as 'Name' FROM (SELECT id FROM MenuPage WHERE full_height is null or full_height = '') UNION 
/* TABLE MenuPage MISSING OR EMPTY FullWidth */ SELECT COUNT(*)  as 'count', 'MenuPage_MissingFullWidth' as 'Name' FROM (SELECT id FROM MenuPage WHERE full_width is null or full_width = '') UNION
/* TABLE MenuPage MISSING OR EMPTY Uuid */ SELECT COUNT(*)  as 'count', 'MenuPage_MissingUuid' as 'Name' FROM (SELECT id FROM MenuPage WHERE uuid is null or uuid = '')
-- MENUPAGE: None-unique ID
UNION SELECT COUNT(*)  as 'count', 'MenuPage_NonUniqueID' as 'Name' FROM (SELECT COUNT(*), id FROM MenuPage GROUP BY id HAVING COUNT(*) >= 2)
-- MENUPAGE: null ID
UNION SELECT COUNT(*)  as 'count', 'MenuPage_NullID' as 'Name' FROM (SELECT id FROM MenuPage WHERE id IS NULL)
-- MENUPAGE: no menu id appeared
UNION SELECT COUNT(*)  as 'count', 'MenuPage_ZeroMenuId' as 'Name' FROM (SELECT id FROM MenuPage WHERE menu_id = 0 or menu_id IS NULL)
-- MENUPAGE: no valid menu id (FK simulation)
UNION SELECT COUNT(*)  as 'count', 'MenuPage_InvalidMenuId' as 'Name' FROM (SELECT id FROM MenuPage WHERE menu_id NOT IN (SELECT ID FROM Menu))
-- MENUPAGE: no page number
UNION SELECT COUNT(*)  as 'count', 'MenuPage_InvalidPageNumber' as 'Name' FROM (SELECT id FROM MenuPage WHERE page_number <= 0 or page_number IS NULL)
-- MENUPAGE: page number out of range
UNION SELECT COUNT(*)  as 'count', 'MenuPage_PageNumberOutOfRange' as 'Name' FROM (SELECT mp.id FROM MenuPage mp LEFT JOIN Menu m ON mp.menu_id = m.id WHERE mp.page_number > m.page_count)
-- MENUPAGE: more pages by rowcount than in Menu
UNION SELECT COUNT(*)  as 'count', 'MenuPage_RelationalPageCountAggreagte' as 'Name' FROM (SELECT mp.id FROM MenuPage mp LEFT JOIN Menu m ON mp.menu_id = m.id WHERE mp.page_number > m.page_count)
-- MENUPAGE: not referenced by any menuitem
UNION SELECT COUNT(*)  as 'count', 'MenuPage_UnreferencedPage' as 'Name' FROM (SELECT id FROM MenuPage WHERE id NOT IN (select menu_page_id from MenuItem))
-- MENUPAGE: menu page count mismatch - higher
UNION SELECT COUNT(*)  as 'count', 'MenuPage_RelationalPageCountMismatchHigher' as 'Name' FROM (SELECT m.id FROM Menu m LEFT JOIN (SELECT COUNT(*) as page_count, menu_id FROM MenuPage GROUP BY menu_id) mp on m.id = mp.menu_id WHERE mp.page_count < m.page_count)
-- MENUPAGE: menu page count mismatch - lower
UNION SELECT COUNT(*)  as 'count', 'MenuPage_RelationalPageCountMismatchLower' as 'Name' FROM (SELECT m.id FROM Menu m LEFT JOIN (SELECT COUNT(*) as page_count, menu_id FROM MenuPage GROUP BY menu_id) mp on m.id = mp.menu_id WHERE mp.page_count > m.page_count);

/* TABLE MenuItem TOTAL ROWS */ SELECT COUNT(*)  as 'count', 'MenuItem_TotalRows' as 'Name' FROM (SELECT id FROM MenuItem) UNION
/* TABLE MenuItem MISSING OR EMPTY Id */ SELECT COUNT(*)  as 'count', 'MenuItem_MissingId' as 'Name' FROM (SELECT id FROM MenuItem WHERE id is null or id = '') UNION 
/* TABLE MenuItem MISSING OR EMPTY MenuPageId */ SELECT COUNT(*)  as 'count', 'MenuItem_MissingMenuPageId' as 'Name' FROM (SELECT id FROM MenuItem WHERE menu_page_id is null or menu_page_id = '') UNION 
/* TABLE MenuItem MISSING OR EMPTY Price  */ SELECT COUNT(*)  as 'count', 'MenuItem_MissingPrice ' as 'Name' FROM (SELECT id FROM MenuItem WHERE price  is null or price  = '') UNION 
/* TABLE MenuItem MISSING OR EMPTY HighPrice */ SELECT COUNT(*)  as 'count', 'MenuItem_MissingHighPrice' as 'Name' FROM (SELECT id FROM MenuItem WHERE high_price is null or high_price = '') UNION 
/* TABLE MenuItem MISSING OR EMPTY DishId  */ SELECT COUNT(*)  as 'count', 'MenuItem_MissingDishId ' as 'Name' FROM (SELECT id FROM MenuItem WHERE dish_id  is null or dish_id  = '') UNION 
/* TABLE MenuItem MISSING OR EMPTY CreatedAt */ SELECT COUNT(*)  as 'count', 'MenuItem_MissingCreatedAt' as 'Name' FROM (SELECT id FROM MenuItem WHERE created_at is null or created_at = '') UNION 
/* TABLE MenuItem MISSING OR EMPTY UpdatedAt */ SELECT COUNT(*)  as 'count', 'MenuItem_MissingUpdatedAt' as 'Name' FROM (SELECT id FROM MenuItem WHERE updated_at is null or updated_at = '') UNION 
/* TABLE MenuItem MISSING OR EMPTY Xpos */ SELECT COUNT(*)  as 'count', 'MenuItem_MissingXpos' as 'Name' FROM (SELECT id FROM MenuItem WHERE xpos is null or xpos = '') UNION 
/* TABLE MenuItem MISSING OR EMPTY Ypos */ SELECT COUNT(*)  as 'count', 'MenuItem_MissingYpos' as 'Name' FROM (SELECT id FROM MenuItem WHERE ypos is null or ypos = '')
-- MENUITEM: None-unique ID
UNION SELECT COUNT(*)  as 'count', 'MenuItem_NonUniqueID' as 'Name' FROM (SELECT COUNT(*), id FROM MenuItem GROUP BY id HAVING COUNT(*) >= 2)
-- MENUITEM: null ID
UNION SELECT COUNT(*)  as 'count', 'MenuItem_NullID' as 'Name' FROM (SELECT id FROM MenuItem WHERE id IS NULL)
-- MENUITEM: no menu page id appeared
UNION SELECT COUNT(*)  as 'count', 'MenuItem_ZeroMenuPageId' as 'Name' FROM (SELECT id FROM MenuItem WHERE menu_page_id = 0 or menu_page_id IS NULL)
-- MENUITEM: no dish id appeared
UNION SELECT COUNT(*)  as 'count', 'MenuItem_ZeroDishId' as 'Name' FROM (SELECT id FROM MenuItem WHERE dish_id = 0 or dish_id IS NULL)
-- MENUITEM: no valid menu page id (FK simulation)
UNION SELECT COUNT(*)  as 'count', 'MenuItem_InvalidMenuId' as 'Name' FROM (SELECT id FROM MenuItem WHERE menu_page_id NOT IN (SELECT ID FROM MenuPage))
-- MENUITEM: no valid menu dish id (FK simulation)
UNION SELECT COUNT(*)  as 'count', 'MenuItem_InvalidDishId' as 'Name' FROM (SELECT id FROM MenuItem WHERE dish_id NOT IN (SELECT ID FROM Dish))
-- MENUITEM: updated before created
UNION SELECT COUNT(*)  as 'count', 'MenuItem_UpdatedBeforeCreated' as 'Name' FROM (SELECT id FROM MenuItem WHERE datetime(updated_at) < datetime(created_at))
-- MENUITEM: relational price check to MenuItem - price lower than lowest
UNION SELECT COUNT(*)  as 'count', 'MenuItem_PriceLowerThanLowest' as 'Name' FROM (SELECT mi.id from MenuItem mi INNER JOIN Dish d on mi.dish_id = d.id WHERE mi.price < d.lowest_price and mi.price != '' and mi.price is not null)
-- MENUITEM: relational price check to MenuItem - price higher than highest
UNION SELECT COUNT(*)  as 'count', 'MenuItem_PriceHigherThanHighest' as 'Name' FROM (SELECT mi.id from MenuItem mi INNER JOIN Dish d on mi.dish_id = d.id WHERE mi.price > d.highest_price and mi.price != '' and mi.price is not null)
-- MENUITEM: relational price check to MenuItem - high price lower than lowest
UNION SELECT COUNT(*)  as 'count', 'MenuItem_HighPriceLowerThanLowest' as 'Name' FROM (SELECT mi.id from MenuItem mi INNER JOIN Dish d on mi.dish_id = d.id WHERE mi.high_price is not null and mi.high_price != '' and mi.high_price < d.lowest_price)
-- MENUITEM: relational price check to MenuItem - high price higher than highest
UNION SELECT COUNT(*)  as 'count', 'MenuItem_HighPriceHigherThanHighest' as 'Name' FROM (SELECT mi.id from MenuItem mi INNER JOIN Dish d on mi.dish_id = d.id WHERE mi.high_price is not null and mi.high_price != '' and mi.high_price > d.highest_price);