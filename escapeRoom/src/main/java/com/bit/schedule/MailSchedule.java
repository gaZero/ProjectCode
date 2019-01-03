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
				
				mailMessage.setSubject(rv.getErname()+" 예약 안내 메일입니다.");
				mailMessage.setFrom("demian383@naver.com");
				mailMessage.setText(rv.getName()+" 고객님! 안녕하세요? \r\n"
						+ "EscapeRoom 통합센터 ER을 사용해주셔서 진심으로 감사드립니다. \r\n"
						+ year+"년 "+month+"일 "+date+"일의 예매내역을 확인해주세요. \r\n"+"\r\n"
						+ "예매자 : "+ rv.getName() +"\r\n"
						+ "카페명 : "+ rv.getErname() +"\r\n"
						+ "테마명 : "+ rv.getTname() +"\r\n"
						+ "일  시 : "+ rv.getBookDate() + " " + viewtime +"\r\n"+"\r\n"
						+ "감사합니다.");
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









