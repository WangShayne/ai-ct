from datetime import datetime
from typing import Optional, Any
from sqlmodel import Field, SQLModel, Column
from sqlalchemy import JSON


class RecordBase(SQLModel):
    title: str
    type: str
    status: str = "processing"
    status_label: str = "Processing"
    thumbnail: Optional[str] = None
    scan_date: datetime


class Record(RecordBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    user_id: int = Field(foreign_key="user.id")
    report_data: Optional[dict] = Field(default=None, sa_column=Column(JSON))
    created_at: datetime = Field(default_factory=datetime.utcnow)


class RecordCreate(RecordBase):
    user_id: int


class RecordUpdate(SQLModel):
    title: Optional[str] = None
    status: Optional[str] = None
    status_label: Optional[str] = None
    report_data: Optional[dict] = None


class RecordRead(RecordBase):
    id: int
    user_id: int
    report_data: Optional[dict]
    created_at: datetime
