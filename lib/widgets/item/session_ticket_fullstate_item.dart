import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_widget_button.dart';

class StateSessionTicketItem extends StatefulWidget {
  const StateSessionTicketItem({
    Key? key,
    required this.program,
    this.callback,
    this.statusColor,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final Program program;

  final Color? statusColor;

  final EdgeInsets padding;
  final EdgeInsets margin;

  final VoidCallback? callback;

  @override
  State<StateSessionTicketItem> createState() => _StateSessionTicketItemState();
}

class _StateSessionTicketItemState extends State<StateSessionTicketItem> {
  late Program program;

  @override
  void initState() {
    super.initState();

    program = widget.program;
  }

  @override
  void didUpdateWidget(covariant StateSessionTicketItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    program = widget.program;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: GlassmorphismWidgetButton(
        border: widget.statusColor ?? Colors.white,
        background: widget.statusColor ?? Colors.white,
        padding: widget.padding,
        onTap: () {
          widget.callback?.call();
        },
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: Dimens.small_vertical_padding,
            horizontal: Dimens.horizontal_padding,
          ),
          title: Container(
            margin: const EdgeInsets.only(bottom: Dimens.vertical_margin),
            child: Text(
              program.title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          leading: Icon(
            Icons.loyalty_outlined,
            size: Dimens.large_text,
            color: widget.statusColor ?? Theme.of(context).indicatorColor,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${program.credit} ",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              IconTheme(
                data: Theme.of(context)
                    .iconTheme
                    .copyWith(size: Dimens.medium_text),
                child: const Icon(Icons.token_rounded),
              ),
            ],
          ),
        ),
        blur: Properties.blur_glass_morphism,
        opacity: Properties.opacity_glass_morphism,
      ),
    );
  }
}
