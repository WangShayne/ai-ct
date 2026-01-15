from datetime import date, datetime
from typing import Optional
from sqlmodel import Field, SQLModel


class UserBase(SQLModel):
    name: str
    phone: Optional[str] = None
    gender: Optional[str] = None
    birthday: Optional[date] = None
    avatar: Optional[str] = None
    height: Optional[int] = None
    weight: Optional[int] = None
    blood_type: Optional[str] = None


class User(UserBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    join_days: int = 0
    created_at: datetime = Field(default_factory=datetime.utcnow)
    updated_at: datetime = Field(default_factory=datetime.utcnow)


class UserCreate(UserBase):
    pass


class UserUpdate(SQLModel):
    name: Optional[str] = None
    phone: Optional[str] = None
    gender: Optional[str] = None
    birthday: Optional[date] = None
    avatar: Optional[str] = None
    height: Optional[int] = None
    weight: Optional[int] = None
    blood_type: Optional[str] = None


class UserRead(UserBase):
    id: int
    join_days: int
    created_at: datetime
