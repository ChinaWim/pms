package com.pms.utils;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;

public class ValidateCodeUtils {

	/**
	 * 生成验证码
	 * @param args
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	static Random ran = new Random();
	public static void main(String[] args) throws Exception {
		OutputStream out = new FileOutputStream("e:/code1.png");
		genNewCode(out);
	}

	/**
	 * 生成一张图片，且写出到指定的输出流位置
	 * @param out
	 * @throws IOException
	 */
	public static String genNewCode(OutputStream out) throws IOException {
		int width = 108;
		int height = 34;
		//在内存中制作一张图片
		BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);

		//绘画这种图片
		//拿到画笔
		Graphics g = image.getGraphics();

		//把底色变成灰色
		g.setColor(Color.white);//颜色
		g.fillRect(0, 0, width, height);

		//写四个随机数字 5623
		String number = "";
		for(int i=1;i<=4;i++){
			number += ran.nextInt(10);
		}
		g.setColor(Color.BLACK);
		//字体
		g.setFont(new Font("黑体",Font.ITALIC,35));
		//写字
		g.drawString(number, 20, 40);

		//写随机颜色干扰线
		for(int i=1;i<=30;i++){
			int x1 = ran.nextInt(width);
			int x2 = ran.nextInt(width);
			int y1 = ran.nextInt(height);
			int y2 = ran.nextInt(height);
			g.setColor(getRandomColr());
			g.drawLine(x1, y1, x2, y2);
		}

		//把图片写出到硬盘
		ImageIO.write(image, "png", out);
		return number;
	}

	/**
	 * 生成随机颜色
	 */
	private static Color getRandomColr(){
		int r = ran.nextInt(256);
		int g = ran.nextInt(256);
		int b = ran.nextInt(256);
		return new Color(r,g,b);
	}
}
