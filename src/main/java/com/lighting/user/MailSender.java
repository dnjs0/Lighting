package com.lighting.user;

import java.util.HashMap;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.lighting.user.model.UserDAO;

public class MailSender {

    public void send(HashMap<String, String> map) {
        try {
            String username = "thdnjs1346@gmail.com";
            String password = "oimy dxqb iamo lpze";  

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(map.get("email")));
            message.setSubject("오늘어때 사이트에서 발송한 인증 번호입니다.");

            String content = """
                    <h1>인증 번호 발송</h1>
                    <div style="border: 1px solid #CCC; width: 200px; height: 100px; border-radius: 3px; background-color: #EEE; display: flex; justify-content: center; align-items: center; margin: 10px 0;">인증번호: <span style="font-style: monospace;">%s</span></div>
                    <div>위의 인증번호를 확인하세요.</div>
                    """.formatted(map.get("validNumber"));

            message.setContent(content, "text/html; charset=UTF-8");

            Transport.send(message);
            
            // DB에 이메일과 인증번호 삽입
            UserDAO dao = new UserDAO();
            dao.addEmail(map);  // 이메일과 인증번호를 DB에 저장
            dao.close();

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("메일 전송에 실패했습니다.");
        }
    }
}
