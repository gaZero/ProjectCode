package com.bit.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import com.bit.db.esRoomManager;
import com.bit.vo.EsRoomVo;

@Repository
public class EsRoomDao {
	
	public static List<EsRoomVo> listRoom(HashMap map){
		return esRoomManager.select(map);
	}

	public static EsRoomVo detailRoom(String ername) {
		return esRoomManager.selectDetail(ername);
	}

	public static int totalCount() {
		return esRoomManager.totalCount();
	}
	
	public static EsRoomVo esroomDetail(String id) {
		return esRoomManager.esroomDetail(id);
	}
	
	public static int insertRoom(EsRoomVo vo) {
		return esRoomManager.insertRoom(vo);
	}	
	
	public static int updateRoom(EsRoomVo vo) {
		return esRoomManager.updateRoom(vo);
	}
	
	public static int deleteRoom(String id) {
		return esRoomManager.deleteRoom(id);
	}
	
	public boolean isMember(Map map)
	{
		return esRoomManager.isMember(map);
	}
	
	public void logout(HttpSession session) {
		session.invalidate();
	}
	
	public boolean isMine(Map map)
	{
		return esRoomManager.isMine(map);
	}
}
