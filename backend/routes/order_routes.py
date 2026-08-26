from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models.order import Order
from models.user import User
from moravi_auth import get_current_admin
from dependencies import get_current_user
from typing import List

router = APIRouter(prefix="/api/orders", tags=["orders"])

# -----------------------------
#   CREATE ORDER
# -----------------------------
@router.post("/create")
def create_order(order_data: dict, db: Session = Depends(get_db)):
    new_order = Order(
        user_name=order_data["name"],
        whatsapp=order_data["whatsapp"],
        secondary_phone=order_data.get("secondary_phone"),
        email=order_data.get("email"),
        address=order_data.get("address"),
        city=order_data["city"],
        zip=order_data.get("zip"),
        items=order_data["items"],
        total=order_data["total"],
        status="pending"
    )
    db.add(new_order)
    db.commit()
    db.refresh(new_order)
    return {"message": "Commande enregistrée", "order_id": new_order.id}


# -----------------------------
#   GET ALL ORDERS (ADMIN)
# -----------------------------
@router.get("/all")
def get_all_orders(
    db: Session = Depends(get_db),
    admin = Depends(get_current_admin)
):
    

    orders = db.query(Order).all()

    return [
        {
            "id": o.id,
            "user_name": o.user_name,
            "whatsapp": o.whatsapp,
            "secondary_phone": o.secondary_phone,
            "email": o.email,
            "address": o.address,
            "city": o.city,
            "zip": o.zip,
            "items": o.items,
            "total": o.total,
            "status": o.status,
            "created_at": o.created_at.isoformat()
        }
        for o in orders
    ]


# -----------------------------
#   DELETE ORDER
# -----------------------------
@router.delete("/{order_id}")
def delete_order(
    order_id: int,
    db: Session = Depends(get_db),
    admin = Depends(get_current_admin)
):
    

    order = db.query(Order).filter(Order.id == order_id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Commande introuvable")

    db.delete(order)
    db.commit()

    return {"message": "Commande supprimée"}


# -----------------------------
#   UPDATE ORDER STATUS
# -----------------------------
@router.patch("/{order_id}")
def update_order(
    order_id: int,
    data: dict,
    db: Session = Depends(get_db),
    admin = Depends(get_current_admin)
):
    

    order = db.query(Order).filter(Order.id == order_id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Commande introuvable")

    if "status" in data:
        order.status = data["status"]

    db.commit()
    db.refresh(order)

    return {"message": "Commande mise à jour", "order": {"id": order.id, "status": order.status}}
