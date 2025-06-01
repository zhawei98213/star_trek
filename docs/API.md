# 🌐 API 文档

Star Trek 应用的 API 接口文档，定义了客户端与服务端之间的通信协议。

## 📋 目录

- [API 概述](#api-概述)
- [认证机制](#认证机制)
- [用户管理](#用户管理)
- [学习系统](#学习系统)
- [游戏化功能](#游戏化功能)
- [错误处理](#错误处理)
- [数据模型](#数据模型)

## 🔍 API 概述

### 基础信息

- **Base URL**: `https://api.startrek.app/v1`
- **协议**: HTTPS
- **数据格式**: JSON
- **字符编码**: UTF-8

### 请求头

```http
Content-Type: application/json
Authorization: Bearer {access_token}
X-API-Version: 1.0
X-Client-Platform: ios|android|web
X-Client-Version: 1.0.0
```

### 响应格式

#### 成功响应

```json
{
  "success": true,
  "data": {
    // 具体数据
  },
  "message": "操作成功",
  "timestamp": "2024-01-01T00:00:00Z"
}
```

#### 错误响应

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "错误描述",
    "details": {
      // 详细错误信息
    }
  },
  "timestamp": "2024-01-01T00:00:00Z"
}
```

## 🔐 认证机制

### 用户注册

```http
POST /auth/register
```

**请求体：**

```json
{
  "username": "string",
  "email": "string",
  "password": "string",
  "age": "number",
  "parent_email": "string" // 可选，儿童账户需要
}
```

**响应：**

```json
{
  "success": true,
  "data": {
    "user_id": "string",
    "access_token": "string",
    "refresh_token": "string",
    "expires_in": 3600
  }
}
```

### 用户登录

```http
POST /auth/login
```

**请求体：**

```json
{
  "email": "string",
  "password": "string"
}
```

### 刷新令牌

```http
POST /auth/refresh
```

**请求体：**

```json
{
  "refresh_token": "string"
}
```

### 退出登录

```http
POST /auth/logout
```

## 👤 用户管理

### 获取用户信息

```http
GET /users/profile
```

**响应：**

```json
{
  "success": true,
  "data": {
    "user_id": "string",
    "username": "string",
    "email": "string",
    "avatar_url": "string",
    "age": "number",
    "level": "number",
    "experience_points": "number",
    "created_at": "string",
    "last_login": "string",
    "preferences": {
      "language": "string",
      "difficulty_level": "string",
      "notifications_enabled": "boolean"
    }
  }
}
```

### 更新用户信息

```http
PUT /users/profile
```

**请求体：**

```json
{
  "username": "string",
  "avatar_url": "string",
  "preferences": {
    "language": "string",
    "difficulty_level": "string",
    "notifications_enabled": "boolean"
  }
}
```

### 上传头像

```http
POST /users/avatar
```

**请求体：** `multipart/form-data`

```
avatar: File
```

## 📚 学习系统

### 获取学习进度

```http
GET /learning/progress
```

**响应：**

```json
{
  "success": true,
  "data": {
    "overall_progress": 75,
    "current_level": 3,
    "experience_points": 1250,
    "subjects": [
      {
        "subject_id": "math",
        "name": "数学",
        "progress": 80,
        "completed_lessons": 12,
        "total_lessons": 15,
        "last_accessed": "2024-01-01T00:00:00Z"
      }
    ],
    "achievements": [
      {
        "achievement_id": "first_lesson",
        "name": "初次尝试",
        "description": "完成第一节课程",
        "icon_url": "string",
        "earned_at": "2024-01-01T00:00:00Z"
      }
    ]
  }
}
```

### 获取课程列表

```http
GET /learning/courses
```

**查询参数：**

- `subject`: 学科筛选
- `difficulty`: 难度级别
- `page`: 页码
- `limit`: 每页数量

**响应：**

```json
{
  "success": true,
  "data": {
    "courses": [
      {
        "course_id": "string",
        "title": "string",
        "description": "string",
        "subject": "string",
        "difficulty": "beginner|intermediate|advanced",
        "duration_minutes": "number",
        "thumbnail_url": "string",
        "is_completed": "boolean",
        "progress": "number",
        "lessons_count": "number"
      }
    ],
    "pagination": {
      "current_page": 1,
      "total_pages": 10,
      "total_items": 100,
      "items_per_page": 10
    }
  }
}
```

### 获取课程详情

```http
GET /learning/courses/{course_id}
```

**响应：**

```json
{
  "success": true,
  "data": {
    "course_id": "string",
    "title": "string",
    "description": "string",
    "subject": "string",
    "difficulty": "string",
    "duration_minutes": "number",
    "thumbnail_url": "string",
    "instructor": {
      "name": "string",
      "avatar_url": "string",
      "bio": "string"
    },
    "lessons": [
      {
        "lesson_id": "string",
        "title": "string",
        "description": "string",
        "duration_minutes": "number",
        "video_url": "string",
        "materials": [
          {
            "type": "pdf|image|interactive",
            "title": "string",
            "url": "string"
          }
        ],
        "is_completed": "boolean",
        "order": "number"
      }
    ],
    "prerequisites": ["course_id1", "course_id2"],
    "learning_objectives": ["string"],
    "tags": ["string"]
  }
}
```

### 开始学习课程

```http
POST /learning/courses/{course_id}/start
```

### 完成课程

```http
POST /learning/courses/{course_id}/complete
```

**请求体：**

```json
{
  "completion_time_minutes": "number",
  "score": "number",
  "feedback": "string"
}
```

### 更新学习进度

```http
PUT /learning/progress
```

**请求体：**

```json
{
  "lesson_id": "string",
  "progress_percentage": "number",
  "time_spent_minutes": "number",
  "completed": "boolean"
}
```

## 🎮 游戏化功能

### 获取每日挑战

```http
GET /challenges/daily
```

**响应：**

```json
{
  "success": true,
  "data": {
    "challenge_id": "string",
    "title": "string",
    "description": "string",
    "type": "quiz|puzzle|creative",
    "difficulty": "easy|medium|hard",
    "reward_points": "number",
    "time_limit_minutes": "number",
    "expires_at": "string",
    "is_completed": "boolean",
    "content": {
      // 挑战具体内容，根据类型不同而不同
    }
  }
}
```

### 提交挑战答案

```http
POST /challenges/{challenge_id}/submit
```

**请求体：**

```json
{
  "answers": {
    // 答案内容，根据挑战类型不同而不同
  },
  "completion_time_seconds": "number"
}
```

**响应：**

```json
{
  "success": true,
  "data": {
    "score": "number",
    "max_score": "number",
    "is_correct": "boolean",
    "reward_points": "number",
    "feedback": "string",
    "correct_answers": {
      // 正确答案
    },
    "achievements_unlocked": [
      {
        "achievement_id": "string",
        "name": "string",
        "description": "string"
      }
    ]
  }
}
```

### 获取成就列表

```http
GET /achievements
```

**查询参数：**

- `category`: 成就分类
- `earned`: 是否已获得 (true/false)

**响应：**

```json
{
  "success": true,
  "data": {
    "achievements": [
      {
        "achievement_id": "string",
        "name": "string",
        "description": "string",
        "category": "learning|challenge|social|milestone",
        "icon_url": "string",
        "rarity": "common|rare|epic|legendary",
        "points": "number",
        "is_earned": "boolean",
        "earned_at": "string",
        "progress": {
          "current": "number",
          "required": "number"
        }
      }
    ],
    "statistics": {
      "total_achievements": "number",
      "earned_achievements": "number",
      "completion_percentage": "number"
    }
  }
}
```

### 获取排行榜

```http
GET /leaderboard
```

**查询参数：**

- `type`: 排行榜类型 (points|level|streak)
- `period`: 时间范围 (daily|weekly|monthly|all_time)
- `limit`: 返回数量

**响应：**

```json
{
  "success": true,
  "data": {
    "rankings": [
      {
        "rank": "number",
        "user_id": "string",
        "username": "string",
        "avatar_url": "string",
        "score": "number",
        "level": "number"
      }
    ],
    "user_rank": {
      "rank": "number",
      "score": "number",
      "percentile": "number"
    }
  }
}
```

## ❌ 错误处理

### 错误代码

| 错误代码 | HTTP状态码 | 描述 |
|---------|-----------|------|
| `INVALID_REQUEST` | 400 | 请求参数无效 |
| `UNAUTHORIZED` | 401 | 未授权访问 |
| `FORBIDDEN` | 403 | 禁止访问 |
| `NOT_FOUND` | 404 | 资源不存在 |
| `VALIDATION_ERROR` | 422 | 数据验证失败 |
| `RATE_LIMIT_EXCEEDED` | 429 | 请求频率超限 |
| `INTERNAL_ERROR` | 500 | 服务器内部错误 |
| `SERVICE_UNAVAILABLE` | 503 | 服务不可用 |

### 错误响应示例

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "请求数据验证失败",
    "details": {
      "field_errors": {
        "email": ["邮箱格式不正确"],
        "password": ["密码长度至少8位"]
      }
    }
  },
  "timestamp": "2024-01-01T00:00:00Z"
}
```

## 📊 数据模型

### 用户模型

```typescript
interface User {
  user_id: string;
  username: string;
  email: string;
  avatar_url?: string;
  age: number;
  level: number;
  experience_points: number;
  created_at: string;
  last_login: string;
  preferences: UserPreferences;
}

interface UserPreferences {
  language: string;
  difficulty_level: 'beginner' | 'intermediate' | 'advanced';
  notifications_enabled: boolean;
  theme: 'light' | 'dark' | 'auto';
}
```

### 课程模型

```typescript
interface Course {
  course_id: string;
  title: string;
  description: string;
  subject: string;
  difficulty: 'beginner' | 'intermediate' | 'advanced';
  duration_minutes: number;
  thumbnail_url: string;
  instructor: Instructor;
  lessons: Lesson[];
  prerequisites: string[];
  learning_objectives: string[];
  tags: string[];
}

interface Lesson {
  lesson_id: string;
  title: string;
  description: string;
  duration_minutes: number;
  video_url?: string;
  materials: LearningMaterial[];
  order: number;
}

interface LearningMaterial {
  type: 'pdf' | 'image' | 'interactive' | 'video';
  title: string;
  url: string;
  description?: string;
}
```

### 挑战模型

```typescript
interface Challenge {
  challenge_id: string;
  title: string;
  description: string;
  type: 'quiz' | 'puzzle' | 'creative' | 'memory';
  difficulty: 'easy' | 'medium' | 'hard';
  reward_points: number;
  time_limit_minutes?: number;
  expires_at: string;
  content: ChallengeContent;
}

interface ChallengeContent {
  // 根据挑战类型不同，内容结构也不同
  questions?: QuizQuestion[];
  puzzle_data?: PuzzleData;
  creative_prompt?: string;
}

interface QuizQuestion {
  question_id: string;
  question_text: string;
  question_type: 'multiple_choice' | 'true_false' | 'fill_blank';
  options?: string[];
  correct_answer: string | string[];
  explanation?: string;
}
```

### 成就模型

```typescript
interface Achievement {
  achievement_id: string;
  name: string;
  description: string;
  category: 'learning' | 'challenge' | 'social' | 'milestone';
  icon_url: string;
  rarity: 'common' | 'rare' | 'epic' | 'legendary';
  points: number;
  requirements: AchievementRequirement[];
}

interface AchievementRequirement {
  type: string;
  target_value: number;
  current_value?: number;
}
```

## 🔄 版本控制

### API 版本策略

- **URL 版本控制**: `/v1/`, `/v2/`
- **向后兼容**: 新版本保持向后兼容性
- **废弃通知**: 提前3个月通知API废弃
- **版本生命周期**: 每个版本至少支持12个月

### 版本更新日志

#### v1.0.0 (2024-01-01)
- 初始API版本
- 用户认证和管理
- 基础学习功能
- 游戏化系统

---

📝 **注意**: 本API文档会随着功能开发持续更新，请关注版本变更通知。