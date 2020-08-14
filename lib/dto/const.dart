class MyConst {
  static const AUTH_TOKEN = "_token_";
  static const ROLE_MEMBER = "member";
  static const ROLE_TEACHER = "teacher";
  static const ROLE_SCHOOL = "school";
  static const ROLE_MOD = "mod";
  static const ROLE_ADMIN = "admin";
  static const ROLE_GUEST = "guest";

  static const TRANS_TYPE_DEPOSIT = "deposit";
  static const TRANS_TYPE_WITHDRAW = "withdraw";
  static const TRANS_TYPE_EXCHANGE = "exchange";
  static const TRANS_TYPE_ORDER = "order";
  static const TRANS_TYPE_COMMISSION = "commission";

  static const ITEM_COURSE = "course";
  static const ITEM_CLASS = "class";
  static const ITEM_PRODUCT = "product";

  static const ITEM_USER_STATUS_INACTIVE = 0;
  static const ITEM_USER_STATUS_ACTIVE = 1;
  static const ITEM_USER_STATUS_DONE = 99;
  static const ITEM_USER_STATUS_CANCEL = 90;

  static const TRANS_STATUS_PENDING = 0;
  static const TRANS_STATUS_APPROVE = 1;
  static const TRANS_STATUS_CANCEL = 99;

  static const WALLET_M = 'wallet_m';
  static const WALLET_C = 'wallet_c';

  static const GUIDE_TOC = 'guide_toc';
  static const GUIDE_MEMBER = 'guide_member';
  static const GUIDE_TEACHER = 'guide_teacher';
  static const GUIDE_SCHOOL = 'guide_school';
  static const GUIDE_ABOUT = 'guide_about';
  static const GUIDE_TOC_SCHOOL = 'guide_toc_school';
  static const GUIDE_TOC_TEACHER = 'guide_toc_teacher';

  static const PAYMENT_ATM = 'atm';
  static const PAYMENT_VOUCHER = 'voucher';

  static const CONTRACT_NEW = 1;
  static const CONTRACT_SIGNED = 10;
  static const CONTRACT_APPROVED = 99;
  static const CONTRACT_DELETED = 0;

  static const ASK_TYPE_READ = 'read';
  static const ASK_TYPE_VIDEO = 'video';
}
