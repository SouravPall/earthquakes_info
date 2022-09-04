import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/earthquake_provider.dart';
import '../utils/constants.dart';
import '../utils/custom_date_picker.dart';
import '../utils/helper_functions.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthquakes List'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  customDatePicker(context, (dateTime) {
                    context
                        .read<EarthquakesProvider>()
                        .selectFromDate(dateTime);
                  });
                },
                child: Consumer<EarthquakesProvider>(
                  builder: (context, provider, child) =>
                      Text(provider.fromDate ?? 'From'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  customDatePicker(context, (dateTime) {
                    context
                        .read<EarthquakesProvider>()
                        .selectToDate(dateTime);
                  });
                },
                child: Consumer<EarthquakesProvider>(
                  builder: (context, provider, child) =>
                      Text(provider.toDate ?? 'To'),
                ),
              ),
              Consumer<EarthquakesProvider>(
                builder: (context, provider, child) =>  DropdownButton<num>(
                  hint: const Text('Magnitude'),
                  items: magnitudes.map((num value) {
                    return DropdownMenuItem<num>(
                      value:  value,
                      child:  Text('$value'),
                    );
                  }).toList(),
                  onChanged: (val) {
                    print('val: $val');
                    provider.selectMagnitude(val!);
                  },
                  value:
                  provider.currentMagnitude,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<EarthquakesProvider>().getEarthQuakeData();
                },
                child: const Text('Go'),
              ),
            ],
          ),
          Expanded(
            child: Consumer<EarthquakesProvider>(
                builder: (context, provider, child) {

                  return provider.earthquakeModel == null ?
                  const Center(child: Text('No data found'))
                      :ListView.separated(
                      itemCount: provider.earthquakeModel!.features!.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final feature = provider.earthquakeModel!.features![index];
                        return Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(13),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                              ),
                              child: Text('${feature.properties!.mag}', style: const TextStyle(
                                color: Colors.white,
                              ),),
                            ),
                            title: Text(feature.properties!.place ?? feature.properties!.title!, style: const TextStyle(color: Colors.white),),
                            subtitle: Text('on ${getFormattedDateTime(
                                feature.properties!.time!, 'dd/MM/yyyy')} at ${getFormattedTime(
                                feature.properties!.time!)}', style: const TextStyle(color: Colors.white60),),
                          ),
                        );
                      }
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
