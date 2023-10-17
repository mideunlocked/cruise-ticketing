import 'package:cruise/models/attendee.dart';
import 'package:flutter/material.dart';

import '../models/event.dart';
import '../models/event_analysis.dart';
import '../models/pricing.dart';

class EventProvider with ChangeNotifier {
  final List<Event> _events = [
    Event(
      id: "0",
      name: "FireMonesters Wine Party",
      date: DateTime(2023, 10, 24),
      startTime: TimeOfDay.now(),
      endTime: const TimeOfDay(hour: 0, minute: 00),
      venue: "Civic center",
      address: "174 Okota road",
      rules: """
- 18+
- Responsible drinking
- No Outside Alcohol
- Desginated Driver Program
- Fire Safety
""",
      hostId: "0",
      latlng: {
        "lat": 6.499952,
        "lng": 3.346991,
      },
      isValid: true,
      rating: 4.5,
      pricing: [
        Pricing(
          id: 0,
          category: "Regular",
          price: 10000,
          quantity: 100,
          quantityLeft: 99,
        ),
        Pricing(
          id: 1,
          category: "VIP",
          price: 25000,
          quantity: 100,
          quantityLeft: 90,
        ),
        Pricing(
          id: 2,
          category: "VVIP",
          price: 50000,
          quantity: 50,
          quantityLeft: 40,
        ),
        Pricing(
          id: 3,
          category: "Table for 10",
          price: 200000,
          quantity: 50,
          quantityLeft: 45,
        ),
      ],
      imageUrl:
          "https://images.pexels.com/photos/3171837/pexels-photo-3171837.jpeg?auto=compress&cs=tinysrgb&w=600",
      videoUrl: "",
      features: [
        "Pool",
        "Drink",
        "Smoke",
        "Parking",
        "Live DJ",
        "Rave",
        "Photograph",
      ],
      reviews: [],
      attendees: [
        const Attendee(
          price: "10000",
          userId: "1",
          ticketId: "01",
          category: "Regular",
          isValidated: false,
          scannedTime: null,
        ),
        Attendee(
          price: "10000",
          userId: "2",
          ticketId: "02",
          category: "Regular",
          isValidated: true,
          scannedTime: DateTime(2023, 10, 16, 23, 50),
        ),
        Attendee(
          price: "10000",
          userId: "3",
          ticketId: "03",
          category: "Regular",
          isValidated: true,
          scannedTime: DateTime(2023, 10, 16, 23, 54),
        ),
        const Attendee(
            price: "10000",
            userId: "4",
            ticketId: "04",
            category: "Regular",
            isValidated: false,
            scannedTime: null),
        const Attendee(
          price: "10000",
          userId: "5",
          ticketId: "05",
          category: "Regular",
          isValidated: false,
          scannedTime: null,
        ),
        Attendee(
          price: "10000",
          userId: "6",
          ticketId: "06",
          category: "Regular",
          isValidated: true,
          scannedTime: DateTime(2023, 10, 16, 23, 55),
        ),
      ],
      isPrivate: false,
      timestamp: DateTime.now(),
      description: """
A Firemonsters Wine Party is a unique and thrilling event that combines the elegance of wine tasting with the excitement of fire-themed entertainment. This extraordinary party is sure to leave a lasting impression on your guests. Here's a description of what you can expect at a Firemonsters Wine Party:

Decor: The venue is adorned with fire-inspired decorations such as flickering candles, torches, and strategically placed fire pits. Deep reds, oranges, and golds dominate the color scheme, evoking the warm and fiery atmosphere.

Wine Selection: A carefully curated selection of wines is at the heart of the party. Wines from various regions and grape varieties are available for guests to sample. Wine experts or sommeliers may be present to guide guests through the tasting experience, explaining the nuances of each wine.

Food Pairings: To complement the wine tasting, a selection of gourmet appetizers, cheeses, and small bites is served. These pairings are designed to enhance the flavors of the wines and provide a delightful culinary experience.

Fire Performers: The highlight of the Firemonsters Wine Party is the mesmerizing fire performance. Professional fire dancers and fire breathers entertain guests with their awe-inspiring skills. Their choreographed routines and daring stunts create a thrilling and unforgettable spectacle.

Live Music: A live band or a DJ playing sultry, upbeat tunes adds to the festive atmosphere. Guests can dance the night away or simply enjoy the music while sipping their wine.

Fire-themed Entertainment: In addition to fire performers, other fire-themed entertainment may include fire jugglers, fire-eating displays, and even fire sculptures that light up the night.

Dress Code: Guests are encouraged to embrace the theme by wearing attire that reflects fire and passion. This might include fiery reds, oranges, and golds, as well as elegant cocktail dresses and sharp suits.

Fire Safety: Safety is a top priority at a Firemonsters Wine Party. Trained professionals are on hand to ensure the safety of guests during the fire performances, and fire extinguishers and first-aid stations are readily available.

Photography and Social Media: Guests are encouraged to capture the magical moments of the evening and share them on social media with a designated hashtag, creating a buzz around the event.

A Firemonsters Wine Party combines the sophistication of wine tasting with the thrill of fire entertainment, making it a one-of-a-kind experience that will be remembered long after the last glass of wine is emptied. It's an evening of elegance, excitement, and unforgettable moments that will leave your guests talking about it for years to come.
""",
      ticketQuantity: 300,
      analysis: const EventAnalysis(
        ages: [
          {
            "id": 0,
            "age": "18",
            "amount": 100,
          },
          {
            "id": 1,
            "age": "19",
            "amount": 50,
          },
          {
            "id": 2,
            "age": "20",
            "amount": 30,
          },
          {
            "id": 3,
            "age": "21",
            "amount": 20,
          },
          {
            "id": 4,
            "age": "22",
            "amount": 10,
          },
          {
            "id": 5,
            "age": "23",
            "amount": 10,
          },
          {
            "id": 6,
            "age": "24",
            "amount": 10,
          },
          {
            "id": 7,
            "age": "25",
            "amount": 20,
          },
        ],
        genders: [
          {
            "id": 0,
            "gender": "male",
            "amount": 100,
          },
          {
            "id": 1,
            "gender": "females",
            "amount": 100,
          },
          {
            "id": 2,
            "gender": "∞",
            "amount": 50,
          },
        ],
        ticketSold: 250,
        totalViews: 400,
        attendance: 200,
        deviceSales: [
          {
            "platform": "IOS",
            "amount": 200,
          },
          {
            "platform": "Android",
            "amount": 50,
          },
        ],
        ticketQuantity: 300,
        attendeeLocations: [
          {
            "location": "Lagos",
            "amount": 100,
          },
          {
            "location": "Ogun",
            "amount": 50,
          },
          {
            "location": "Ibadan",
            "amount": 20,
          },
          {
            "location": "Imo",
            "amount": 50,
          },
          {
            "location": "Enugu",
            "amount": 30,
          },
        ],
        soldTicketBreakdown: [
          {
            "type": "Regular",
            "value": 80,
            "id": 0,
          },
          {
            "type": "VIP",
            "value": 100,
            "id": 1,
          },
          {
            "type": "VVIP",
            "value": 50,
            "id": 2,
          },
          {
            "type": "Table for 10",
            "value": 20,
            "id": 3,
          },
        ],
      ),
    ),
  ];

  List<dynamic> _savedEvents = [];

  List<Event> get events {
    return [..._events];
  }

  List<dynamic> get savedEvents {
    return [..._savedEvents];
  }

  dynamic addEvent(Event event) {
    try {
      _events.add(event);

      return true;
    } catch (e) {
      print("error creating event: $e");
    }
  }

  void update(Event event) {
    _events.removeWhere(
      (e) => e.id == event.id,
    );
    _events.insert(
      int.parse(event.id) - 1,
      event,
    );
  }

  void deleteEvent(String id) {
    _events.removeWhere((event) => event.id == id);
  }

  Event getEvent(String eventId) {
    final event = _events.firstWhere((e) => e.id == eventId);

    return event;
  }

  void saveEvent(String id) {
    if (_savedEvents.contains(id)) {
      return;
    }
    _savedEvents.add(id);

    print(_savedEvents);
  }

  void unsaveEvent(String id) {
    _savedEvents.remove(id);

    print(_savedEvents);
  }
}
