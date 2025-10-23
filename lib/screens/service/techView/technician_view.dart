import 'package:flutter/material.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';
import 'package:homefind/screens/service/techView/widget/techEmptyState.dart';
import 'package:homefind/screens/service/techView/widget/techHeader.dart';
import 'package:homefind/screens/service/techView/techRequestCard/techRequestCard.dart';
import 'package:homefind/screens/service/techView/widget/techStateCard.dart';

typedef OnTechDecision =
    void Function(
      String requestId,
      String decision, {
      double? counterPrice,
      String? description,
    });

class TechnicianView extends StatefulWidget {
  final List<ServiceRequestModel> requests;
  final OnTechDecision? onDecision;

  const TechnicianView({Key? key, required this.requests, this.onDecision})
    : super(key: key);

  @override
  State<TechnicianView> createState() => _TechnicianViewState();
}

class _TechnicianViewState extends State<TechnicianView> {
  final Map<String, String> _requestStates = {};
  // expansion state is handled by ExpansionPanelList.radio (one-open-at-a-time)

  String _requestSignature(ServiceRequestModel request) {
    // use the guaranteed id on the model as the state key
    return request.id;
  }

  String? _getRequestState(ServiceRequestModel request) {
    final sig = _requestSignature(request);
    return _requestStates[sig];
  }

  void _setRequestState(ServiceRequestModel request, String state) {
    final sig = _requestSignature(request);
    _requestStates[sig] = state;
  }

  @override
  Widget build(BuildContext context) {
    final displayedRequests = widget.requests;

    final requests = displayedRequests
        .where((request) => _getRequestState(request) != 'declined')
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TechHeader(),
              const SizedBox(height: 20),
              TechStatsCards(
                requests: displayedRequests,
                getRequestState: _getRequestState,
              ),
              const SizedBox(height: 20),
              requests.isNotEmpty
                  ? _buildExpandableList(requests)
                  : TechEmptyState(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableList(List<ServiceRequestModel> requests) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionPanelList.radio(
        expandedHeaderPadding: EdgeInsets.zero,
        elevation: 0,
        animationDuration: const Duration(milliseconds: 200),
        children: requests.map((request) {
          return ExpansionPanelRadio(
            value: request.id,
            canTapOnHeader: true,
            headerBuilder: (context, isExpanded) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            request.serviceType,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            request.requesterName,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TechRequestCard(
                request: request,
                requestState: _getRequestState(request),
                onDecision: widget.onDecision,
                onStateChange: (state) =>
                    setState(() => _setRequestState(request, state)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
