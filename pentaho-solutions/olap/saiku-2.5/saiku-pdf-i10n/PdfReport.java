package org.saiku.web.svg;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.print.PageFormat;
import java.awt.print.Paper;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.lowagie.text.*;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.print.PrintTranscoder;
import org.apache.commons.lang.StringUtils;
import org.saiku.olap.dto.resultset.CellDataSet;
import org.saiku.olap.dto.resultset.DataCell;

import com.lowagie.text.html.WebColors;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class PdfReport {
    private ReportData section= new ReportData(); 
    
	public byte[] pdf(CellDataSet c, String svg) throws DocumentException, IOException {
		section.setRowBody(c.getCellSetBody());
		section.setRowHeader(c.getCellSetHeaders());
        int dim = section.dimTab(c.getCellSetBody(), c.getCellSetHeaders());
        ArrayList<ReportData.Section> rowGroups = section.section(c.getCellSetBody(), c.getCellSetHeaders(), 0, dim, null);
        int maxColumn = 0;
        for (ReportData.Section sec : rowGroups) {
            if (sec.getChild().size() > 0) {
                if (sec.getChild().get(0).getHead().size() > maxColumn) {
                    maxColumn = sec.getChild().get(0).getHead().size();
                }
            }
        }
        //default A4
        Rectangle rect = new RectangleReadOnly(595,842);
        if (maxColumn > 6) {
            rect = new RectangleReadOnly(maxColumn * 100, 842);
        }
        Document document = new Document(rect,0,0,30,10);
		Color color = WebColors.getRGBColor("#FFEEAA");
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
			PdfWriter writer = PdfWriter.getInstance(document, baos);
			document.open();			
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			document.setHeader(new HeaderFooter(new Phrase("Saiku Export - " + dateFormat.format(date) + " Page: "), null));


			populatePdf(document, rowGroups, dim,color,0);

			// do we want to add a svg image?
			if (StringUtils.isNotBlank(svg)) {
				document.newPage();
				StringBuffer s1 = new StringBuffer(svg);
				if (!svg.startsWith("<svg xmlns=\"http://www.w3.org/2000/svg\" ")) {
					s1.insert(s1.indexOf("<svg") + 4, " xmlns='http://www.w3.org/2000/svg'");
				}

				String t = "<?xml version='1.0' encoding='ISO-8859-1'"
						+ " standalone='no'?>" + s1.toString();
				PdfContentByte cb = writer.getDirectContent();
				cb.saveState();
				cb.concatCTM(1.0f, 0, 0, 1.0f, 36, 0);
				float width = document.getPageSize().getWidth() - 20;
				float height = document.getPageSize().getHeight() - 20;
				Graphics2D g2 = cb.createGraphics(width, height);
				//g2.rotate(Math.toRadians(-90), 100, 100);
				PrintTranscoder prm = new PrintTranscoder();
				TranscoderInput ti = new TranscoderInput(new StringReader(t));
				prm.transcode(ti, null);
				PageFormat pg = new PageFormat();
				Paper pp = new Paper();
				pp.setSize(width, height);
				pp.setImageableArea(5, 5, width, height);
				pg.setPaper(pp);
				prm.print(g2, pg, 0);
				g2.dispose();
				cb.restoreState();
			}

			document.close();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return baos.toByteArray();
	}

	public Color color(Color c, float percent){
		Color end=new Color(255, 255, 255);
		 int r = c.getRed() + (int)(percent * (end.getRed() - c.getRed()));
		    int b = c.getBlue() + (int)(percent * (end.getBlue() - c.getBlue()));
		    int g = c.getGreen() + (int)(percent * (end.getGreen() - c.getGreen()));
		    c=new Color(r, g, b);
		    return c;
	}
	

	public void populatePdf(Document doc, ArrayList<ReportData.Section> section, int dim,Color color,float c)
        throws IOException, DocumentException {
		for (int i = 0; i < section.size(); i++) {
			int temp = 1;
			if (section.get(i).getHead().size() != 0)
				temp = section.get(i).getHead().size();
			PdfPTable data = new PdfPTable(temp);
			data.setWidthPercentage(90);
			PdfPTable table = new PdfPTable(dim);
			table.setWidthPercentage(90);
            BaseFont baseFont = BaseFont.createFont("fonts/arialuni.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
			Font myFont = new Font(baseFont, 8);
			if(section.get(i).getDes()!=null){
//				if(section.get(i).getParent()!=null && section.get(i).getParent().getDes()!=null ){
//					section.get(i).setDes(section.get(i).getParent().getDes().trim()+" / "+section.get(i).getDes().trim());
//				}
			PdfPCell row = new PdfPCell(new Phrase(section.get(i).getDes(), myFont));
			row.setBackgroundColor(color);
			row.setBorder(Rectangle.BOX);
//			row.setBorder(Rectangle.BOTTOM);
			row.setTop(100);
			row.setColspan(dim);
			table.addCell(row);
			table.setSpacingAfter(1);
			}
			
			if (section.get(i).getData() != null) {
				for (int x = 0; x < section.get(i).getHead().size(); x++) {
					PdfPCell cell = new PdfPCell(new Phrase(section.get(i)
							.getHead().get(x), myFont));
					cell.setBackgroundColor(WebColors.getRGBColor("#B9D3EE"));
					cell.setBorder(Rectangle.BOX);
					//cell.setBorder(Rectangle.BOTTOM);
					if(section.get(i)
							.getData()[0][section.get(i).getData()[0].length
											- section.get(i).getHead().size()+x].getClass().equals(DataCell.class))
					cell.setHorizontalAlignment( Element.ALIGN_RIGHT );
					else 
						cell.setHorizontalAlignment( Element.ALIGN_LEFT );
					data.addCell(cell);
					
				}
				for (int t = 0; t < section.get(i).getData().length; t++) {
					for (int x = section.get(i).getData()[0].length
							- section.get(i).getHead().size(); x < section.get(
							i).getData()[0].length; x++) {
						PdfPCell cell = new PdfPCell(new Phrase(section.get(i)
								.getData()[t][x].getFormattedValue(),
								myFont));
                        cell.setBorder(Rectangle.BOX);
						//cell.setBorder(Rectangle.BOTTOM);
						int r=t %2;
						if(r!= 0)
						cell.setBackgroundColor(color(Color.BLACK,(float)0.92));
						
						if(section.get(i)
								.getData()[t][x].getClass().equals(DataCell.class))
						cell.setHorizontalAlignment( Element.ALIGN_RIGHT );
						else 
							cell.setHorizontalAlignment( Element.ALIGN_LEFT );
						data.addCell(cell);

					}
				}
			}

			try {
				doc.top(30);
				doc.add(table);
				doc.add(data);
			} catch (DocumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			populatePdf(doc, section.get(i).getChild(), dim,color(color,c+0.15f),c);
		}
	}

	
	
}
