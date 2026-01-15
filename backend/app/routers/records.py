from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import select, func
from sqlalchemy.ext.asyncio import AsyncSession
from ..database import get_session
from ..models import Record, RecordCreate, RecordRead
from ..schemas import APIResponse, PaginatedData

router = APIRouter(prefix="/api/records", tags=["records"])


@router.get("", response_model=APIResponse[PaginatedData[RecordRead]])
async def list_records(
    user_id: Optional[int] = Query(None),
    status: Optional[str] = Query(None),
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100),
    session: AsyncSession = Depends(get_session),
):
    query = select(Record)
    count_query = select(func.count()).select_from(Record)
    
    if user_id:
        query = query.where(Record.user_id == user_id)
        count_query = count_query.where(Record.user_id == user_id)
    if status:
        query = query.where(Record.status == status)
        count_query = count_query.where(Record.status == status)
    
    total = (await session.execute(count_query)).scalar() or 0
    query = query.offset((page - 1) * page_size).limit(page_size)
    query = query.order_by(Record.created_at.desc())
    
    result = await session.execute(query)
    records = result.scalars().all()
    
    return APIResponse.success(
        PaginatedData(
            items=[RecordRead.model_validate(r) for r in records],
            total=total,
            page=page,
            page_size=page_size,
        )
    )


@router.get("/{record_id}", response_model=APIResponse[RecordRead])
async def get_record(record_id: int, session: AsyncSession = Depends(get_session)):
    record = await session.get(Record, record_id)
    if not record:
        raise HTTPException(status_code=404, detail="Record not found")
    return APIResponse.success(RecordRead.model_validate(record))


@router.post("", response_model=APIResponse[RecordRead])
async def create_record(
    record: RecordCreate,
    session: AsyncSession = Depends(get_session),
):
    db_record = Record.model_validate(record)
    session.add(db_record)
    await session.commit()
    await session.refresh(db_record)
    return APIResponse.success(RecordRead.model_validate(db_record))


@router.delete("/{record_id}", response_model=APIResponse)
async def delete_record(record_id: int, session: AsyncSession = Depends(get_session)):
    record = await session.get(Record, record_id)
    if not record:
        raise HTTPException(status_code=404, detail="Record not found")
    await session.delete(record)
    await session.commit()
    return APIResponse.success(message="Record deleted")
