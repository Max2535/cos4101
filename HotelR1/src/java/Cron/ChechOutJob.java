package Cron;

import ClassSystem.Reservation;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class ChechOutJob implements Job {

    public void execute(JobExecutionContext context)
            throws JobExecutionException {
        Reservation reservation = new Reservation();
        System.out.print("------------------------ChechOutJob------------------------");
        System.out.print(reservation.checkOutReservationAutomation(0));

    }

}
