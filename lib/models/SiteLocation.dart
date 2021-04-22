
/*
*   NAME    :   SiteLocation
*   PURPOSE :   Use to store the data about the SiteLocation.
*
* */


class SiteLocation {

  String site_address;
  String site_name;
  String site_city;
  String site_provinceState;
  String site_country;


  SiteLocation(
      {
        this.site_address,
        this.site_name,
        this.site_city,
        this.site_provinceState,
        this.site_country,
      });
}