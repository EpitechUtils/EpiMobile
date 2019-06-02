import 'package:mobile_intranet/utils/network/NetworkUtils.dart';

class Netsoul {
    List time = new List<double>();
    List idle;
    List out;
    List idleOut;
    List total;
    List average;

    /// Netsoul Ctor
    Netsoul(List record) {
        this.computeNetsoul(record);
    }

    /// Compute log time
    /// This function was retrieved from obfuscated javascript on the Epitech Intranet
    void computeNetsoul(List record) {
        List value = new List<dynamic>(1000);
        List expected = new List<dynamic>(1000);
        List result = new List<dynamic>(1000);
        List axes = new List<dynamic>(1000);
        List n = new List<dynamic>(1000);
        List indexes = new List<dynamic>(1000);

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
                    value[i] = [val, 0];
                    expected[i] = [val, 0];
                    result[i] = [val, 0];
                    axes[i] = [val, 0];
                    n[i] = [val, 0];
                    indexes[i] = [val, 0];
                }
            }
            if (key[1] != 1) {
                x = (key[0] + 7200);
                value[i] = [x, key[1] / 60 / 60];
                expected[i] = [x, key[2] / 60 / 60];
                result[i] = [x, key[3] / 60 / 60];
                axes[i] = [x, key[4] / 60 / 60];
                n[i] = [x, value[i][1] + expected[i][1] + result[i][1] + axes[i][1]];
                indexes[i] = [x, key[5] / 60 / 60];
                childReference = k;
                i++;
            } else {
                childReference = -1;
            }
            k++;
        }

        /// Assign values with class variables
        this.idle = expected;
        this.out = result;
        this.idleOut = axes;
        this.total = n;
        this.average = indexes;

        for (int i = 305; i < 312; i++)
            this.time.add(value[i][1]);
    }
}