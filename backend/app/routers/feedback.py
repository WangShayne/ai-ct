from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from ..database import get_session
from ..models import Feedback, FeedbackCreate, FeedbackRead
from ..schemas import APIResponse

router = APIRouter(prefix="/api/feedback", tags=["feedback"])


@router.post("", response_model=APIResponse[FeedbackRead])
async def create_feedback(
    feedback: FeedbackCreate,
    session: AsyncSession = Depends(get_session),
):
    db_feedback = Feedback.model_validate(feedback)
    session.add(db_feedback)
    await session.commit()
    await session.refresh(db_feedback)
    return APIResponse.success(FeedbackRead.model_validate(db_feedback))
