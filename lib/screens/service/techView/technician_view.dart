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
                  ? _buildRequestsList(requests)
                  : TechEmptyState(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestsList(List<ServiceRequestModel> requests) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final request = requests[index];
        return TechRequestCard(
          request: request,
          requestState: _getRequestState(request),
          onDecision: widget.onDecision,
          onStateChange: (state) =>
              setState(() => _setRequestState(request, state)),
        );
      },
    );
  }
}
