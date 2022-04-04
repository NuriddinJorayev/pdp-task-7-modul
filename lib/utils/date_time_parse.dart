class DateTimeParse {
  String d;
  DateTimeParse(this.d);

  String get_time_ago([bool b = false]) {
    int year = int.parse(d.split(' ')[0].split("-")[0]);
    int month = int.parse(d.split(' ')[0].split("-")[1]);
    int day = int.parse(d.split(' ')[0].split("-")[2]);

    int hour = int.parse(d.split(' ')[1].split(":")[0]);
    int min = int.parse(d.split(' ')[1].split(":")[1]);
    return b
        ? for_like_page(year, month, day, hour, min)
        : howistime(year, month, day, hour, min);
  }

  String for_like_page(int y, int m, int d, int h, int minmin) {
    int yy = DateTime.now().year;
    int mm = DateTime.now().month;
    int dd = DateTime.now().day;
    int hh = DateTime.now().hour;
    int min = DateTime.now().minute;
    if (yy == y) {
      if (mm == m) {
        if (dd == d) {
          return "Today";
        } else if ((dd - d) == 1) {
          return "Yestoday";
        } else if ((dd - d) > 1 && (dd - d) < 8) {
          return "This Week";
        } else {
          return "This Month";
        }
      } //mm
      return "This Month";
    } // yy
    return "This Month";
  }

  String howistime(int y, int m, int d, int h, int minmin) {
    int yy = DateTime.now().year;
    int mm = DateTime.now().month;
    int dd = DateTime.now().day;
    int hh = DateTime.now().hour;
    int min = DateTime.now().minute;

    if (yy == y) {
      if (mm == m) {
        if (dd == d) {
          if (hh == h) {
            if (min == minmin) {
              return 'just';
            } else {
              return "${(min - minmin)}m";
            }
          } else {
            return "${(hh - h)}h";
          }
        } else {
          if ((dd - d) < 7) {
            return "${(dd - d)}d";
          } else {
            return "${((dd - d) ~/ 7)}w";
          }
        }
      } else {
        if ((dd - d) < 7) {
          return "${((mm - m) * 4)}w";
        }
        return "${((mm - m) * 4) + ((dd - d) ~/ 7)}w";
      }
    } else {
      if ((dd - d) < 7) {
        return "${(((yy - y) * 365) ~/ 7) + ((mm - m) * 4)}w";
      } else {
        return "${(((yy - y) * 365) ~/ 7) + ((mm - m) * 4) + ((dd - d) ~/ 7)}w";
      }
    }
  }
}
