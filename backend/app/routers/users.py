from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from ..database import get_session
from ..models import User, UserUpdate, UserRead
from ..schemas import APIResponse

router = APIRouter(prefix="/api/users", tags=["users"])


@router.get("/{user_id}", response_model=APIResponse[UserRead])
async def get_user(user_id: int, session: AsyncSession = Depends(get_session)):
    user = await session.get(User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return APIResponse.success(UserRead.model_validate(user))


@router.put("/{user_id}", response_model=APIResponse[UserRead])
async def update_user(
    user_id: int,
    user_update: UserUpdate,
    session: AsyncSession = Depends(get_session),
):
    user = await session.get(User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    for key, value in user_update.model_dump(exclude_unset=True).items():
        setattr(user, key, value)
    
    session.add(user)
    await session.commit()
    await session.refresh(user)
    return APIResponse.success(UserRead.model_validate(user))
