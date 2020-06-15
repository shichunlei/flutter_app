import 'dart:math';

import 'package:flutter/material.dart';

import 'data.dart';
import 'item_ticket.dart';

/// https://github.com/gskinnerTeam/flutter_vignettes/tree/master/vignettes/ticket_fold

class TicketFoldPage extends StatefulWidget {
  TicketFoldPage({Key key}) : super(key: key);

  @override
  createState() => _TicketFoldPageState();
}

class _TicketFoldPageState extends State<TicketFoldPage> {
  final ScrollController _scrollController = ScrollController();

  final List<int> _openTickets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf0f0f0),
      appBar: AppBar(title: Text('Boarding Pass'.toUpperCase())),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, index) => Ticket(
                  boardingPass: boardingPasses[index],
                  onClick: () => _handleClickedTicket(index),
                ),
                itemCount: boardingPasses.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _handleClickedTicket(int clickedTicket) {
    // Scroll to ticket position
    // Add or remove the item of the list of open tickets
    _openTickets.contains(clickedTicket)
        ? _openTickets.remove(clickedTicket)
        : _openTickets.add(clickedTicket);

    // Calculate heights of the open and closed elements before the clicked item
    double openTicketsOffset =
        Ticket.nominalOpenHeight * _getOpenTicketsBefore(clickedTicket);
    double closedTicketsOffset = Ticket.nominalClosedHeight *
        (clickedTicket - _getOpenTicketsBefore(clickedTicket));

    double offset = openTicketsOffset +
        closedTicketsOffset -
        (Ticket.nominalClosedHeight * .5);

    // Scroll to the clicked element
    _scrollController.animateTo(max(0, offset),
        duration: Duration(seconds: 1),
        curve: Interval(.25, 1, curve: Curves.easeOutQuad));
    // Return true to stop the notification propagation
    return true;
  }

  _getOpenTicketsBefore(int ticketIndex) {
    // Search all indexes that are smaller to the current index in the list of indexes of open tickets
    return _openTickets.where((int index) => index < ticketIndex).length;
  }
}
