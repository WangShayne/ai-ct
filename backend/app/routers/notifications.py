from typing import Optional, List
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import select
from sqlalchemy.ext.asyncio import AsyncSession
from ..database import get_session
from ..models import Notification, NotificationRead
from ..schemas import APIResponse

router = APIRouter(prefix="/api/notifications", tags=["notifications"])


@router.get("", response_model=APIResponse[List[NotificationRead]])
async def list_notifications(
    user_id: int = Query(...),
    type: Optional[str] = Query(None),
    session: AsyncSession = Depends(get_session),
):
    query = select(Notification).where(Notification.user_id == user_id)
    if type:
        query = query.where(Notification.type == type)
    query = query.order_by(Notification.created_at.desc())
    
    result = await session.execute(query)
    notifications = result.scalars().all()
    return APIResponse.success([NotificationRead.model_validate(n) for n in notifications])


@router.put("/{notification_id}/read", response_model=APIResponse)
async def mark_read(notification_id: int, session: AsyncSession = Depends(get_session)):
    notification = await session.get(Notification, notification_id)
    if not notification:
        raise HTTPException(status_code=404, detail="Notification not found")
    notification.read = True
    session.add(notification)
    await session.commit()
    return APIResponse.success(message="Marked as read")


@router.put("/read-all", response_model=APIResponse)
async def mark_all_read(
    user_id: int = Query(...),
    session: AsyncSession = Depends(get_session),
):
    query = select(Notification).where(
        Notification.user_id == user_id,
        Notification.read == False,
    )
    result = await session.execute(query)
    notifications = result.scalars().all()
    
    for n in notifications:
        n.read = True
        session.add(n)
    
    await session.commit()
    return APIResponse.success(message=f"Marked {len(notifications)} as read")
