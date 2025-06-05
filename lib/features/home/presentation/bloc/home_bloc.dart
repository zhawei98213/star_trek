import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/user_stats_entity.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import '../../domain/usecases/get_user_stats_usecase.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/mark_notification_read_usecase.dart';
import '../../domain/usecases/refresh_home_data_usecase.dart';

// ==================== Events ====================

abstract class HomeEvent {
  const HomeEvent();
}

/// 初始化主页数据事件
class InitializeHomeEvent extends HomeEvent {
  final String userId;
  
  const InitializeHomeEvent(this.userId);
}

/// 刷新主页数据事件
class RefreshHomeDataEvent extends HomeEvent {
  final String userId;
  
  const RefreshHomeDataEvent(this.userId);
}

/// 加载用户统计数据事件
class LoadUserStatsEvent extends HomeEvent {
  final String userId;
  
  const LoadUserStatsEvent(this.userId);
}

/// 加载通知列表事件
class LoadNotificationsEvent extends HomeEvent {
  final String userId;
  
  const LoadNotificationsEvent(this.userId);
}

/// 标记通知为已读事件
class MarkNotificationReadEvent extends HomeEvent {
  final String notificationId;
  
  const MarkNotificationReadEvent(this.notificationId);
}

/// 清除所有通知事件
class ClearAllNotificationsEvent extends HomeEvent {
  final String userId;
  
  const ClearAllNotificationsEvent(this.userId);
}

/// 更新快速操作状态事件
class UpdateQuickActionEvent extends HomeEvent {
  final String actionId;
  final Map<String, dynamic> data;
  
  const UpdateQuickActionEvent({
    required this.actionId,
    required this.data,
  });
}

/// 更新学习进度事件
class UpdateLearningProgressEvent extends HomeEvent {
  final String userId;
  final Map<String, dynamic> progressData;
  
  const UpdateLearningProgressEvent({
    required this.userId,
    required this.progressData,
  });
}

/// 完成每日挑战事件
class CompleteDailyChallengeEvent extends HomeEvent {
  final String userId;
  final String challengeId;
  final int score;
  
  const CompleteDailyChallengeEvent({
    required this.userId,
    required this.challengeId,
    required this.score,
  });
}

/// 获取成就列表事件
class LoadAchievementsEvent extends HomeEvent {
  final String userId;
  
  const LoadAchievementsEvent(this.userId);
}

// ==================== States ====================

abstract class HomeState {
  const HomeState();
}

/// 初始状态
class HomeInitial extends HomeState {}

/// 加载中状态
class HomeLoading extends HomeState {
  final String? message;
  
  const HomeLoading({this.message});
}

/// 已加载状态
class HomeLoaded extends HomeState {
  final HomeDataEntity homeData;
  final UserStatsEntity userStats;
  final List<NotificationEntity> notifications;
  final int unreadNotificationCount;
  final bool isRefreshing;
  final DateTime lastUpdated;
  
  const HomeLoaded({
    required this.homeData,
    required this.userStats,
    required this.notifications,
    this.unreadNotificationCount = 0,
    this.isRefreshing = false,
    required this.lastUpdated,
  });
  
  List<Object?> get props => [
    homeData,
    userStats,
    notifications,
    unreadNotificationCount,
    isRefreshing,
    lastUpdated,
  ];
  
  HomeLoaded copyWith({
    HomeDataEntity? homeData,
    UserStatsEntity? userStats,
    List<NotificationEntity>? notifications,
    int? unreadNotificationCount,
    bool? isRefreshing,
    DateTime? lastUpdated,
  }) {
    return HomeLoaded(
      homeData: homeData ?? this.homeData,
      userStats: userStats ?? this.userStats,
      notifications: notifications ?? this.notifications,
      unreadNotificationCount: unreadNotificationCount ?? this.unreadNotificationCount,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

/// 错误状态
class HomeError extends HomeState {
  final String message;
  final String? errorCode;
  
  const HomeError(this.message, {this.errorCode});
}

/// 操作成功状态
class HomeOperationSuccess extends HomeState {
  final String message;
  final Map<String, dynamic>? data;
  
  const HomeOperationSuccess(this.message, {this.data});
}

/// 通知更新状态
class NotificationUpdated extends HomeState {
  final List<NotificationEntity> notifications;
  final int unreadCount;
  
  const NotificationUpdated({
    required this.notifications,
    required this.unreadCount,
  });
}

// ==================== Bloc ====================

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeDataUseCase _getHomeDataUseCase;
  final GetUserStatsUseCase _getUserStatsUseCase;
  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkNotificationReadUseCase _markNotificationReadUseCase;
  final RefreshHomeDataUseCase _refreshHomeDataUseCase;
  
  // 缓存数据
  HomeDataEntity? _cachedHomeData;
  UserStatsEntity? _cachedUserStats;
  List<NotificationEntity> _cachedNotifications = [];
  String? _currentUserId;
  
  HomeBloc({
    required GetHomeDataUseCase getHomeDataUseCase,
    required GetUserStatsUseCase getUserStatsUseCase,
    required GetNotificationsUseCase getNotificationsUseCase,
    required MarkNotificationReadUseCase markNotificationReadUseCase,
    required RefreshHomeDataUseCase refreshHomeDataUseCase,
  }) : _getHomeDataUseCase = getHomeDataUseCase,
       _getUserStatsUseCase = getUserStatsUseCase,
       _getNotificationsUseCase = getNotificationsUseCase,
       _markNotificationReadUseCase = markNotificationReadUseCase,
       _refreshHomeDataUseCase = refreshHomeDataUseCase,
       super(HomeInitial()) {
    
    // 注册事件处理器
    on<InitializeHomeEvent>(_onInitializeHome);
    on<RefreshHomeDataEvent>(_onRefreshHomeData);
    on<LoadUserStatsEvent>(_onLoadUserStats);
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<MarkNotificationReadEvent>(_onMarkNotificationRead);
    on<ClearAllNotificationsEvent>(_onClearAllNotifications);
    on<UpdateQuickActionEvent>(_onUpdateQuickAction);
    on<UpdateLearningProgressEvent>(_onUpdateLearningProgress);
    on<CompleteDailyChallengeEvent>(_onCompleteDailyChallenge);
    on<LoadAchievementsEvent>(_onLoadAchievements);
  }
  
  /// 初始化主页数据
  Future<void> _onInitializeHome(
    InitializeHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(const HomeLoading(message: '正在加载主页数据...'));
      
      _currentUserId = event.userId;
      
      // 并行加载所有数据
      final results = await Future.wait([
        _getHomeDataUseCase(GetHomeDataParams(userId: event.userId)),
        _getUserStatsUseCase(GetUserStatsParams(userId: event.userId)),
        _getNotificationsUseCase(GetNotificationsParams(userId: event.userId)),
      ]);
      
      final homeData = results[0] as HomeDataEntity;
      final userStats = results[1] as UserStatsEntity;
      final notifications = results[2] as List<NotificationEntity>;
      
      // 缓存数据
      _cachedHomeData = homeData;
      _cachedUserStats = userStats;
      _cachedNotifications = notifications;
      
      final unreadCount = notifications.where((n) => !n.isRead).length;
      
      emit(HomeLoaded(
        homeData: homeData,
        userStats: userStats,
        notifications: notifications,
        unreadNotificationCount: unreadCount,
        lastUpdated: DateTime.now(),
      ));
      
    } catch (e) {
      emit(HomeError('加载主页数据失败: ${e.toString()}'));
    }
  }
  
  /// 刷新主页数据
  Future<void> _onRefreshHomeData(
    RefreshHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // 如果当前有已加载的状态，保持显示并标记为刷新中
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(currentState.copyWith(isRefreshing: true));
      }
      
      final refreshedData = await _refreshHomeDataUseCase(
        RefreshHomeDataParams(userId: event.userId),
      );
      
      // 更新缓存
      _cachedHomeData = refreshedData.homeData;
      _cachedUserStats = refreshedData.userStats;
      _cachedNotifications = refreshedData.notifications;
      
      final unreadCount = refreshedData.notifications.where((n) => !n.isRead).length;
      
      emit(HomeLoaded(
        homeData: refreshedData.homeData,
        userStats: refreshedData.userStats,
        notifications: refreshedData.notifications,
        unreadNotificationCount: unreadCount,
        isRefreshing: false,
        lastUpdated: DateTime.now(),
      ));
      
    } catch (e) {
      emit(HomeError('刷新数据失败: ${e.toString()}'));
    }
  }
  
  /// 加载用户统计数据
  Future<void> _onLoadUserStats(
    LoadUserStatsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final userStats = await _getUserStatsUseCase(
        GetUserStatsParams(userId: event.userId),
      );
      
      _cachedUserStats = userStats;
      
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(currentState.copyWith(userStats: userStats));
      }
      
    } catch (e) {
      emit(HomeError('加载用户统计失败: ${e.toString()}'));
    }
  }
  
  /// 加载通知列表
  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final notifications = await _getNotificationsUseCase(
        GetNotificationsParams(userId: event.userId),
      );
      
      _cachedNotifications = notifications;
      final unreadCount = notifications.where((n) => !n.isRead).length;
      
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(currentState.copyWith(
          notifications: notifications,
          unreadNotificationCount: unreadCount,
        ));
      } else {
        emit(NotificationUpdated(
          notifications: notifications,
          unreadCount: unreadCount,
        ));
      }
      
    } catch (e) {
      emit(HomeError('加载通知失败: ${e.toString()}'));
    }
  }
  
  /// 标记通知为已读
  Future<void> _onMarkNotificationRead(
    MarkNotificationReadEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _markNotificationReadUseCase(
        MarkNotificationReadParams(notificationId: event.notificationId),
      );
      
      // 更新本地缓存
      _cachedNotifications = _cachedNotifications.map((notification) {
        if (notification.id == event.notificationId) {
          return notification.copyWith(isRead: true);
        }
        return notification;
      }).toList();
      
      final unreadCount = _cachedNotifications.where((n) => !n.isRead).length;
      
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(currentState.copyWith(
          notifications: _cachedNotifications,
          unreadNotificationCount: unreadCount,
        ));
      }
      
      emit(const HomeOperationSuccess('通知已标记为已读'));
      
    } catch (e) {
      emit(HomeError('标记通知失败: ${e.toString()}'));
    }
  }
  
  /// 清除所有通知
  Future<void> _onClearAllNotifications(
    ClearAllNotificationsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // 标记所有通知为已读
      for (final notification in _cachedNotifications) {
        if (!notification.isRead) {
          await _markNotificationReadUseCase(
            MarkNotificationReadParams(notificationId: notification.id),
          );
        }
      }
      
      // 更新本地缓存
      _cachedNotifications = _cachedNotifications.map((notification) {
        return notification.copyWith(isRead: true);
      }).toList();
      
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(currentState.copyWith(
          notifications: _cachedNotifications,
          unreadNotificationCount: 0,
        ));
      }
      
      emit(const HomeOperationSuccess('所有通知已清除'));
      
    } catch (e) {
      emit(HomeError('清除通知失败: ${e.toString()}'));
    }
  }
  
  /// 更新快速操作状态
  Future<void> _onUpdateQuickAction(
    UpdateQuickActionEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (state is HomeLoaded && _cachedHomeData != null) {
        // 更新快速操作数据
        final updatedHomeData = _cachedHomeData!.copyWith(
          quickActions: _cachedHomeData!.quickActions.map((action) {
            if (action.id == event.actionId) {
              return action.copyWith(data: event.data);
            }
            return action;
          }).toList(),
        );
        
        _cachedHomeData = updatedHomeData;
        
        final currentState = state as HomeLoaded;
        emit(currentState.copyWith(homeData: updatedHomeData));
      }
      
    } catch (e) {
      emit(HomeError('更新快速操作失败: ${e.toString()}'));
    }
  }
  
  /// 更新学习进度
  Future<void> _onUpdateLearningProgress(
    UpdateLearningProgressEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (state is HomeLoaded && _cachedHomeData != null) {
        // 更新学习进度数据
        final updatedHomeData = _cachedHomeData!.copyWith(
          learningProgress: _cachedHomeData!.learningProgress.copyWith(
            data: event.progressData,
          ),
        );
        
        _cachedHomeData = updatedHomeData;
        
        final currentState = state as HomeLoaded;
        emit(currentState.copyWith(homeData: updatedHomeData));
      }
      
    } catch (e) {
      emit(HomeError('更新学习进度失败: ${e.toString()}'));
    }
  }
  
  /// 完成每日挑战
  Future<void> _onCompleteDailyChallenge(
    CompleteDailyChallengeEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (state is HomeLoaded && _cachedHomeData != null) {
        // 更新每日挑战状态
        final updatedChallenges = _cachedHomeData!.dailyChallenges.map((challenge) {
          if (challenge.id == event.challengeId) {
            return challenge.copyWith(
              isCompleted: true,
              score: event.score,
              completedAt: DateTime.now(),
            );
          }
          return challenge;
        }).toList();
        
        final updatedHomeData = _cachedHomeData!.copyWith(
          dailyChallenges: updatedChallenges,
        );
        
        _cachedHomeData = updatedHomeData;
        
        final currentState = state as HomeLoaded;
        emit(currentState.copyWith(homeData: updatedHomeData));
        
        emit(HomeOperationSuccess(
          '挑战完成！获得 ${event.score} 分',
          data: {'challengeId': event.challengeId, 'score': event.score},
        ));
      }
      
    } catch (e) {
      emit(HomeError('完成挑战失败: ${e.toString()}'));
    }
  }
  
  /// 加载成就列表
  Future<void> _onLoadAchievements(
    LoadAchievementsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // 这里可以添加获取成就的逻辑
      // 暂时使用模拟数据
      emit(const HomeOperationSuccess('成就数据已更新'));
      
    } catch (e) {
      emit(HomeError('加载成就失败: ${e.toString()}'));
    }
  }
  
  /// 获取缓存的主页数据
  HomeDataEntity? get cachedHomeData => _cachedHomeData;
  
  /// 获取缓存的用户统计
  UserStatsEntity? get cachedUserStats => _cachedUserStats;
  
  /// 获取缓存的通知列表
  List<NotificationEntity> get cachedNotifications => _cachedNotifications;
  
  /// 获取当前用户ID
  String? get currentUserId => _currentUserId;
  
  /// 获取未读通知数量
  int get unreadNotificationCount => _cachedNotifications.where((n) => !n.isRead).length;
}