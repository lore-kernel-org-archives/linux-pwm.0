From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/7] mfd: Add support for Azoteq
 IQS620A/621/622/624/625
Date: Mon, 20 Jan 2020 08:00:25 +0000
Message-ID: <20200120080025.GP15507@dell>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-3-git-send-email-jeff@labundy.com>
 <20200117132143.GK15507@dell>
 <20200120042303.GC28865@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200120042303.GC28865-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Cc: "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "knaack.h-Mmb7MZpHnFY@public.gmane.org" <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, 20 Jan 2020, Jeff LaBundy wrote:
> On Fri, Jan 17, 2020 at 01:21:43PM +0000, Lee Jones wrote:
> > On Fri, 17 Jan 2020, Jeff LaBundy wrote:
> > 
> > > This patch adds core support for the Azoteq IQS620A, IQS621, IQS622,
> > > IQS624 and IQS625 multi-function sensors.
> > > 
> > > Signed-off-by: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > > Changes in v4:
> > >   - None
> > > 
> > > Changes in v3:
> > >   - None
> > > 
> > > Changes in v2:
> > >   - Merged 'Copyright' and 'Author' lines into one in introductory comments
> > >   - Replaced 'error' with 'ret' throughout
> > >   - Updated iqs62x_dev_init to account for 4/8/16-MHz clock divider in start-up
> > >     delays and replaced ATI timeout routine with regmap_read_poll_timeout
> > >   - Added an error message to iqs62x_irq in case device status fails to be read
> > >   - Replaced sw_num member of iqs62x_core with a local variable in iqs62x_probe
> > >     as the former was unused anywhere else
> > >   - Added comments throughout iqs62x_probe to clarify how devices are matched
> > >     based on the presence of calibration data
> > >   - Inverted the product and software number comparison logic in iqs62x_probe
> > >     to avoid an else...continue branch
> > >   - Changed iqs62x_probe from .probe callback to .probe_new callback, thereby
> > >     eliminating the otherwise unused iqs62x_id array
> > >   - Moved iqs62x_suspend and iqs62x_resume below iqs62x_remove
> > >   - Eliminated tabbed alignment of regmap_config and i2c_driver struct members
> > >   - Added register definitions for register addresses used in iqs621_cal_regs,
> > >     iqs620at_cal_regs and iqs62x_devs arrays
> > >   - Removed of_compatible string from IQS622 mfd_cell struct as its proximity
> > >     (now ambient light) sensing functionality need not be represented using a
> > >     child node
> > >   - Dissolved union in iqs62x_event_data to allow simultaneous use of ir_flags
> > >     and als_flags
> > >   - Removed temp_flags member of iqs62x_event_data, IQS62X_EVENT_TEMP register
> > >     enumeration and IQS62X_EVENT_UI_HI/LO from iqs620a_event_regs (thereby re-
> > >     ducing IQS62X_EVENT_SIZE to 10) as they were unused
> > > 
> > >  drivers/mfd/Kconfig         |  13 +
> > >  drivers/mfd/Makefile        |   3 +
> > >  drivers/mfd/iqs62x-core.c   | 639 ++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/mfd/iqs62x-tables.c | 438 ++++++++++++++++++++++++++++++
> > >  include/linux/mfd/iqs62x.h  | 146 ++++++++++
> > >  5 files changed, 1239 insertions(+)
> > >  create mode 100644 drivers/mfd/iqs62x-core.c
> > >  create mode 100644 drivers/mfd/iqs62x-tables.c
> > >  create mode 100644 include/linux/mfd/iqs62x.h

In future, could you trim all unnecessary parts of the review,
snipping out all of the parts you agree with, leaving only the
contentious context please?  It saves an awful lot of scrolling on
behalf of the reader/reviewer.  Thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
