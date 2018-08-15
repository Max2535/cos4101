package Cron;

import ClassSystem.Reservation;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class CancelJob implements Job {

    public void execute(JobExecutionContext context)
            throws JobExecutionException {

        Reservation reservation = new Reservation();
        System.out.print("------------------------CancelJob------------------------");
        System.out.print(reservation.cancelReservationAutomation(0));

    }

}
