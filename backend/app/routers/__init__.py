from .users import router as users_router
from .records import router as records_router
from .notifications import router as notifications_router
from .feedback import router as feedback_router
from .upload import router as upload_router

__all__ = [
    "users_router",
    "records_router",
    "notifications_router",
    "feedback_router",
    "upload_router",
]
