import 'package:behaviour/behaviour.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/src/dependency_management/feature.dart';
import 'package:shared/src/logging/get_it_behaviour_monitor.dart';
import 'package:shared/src/logging/logging_track.dart';

class LoggingFeature extends Feature {
  const LoggingFeature();

  @override
  void registerTypes(GetIt getIt) {
    getIt.registerFactoryParam<Logger, String, dynamic>(
      (loggerName, _) => _loggerFactory(getIt, loggerName),
    );
    getIt.registerLazySingleton<LogSink>(() {
      final prettyFormatter = PrettyFormatter();
      return PrintSink(
        LevelDependentFormatter(
          defaultFormatter: SimpleFormatter(),
          severe: prettyFormatter,
          shout: prettyFormatter,
        ),
      );
    });
    getIt.registerFactory<BehaviourMonitor>(
      () => getIt.monitor<LoggingTrack>(),
    );
    getIt.registerFactoryParam<LoggingTrack, BehaviourMixin, dynamic>(
      (behaviour, _) => LoggingTrack(
        behaviour: behaviour,
        logger: getIt.logger(behaviour.runtimeType.toString()),
      ),
    );
  }

  Logger _loggerFactory(GetIt getIt, String loggerName) {
    final instanceName = '$loggerName-logger';
    if (getIt.isRegistered<Logger>(instanceName: instanceName)) {
      return getIt.get<Logger>(instanceName: instanceName);
    } else {
      final logger = Logger.detached(loggerName)..level = Level.ALL;
      getIt.registerSingleton<Logger>(
        logger,
        instanceName: instanceName,
        dispose: (instance) => instance.clearListeners(),
      );
      getIt<LogSink>().listenTo(logger.onRecord);
      return logger;
    }
  }

  @override
  Future<void> install(GetIt getIt) {
    hierarchicalLoggingEnabled = true;
    recordStackTraceAtLevel = Level.SEVERE;
    Logger.root.level = Level.ALL;
    return super.install(getIt);
  }

  @override
  String toString() => 'logging feature';
}

extension LoggingGetItExtensions on GetIt {
  Logger logger<T>([String? loggerName]) {
    return get<Logger>(param1: loggerName ?? T.runtimeType.toString());
  }

  GetItBehaviourMonitor<T> monitor<T extends BehaviourTrack>() {
    return GetItBehaviourMonitor(getIt: this);
  }
}
