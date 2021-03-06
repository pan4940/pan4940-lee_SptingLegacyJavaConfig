package file.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import file.bean.FileDTO;

@Controller
@RequestMapping("/file")
public class FileUploadController {
	
	
	@GetMapping("/uploadForm")
	public String uploadForm() {
		return "/file/uploadForm";
	}
	
	
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
	}
	
	@PostMapping("/brandfileUploadAjax")
	@ResponseBody
	public List<FileDTO> brandfileUploadAjax(MultipartFile[] uploadFile, Model model)  {
		
		String uploadFolder = "C:\\thec\\brands";
		
		return fileUploadAjax(uploadFolder, uploadFile, model);
	}
	
	
	@PostMapping("/productfileUploadAjax")
	@ResponseBody
	public List<FileDTO> productfileUploadAjax(MultipartFile[] uploadFile, Model model)  {
		
		String uploadFolder = "C:\\thec\\product";
		
		return fileUploadAjax(uploadFolder, uploadFile, model);
	}
	
	@PostMapping("/boardfileUploadAjax")
	@ResponseBody
	public List<FileDTO> boardfileUploadAjax(MultipartFile[] uploadFile, Model model)  {
		
		String uploadFolder = "C:\\thec\\board";
		
		return fileUploadAjax(uploadFolder, uploadFile, model);
	}
	
	
	public List<FileDTO> fileUploadAjax(String uploadFolder, MultipartFile[] uploadFile, Model model)  {
		List<FileDTO> list = new ArrayList<>();
		
		
		String uploadFolderPath = getFolder();
		
		//make folder
		//uploadFolder??? ??????????????? uploadFolderPath ?????? ??????
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		
		for (MultipartFile multipartFile : uploadFile) {
			
			FileDTO fileDTO = new FileDTO();
			
			
			String uploadFileName = multipartFile.getOriginalFilename();
			fileDTO.setFileName(uploadFileName);
			
			//IE fileName
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			//????????? ?????????, ????????? ???????????? ????????? ????????? ????????? ???????????? ??????
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			fileDTO.setUuid(uuid.toString());
			fileDTO.setUploadPath(uploadPath.toString());
			//fileDTO.setUploadPath(uploadFolder);
			
			try {
				multipartFile.transferTo(saveFile);
				
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			//add to list
			list.add(fileDTO);
			
		} //end for
		
		return list;
	}
	
	
	
	
	
	
	
	//????????? ?????? ???????????? ????????? ??????
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		
		//File file = new File("c:\\thec\\" + fileName);
		File file = new File(fileName);
		
		
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
	@GetMapping(value =  "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	//MIME ????????? ???????????? ??? ??? ?????? APPLICATION_OCTET_STREAM_VALUE ???????????? ??????
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		Resource resource = new FileSystemResource("c:\\thec\\" + fileName);
		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		HttpHeaders headers = new HttpHeaders();
		
		try {
			
			String downloadName = null;
			
			//??????????????? ????????? ?????????????????? ??????
			if (userAgent.contains("Trident")) {
				downloadName = URLEncoder.encode(resourceName, "UTF-8").replaceAll("\\" + ",", " ");
				
			//??????????????? ????????????????????? Edge??? ??????
			} else if (userAgent.contains("Edg")) {
				downloadName = URLEncoder.encode(resourceName, "UTF-8");
			
			//??????????????? Chrome??? ??????
			} else {
				downloadName = new String(resourceName.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			//??????????????? ???????????? ????????? Content-Disposition??? ????????? ?????????
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName) {
		File file;
		
		try {
			file = new File("c:\\thec\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
}
