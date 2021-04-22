


class Services{


  String work_id;
  String work_name;
  String site_address;
  String site_technician;
  String site_technician_contact_number;
  String date_requested;
  String job_id;


  String order_creator;
  String job_description;
  String date_scheduled;


  // Constructor
  Services
      (
        {
          this.work_name,
          this.site_address,
          this.site_technician,
          this.site_technician_contact_number,
          this.date_requested,
          this.order_creator,
          this.job_description,
          this.date_scheduled,
          this.job_id,
          this.work_id,
        }
      );
}