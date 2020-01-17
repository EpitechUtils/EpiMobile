import 'package:mobile_intranet/utils/network/NetworkUtils.dart';

class Netsoul {
    List time = new List<double>();
    double lastWeekLog = 0;
    double weekLog = 0;

    /// Netsoul Ctor
    Netsoul(List record) {
        this.computeNetsoul(record);
    }

    /// Compute log time
    /// This function was retrieved from obfuscated javascript on the Epitech Intranet
    void computeNetsoul(List record) {
        List value = new List<dynamic>();
        int childReference = -1;
        int i = 0;
        int x = 0;
        int val = 0;
        int interval = 0;
        int k = 0;

        for (var key in record) {
            if (childReference != -1 && ((key[0] - record[childReference][0]) / (24 * 3600)) > 1) {
                int j = 1;

                for (; j < interval; i++, j++) {
                    val = x + j * 24 * 3600;
                    value.insert(i, [val, 0]);
                }
            }
            if (key[1] != 1) {
                x = (key[0] + 7200);
                value.insert(i, [x, key[1] / 60 / 60]);
                childReference = k;
                i++;
            } else {
                childReference = -1;
            }
            k++;
        }

        /// Compute last week log time and current week log time
        for (int i = value.length - 7; i < value.length; i++) {
            if (value[i] == null)
                continue;
            this.time.add(value[i][1]);
            this.weekLog += double.parse(value[i][1].toString());
        }
        for (int i = value.length - 14; i < value.length - 7; i++)
            this.lastWeekLog += double.parse(value[i][1].toString());
        this.weekLog = double.parse(this.weekLog.toStringAsFixed(1));
        this.lastWeekLog = double.parse(this.lastWeekLog.toStringAsFixed(1));
    }
}