package com.bit.schedule;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.bit.dao.ResDao;
import com.bit.vo.ResVo;

@Component
public class MailSchedule {
	
	@Autowired
	private MailSender mailSender;
	
	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	@Autowired
	private ResDao resDao;

	public void setResDao(ResDao resDao) {
		this.resDao = resDao;
	}

	@Scheduled(cron="0 0 9 * * ?")
	public void sendMail()
	{
		Date d = new Date();
		int year = d.getYear()+1900;
		int month = d.getMonth()+1;
		int date = d.getDate();

		List<ResVo> list = resDao.mailToCustomer();
		
		SimpleMailMessage mailMessage = new SimpleMailMessage();
		
		for(ResVo rv : list) {
			int r_year = Integer.parseInt(rv.getBookDate().substring(0, 4));
			int r_month = Integer.parseInt(rv.getBookDate().substring(5, 7));
			int r_date = Integer.parseInt(rv.getBookDate().substring(8, 10));
			if(r_year == year && r_month == month && r_date == date) {
				int time = rv.getBookTime();
				int hour = (int) Math.floor(time/60);
				int minute = Math.round((time/60 - hour) * 60);
				String viewtime = "";
				if(minute < 10) {
					viewtime = hour+":0"+minute;
				} else {
					viewtime = hour+":"+minute;
				}
				
				mailMessage.setSubject(rv.getErname()+" ���� �ȳ� �����Դϴ�.");
				mailMessage.setFrom("demian383@naver.com");
				mailMessage.setText(rv.getName()+" ����! �ȳ��ϼ���? \r\n"
						+ "EscapeRoom ���ռ��� ER�� ������ּż� �������� ����帳�ϴ�. \r\n"
						+ year+"�� "+month+"�� "+date+"���� ���ų����� Ȯ�����ּ���. \r\n"+"\r\n"
						+ "������ : "+ rv.getName() +"\r\n"
						+ "ī��� : "+ rv.getErname() +"\r\n"
						+ "�׸��� : "+ rv.getTname() +"\r\n"
						+ "��  �� : "+ rv.getBookDate() + " " + viewtime +"\r\n"+"\r\n"
						+ "�����մϴ�.");
				mailMessage.setTo(rv.getEmail());
				try {
					mailSender.send(mailMessage);
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}
			}
		}
	}
}









