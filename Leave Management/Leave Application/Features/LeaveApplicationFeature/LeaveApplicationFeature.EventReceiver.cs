using System;
using System.Linq;
using System.Runtime.InteropServices;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;

namespace Leave_Application.Features.Feature1
{
    /// <summary>
    /// This class handles events raised during feature activation, deactivation, installation, uninstallation, and upgrade.
    /// </summary>
    /// <remarks>
    /// The GUID attached to this class may be used during packaging and should not be modified.
    /// </remarks>

    [Guid("eedb4196-577a-490e-9497-823d31d89840")]
    public class Feature1EventReceiver : SPFeatureReceiver
    {
        // Uncomment the method below to handle the event raised after a feature has been activated.

        public override void FeatureActivated(SPFeatureReceiverProperties properties)
        {
            try
            {
                var site = (SPSite)properties.Feature.Parent;
                bool timerJobFound = site.WebApplication.JobDefinitions.Any(jobDefinition => jobDefinition.Title == Utilities.TimerJobName);
                if (!timerJobFound)
                {
                    var addingleavedays = new NotificationTimerJob(Utilities.TimerJobName, site.WebApplication);
                    var dailySchedule = new SPMonthlySchedule
                    {
                        BeginDay = 1,
                        BeginHour = 1,
                        EndHour = 1,
                        BeginMinute = 0,
                        EndMinute = 1,

                    };
                    addingleavedays.Schedule = dailySchedule;
                    addingleavedays.Update();
                }
            }
            catch (Exception ex)
            {
                SPDiagnosticsService.Local.WriteTrace(0, new SPDiagnosticsCategory("Udateleavebalance", TraceSeverity.Monitorable, EventSeverity.Error), TraceSeverity.Monitorable, ex.Message, new object[] { ex.StackTrace });
            }
        }


        // Uncomment the method below to handle the event raised before a feature is deactivated.

        public override void FeatureDeactivating(SPFeatureReceiverProperties properties)
        {
            try
            {
                var site = (SPSite)properties.Feature.Parent;
                foreach (SPJobDefinition spJobDefinition in site.WebApplication.JobDefinitions)
                {
                    if (spJobDefinition.Title == Utilities.TimerJobName)
                    {
                        spJobDefinition.Delete();
                        break;
                    }
                }
                site.WebApplication.Update();
            }
            catch (Exception ex)
            {
                SPDiagnosticsService.Local.WriteTrace(0, new SPDiagnosticsCategory("Udateleavebalance", TraceSeverity.Monitorable, EventSeverity.Error), TraceSeverity.Monitorable, ex.Message, new object[] { ex.StackTrace });
            }
        }


        // Uncomment the method below to handle the event raised after a feature has been installed.

        //public override void FeatureInstalled(SPFeatureReceiverProperties properties)
        //{
        //}


        // Uncomment the method below to handle the event raised before a feature is uninstalled.

        //public override void FeatureUninstalling(SPFeatureReceiverProperties properties)
        //{
        //}

        // Uncomment the method below to handle the event raised when a feature is upgrading.

        //public override void FeatureUpgrading(SPFeatureReceiverProperties properties, string upgradeActionName, System.Collections.Generic.IDictionary<string, string> parameters)
        //{
        //}
    }
}
