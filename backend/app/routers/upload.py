import uuid
from pathlib import Path
from fastapi import APIRouter, UploadFile, File
from ..schemas import APIResponse

router = APIRouter(prefix="/api/upload", tags=["upload"])

UPLOAD_DIR = Path("uploads")
UPLOAD_DIR.mkdir(exist_ok=True)


@router.post("/image", response_model=APIResponse[dict])
async def upload_image(file: UploadFile = File(...)):
    ext = Path(file.filename).suffix
    filename = f"{uuid.uuid4()}{ext}"
    filepath = UPLOAD_DIR / filename
    
    content = await file.read()
    with open(filepath, "wb") as f:
        f.write(content)
    
    return APIResponse.success({"url": f"/uploads/{filename}"})
