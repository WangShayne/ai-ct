export interface Notification {
  id: number;
  title: string;
  description: string;
  time: string;
  type: 'report' | 'system' | 'health';
  read: boolean;
}

export interface Record {
  id: string;
  title: string;
  date: string;
  time: string;
  type: string;
  thumbnail: string;
  status: 'completed' | 'processing' | 'attention' | 'normal';
  statusLabel: string;
}

export interface UserProfile {
  name: string;
  id: string;
  joinDays: number;
  avatar: string;
}