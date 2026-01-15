from datetime import datetime
from typing import Optional, List
from sqlmodel import Field, SQLModel, Column
from sqlalchemy import JSON


class FeedbackBase(SQLModel):
    content: str
    contact: Optional[str] = None


class Feedback(FeedbackBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    user_id: Optional[int] = Field(default=None, foreign_key="user.id")
    images: Optional[List[str]] = Field(default=None, sa_column=Column(JSON))
    created_at: datetime = Field(default_factory=datetime.utcnow)


class FeedbackCreate(FeedbackBase):
    user_id: Optional[int] = None
    images: Optional[List[str]] = None


class FeedbackRead(FeedbackBase):
    id: int
    user_id: Optional[int]
    images: Optional[List[str]]
    created_at: datetime
