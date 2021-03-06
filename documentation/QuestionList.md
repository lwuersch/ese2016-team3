# Question list

## Functional requirements

### Requirement 1

> A user can put an ad to sell properties directly or through an auction.

- Should properties for sale be listed on a separate page or should there just be a sign for each property about whether it is for rent or for sale?
- What information about the property needs to be shared, is it the same as for a property that is up for rent?
- How do we make CLEAR (graphically) which properties are for rent and which for sale?
- Should a user be able to put up a property for sale AND rent?
- Should interested users for an auction be able to bid whatever they like or do they have to choose from existing proposals?
- Does the owner of the property need more information about the bidders than just the amount they're bidding? (Should they fill out a form with contact information)
- Direct sale (for a price defined by the manager) possible?

**Answers** got from the customer:

- Clear separation between renting and buying
- Roommates and related functionality are not required anymore
- Additional properties: Last time renovated, building date (age), total price, 
- Auction related: starting price, bidding time, bid incremental
- User needs to be logged in if he wants to participate in an auction
- Direct buying is possible during an auction (with a price defined by the real estate manager)


### Requirement 2

> A user can search for properties for sale similarly to the search form for properties for rent

- Is this a seperate function or is it a choice in the existing search? 
- If in existing search, do you just check a new box saying "for sale" or "for rent"? Should you be able to look for both at once?
- Or should there be two search buttons, one for sale and one for rent? Dropdown menu from search button?
- How similar is similar? Are all the other criterias the same, just with total price instead of monthly rent?
- If there are other criterias, what are they?

**Answers**

- Additional properties: Distance to schools and public traffic, move-in date, size, number of rooms, type (flat/house/loft)
- Search with good defaults, advanced search
- Search criteria always visible

### Requirement 3

> A user can create search alerts which notify him about new ads corresponding the search criteria.

 - Müssen alle Kritieren zurteffen damit der User von neuen Anzeigen benachrichtigt wird? Oder reicht es auch aus, wenn einige Kritieren zutreffen andere aber nicht.( Bsp: 5 Kritieren treffen zu aber eine nicht)
 - Wie wird der User von den neuen entsprechenden Anzeigen benachrichtig? 
Von wem wird er benachrichtig? 
Bekommt der User eine Email vom System?
- Welches sind diese "search criterias"? Bsp: Ort, Mietpreis, Tierfreundlich, Balkon, Lift, etc...
- Inwiefern unterscheidet sich diese Anforderung von der bereits bestehenden Funktion?

**Answers**

- All criteria have to match
- Sending of emails (real emails, not only internal inbox)
- *Automatic* sending of alerts by mail and by the inbox

### Requirement 4

> Extend the search capabilities to cover more filter criteria

- Which additional criteria should the user be able to search for?
- How should the user be able to enter these criteria? Over checkboxes, free text or by choosing search terms from predefined lists?
- Should an "advanced search" button be added, with displays the additional search criteria, or should all the additional criteria be displayed at once in the normal search page?

**Answers**

Already answered in previous sections

### Requirement 5

> Different user roles: Premium and Normal
> 
> - Premium users: get alerts and results early
> - Normal users get the results a bit late
> - The adds of premium user are a bit higher in the result list

- What is meant by early? Immediately?
- What is meant by results?
- What is meant by late? A few hours, a few days?
- How should the ads of premium users be displayed in the list? Simply at the top of the list or should they be highlighted?

**Answers**

Premium users receive notifications immediately

Normal users receive them once a day

Differences in search: Larger image, order of search results of premium users

## Non-functional requirements

### Design

- Should the design be responsive? (e.g. using bootstrap or something similar)
- What is meant by modern?

**General remarks**

- like Immoscout
- find a new name
- new design

most important thing: auctions

