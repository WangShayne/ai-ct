from datetime import datetime
from typing import Optional
from sqlmodel import Field, SQLModel


class NotificationBase(SQLModel):
    title: str
    description: str
    type: str = "system"


class Notification(NotificationBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    user_id: int = Field(foreign_key="user.id")
    read: bool = False
    created_at: datetime = Field(default_factory=datetime.utcnow)


class NotificationCreate(NotificationBase):
    user_id: int


class NotificationRead(NotificationBase):
    id: int
    user_id: int
    read: bool
    created_at: datetime
