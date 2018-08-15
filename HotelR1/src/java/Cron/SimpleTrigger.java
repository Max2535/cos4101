package Cron;

import ClassSystem.ConfigSystem;

import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleScheduleBuilder;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

public class SimpleTrigger {

    public SimpleTrigger(){
        try {
            ConfigSystem con = new ConfigSystem();
            int Seconds=Integer.parseInt(con.GetConfig(4));
            JobDetail job = JobBuilder.newJob(ChechOutJob.class)
                    .withIdentity("dummyJobName", "group1").build();
            Trigger trigger = TriggerBuilder
                    .newTrigger()
                    .withIdentity("dummyTriggerName", "group1")
                    .withSchedule(
                            SimpleScheduleBuilder.simpleSchedule()
                                    .withIntervalInSeconds(Seconds).repeatForever())
                    .build();
            Scheduler scheduler = new StdSchedulerFactory().getScheduler();
            scheduler.start();
            scheduler.scheduleJob(job, trigger);
            JobDetail job1 = JobBuilder.newJob(CancelJob.class)
            .withIdentity("dummyJobName1", "group2").build();
            Trigger trigger1 = TriggerBuilder
            .newTrigger()
            .withIdentity("dummyTriggerName1", "group2")
            .withSchedule(
            SimpleScheduleBuilder.simpleSchedule()
            .withIntervalInSeconds(Seconds).repeatForever())
            .build();
            Scheduler scheduler1 = new StdSchedulerFactory().getScheduler();
            scheduler1.start();
            scheduler1.scheduleJob(job1, trigger1);
        } catch (SchedulerException ex) {
            ex.printStackTrace();
        }

    }
}
