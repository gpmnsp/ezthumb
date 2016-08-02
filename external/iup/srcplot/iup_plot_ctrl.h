#ifndef __IUP_PLOT_CTRL_H__
#define __IUP_PLOT_CTRL_H__


#define IUP_PLOT_MAX_PLOTS 20

enum { IUP_PLOT_NATIVE, IUP_PLOT_NATIVEPLUS, IUP_PLOT_IMAGERGB, IUP_PLOT_OPENGL };
enum { IUP_PLOT_CROSSNONE, IUP_PLOT_CROSSVERT, IUP_PLOT_CROSSHORIZ };

struct _IcontrolData
{
  iupCanvas canvas;  /* from IupCanvas (must reserve it) */

  iupPlot* plot_list[IUP_PLOT_MAX_PLOTS];
  int plot_list_count;

  iupPlot* current_plot;
  int current_plot_index;

  int numcol;
  int sync_view;
  int read_only;
  int clear;

  cdCanvas* cd_canvas;
  int graphics_mode;
  int default_font_size;
  int default_font_style;

  int last_click_x,
      last_click_y,
      last_click_plot;
  int show_cross_hair;

  int last_pos_x,
      last_pos_y,
      last_pos_moving;

  int last_tip_ds,
    last_tip_sample;
};

void iupPlotRegisterAttributes(Iclass* ic);

void iupPlotUpdateViewports(Ihandle* ih);
void iupPlotRedraw(Ihandle* ih, int flush, int only_current, int reset_redraw);
void iupPlotResetZoom(Ihandle *ih, int redraw);

void iupPlotSetPlotCurrent(Ihandle* ih, int p);
void iupPlotShowMenuContext(Ihandle* ih, int screen_x, int screen_y, int x, int y);

int iupStrToColor(const char* str, long *color);

#endif
