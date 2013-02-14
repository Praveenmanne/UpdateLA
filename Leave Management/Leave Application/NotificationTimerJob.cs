using System;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;

namespace Leave_Application
{
    public class NotificationTimerJob : SPJobDefinition
    {
        public NotificationTimerJob()
        {
        }

        public NotificationTimerJob(string jobName, SPService service, SPServer server, SPJobLockType lockType)
            : base(jobName, service, server, lockType)
        {
            Title = jobName;
        }

        public NotificationTimerJob(string jobName, SPWebApplication webapp)
            : base(jobName, webapp, null, SPJobLockType.ContentDatabase)
        {
            Title = jobName;
        }

        public override void Execute(Guid targetInstanceId)
        {
            try
            {

            
            var webapp = Parent as SPWebApplication;
            if (webapp != null)
            {
                foreach (SPSite spSite in webapp.Sites)
                {
                    using (var web = spSite.OpenWeb())
                    {
                        web.Lists.TryGetList(Utilities.EmployeeLeaves);

                        SPListItemCollection employeetype = GetListItemCollection(web.Lists[Utilities.EmployeeLeaves],
                                                                                  "Employee Type", "Probationary",
                                                                                  "Leave Type", "Paid Leave");

                        foreach (SPListItem currentUseremptypeDetail in employeetype)
                        {
                            currentUseremptypeDetail[Utilities.LeaveBalancecolname] =
                                Convert.ToInt16(currentUseremptypeDetail[Utilities.LeaveBalancecolname]) + 1;
                            currentUseremptypeDetail.Update();
                        }
                    }
                }
            }

            }
            catch (Exception ex)
            {

                Log(""+ ex.Message);
            }
        }

        internal SPListItemCollection GetListItemCollection(SPList spList, string key, string value)
        {
            // Return list item collection based on the lookup field

            SPField spField = spList.Fields[key];
            var query = new SPQuery
                            {
                                Query =
                                    @"<Where>
                        <Eq>
                            <FieldRef Name='" + spField.InternalName +
                                    @"'/><Value Type='" + spField.Type.ToString() + @"'>" + value + @"</Value>
                        </Eq>
                        </Where>"
                            };

            return spList.GetItems(query);
        }

        internal SPListItemCollection GetListItemCollection(SPList spList, string keyOne, string valueOne, string keyTwo,
                                                            string valueTwo)
        {
            // Return list item collection based on the lookup field

            SPField spFieldOne = spList.Fields[keyOne];
            SPField spFieldTwo = spList.Fields[keyTwo];
            var query = new SPQuery
                            {
                                Query =
                                    @"<Where>
                          <And>
                                <Eq>
                                    <FieldRef Name=" + spFieldOne.InternalName +
                                    @" />
                                    <Value Type=" + spFieldOne.Type.ToString() +
                                    ">" + valueOne + @"</Value>
                                </Eq>
                                <Eq>
                                    <FieldRef Name=" +
                                    spFieldTwo.InternalName + @" />
                                    <Value Type=" +
                                    spFieldTwo.Type.ToString() + ">" + valueTwo + @"</Value>
                                </Eq>
                          </And>
                        </Where>"
                            };

            return spList.GetItems(query);
        }
        public void Log(string s)
        {
        }
    }
}