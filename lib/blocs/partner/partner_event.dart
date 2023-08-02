part of partnerbloc;

abstract class PartnerEvent {} 

class PartnerLoadEvent extends PartnerEvent {
  final partnerId;
  PartnerLoadEvent({required this.partnerId});
}