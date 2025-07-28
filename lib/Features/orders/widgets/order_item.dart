import 'package:e_commerce/Features/orders/models/order_model.dart';
import 'package:e_commerce/Features/orders/widgets/product_in_order.dart';
import 'package:e_commerce/core/constant/colors.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({super.key, required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 4,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        // Handle expansion
      },
      children: [
        ExpansionPanel(
          backgroundColor: Colors.grey[100],
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              onTap: () {
                setState(() {
                  isExpand = !isExpanded;
                });
              },
              title: Text('Order #${widget.order.orderId}'),
              trailing: Container(
                height: 25,
                width: 65,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    'Complete',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              subtitle: Text('Total Price: \$${widget.order.totalPrice}'),
              leading: CircleAvatar(
                backgroundColor: KColors.primaryColor,
                radius: 18,
                child: Icon(Icons.shopping_cart, color: Colors.white),
              ),
            );
          },
          body: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [ProductInOrder(), ProductInOrder(), ProductInOrder()],
          ),
          isExpanded: isExpand,
        ),
      ],
    );
  }
}
