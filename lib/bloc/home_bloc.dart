// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import '../models/event_model.dart';
import '../services/event_api.dart';

// Define events
enum HomeEvent { loadEvents }

// Define states
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Event> events;

  HomeLoaded(this.events);
}

class HomeError extends HomeState {
  final String errorMessage;

  HomeError(this.errorMessage);
}

// Define the HomeBloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EventApiService _eventApiService = EventApiService();

  HomeBloc() : super(HomeLoading());

  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield HomeLoading(); // Start with loading state

    if (event == HomeEvent.loadEvents) {
      try {
        final events = await _eventApiService.fetchEvents();
        yield HomeLoaded(events); // Transition to loaded state with data
      } catch (e) {
        yield HomeError(
            'Error loading events: $e'); // Transition to error state on failure
      }
    }
  }
}
