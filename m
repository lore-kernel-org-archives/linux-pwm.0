From: Jonathan Cameron <Jonathan.Cameron-aYUidmrrA3LQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 5/7] iio: temperature: Add support for Azoteq
 IQS620AT temperature sensor
Date: Tue, 28 Jan 2020 09:10:01 +0000
Message-ID: <20200128091001.00001e1d@Huawei.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
        <1579228475-6681-6-git-send-email-jeff@labundy.com>
        <20200122032821.GA29969@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200122032821.GA29969-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Cc: "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "knaack.h-Mmb7MZpHnFY@public.gmane.org" <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, 22 Jan 2020 03:28:28 +0000
Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org> wrote:

> Hi Jonathan,
> 
> I just wanted to give a heads up that I'm making a couple of very minor
> changes to the lot of IIO patches in this series in response to changes
> to include/linux/mfd/iqs62x.h for v5, namely:
> 
> - Replaced iqs62x->map with iqs62x->regmap
> - Dropped #defines for platform_driver name and alias in favor of the
>   actual string names (e.g. IQS620_DRV_NAME_TEMP --> "iqs620at-temp")
> 
> For small changes like these, I plan to retain your Reviewed-by trailer
> when I send out v5 even though the file would have changed slightly. If
> you would prefer I let you re-review first, please let me know.

I'm fine with you keeping it.  Thanks for checking though.

Jonathan
> 
> On Thu, Jan 16, 2020 at 08:36:08PM -0600, Jeff LaBundy wrote:
> > This patch adds support for the Azoteq IQS620AT temperature sensor,
> > capable of reporting its absolute die temperature.
> > 
> > Signed-off-by: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > ---
> > Changes in v4:
> >   - None
> > 
> > Changes in v3:
> >   - Added Reviewed-by trailer
> > 
> > Changes in v2:
> >   - Moved the driver from hwmon to iio
> >   - Merged 'Copyright' and 'Author' lines into one in introductory comments
> >   - Replaced 'error' with 'ret' throughout
> >   - Eliminated tabbed alignment of platform_driver struct members
> >   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
> > 
> >  drivers/iio/temperature/Kconfig         | 10 ++++
> >  drivers/iio/temperature/Makefile        |  1 +
> >  drivers/iio/temperature/iqs620at-temp.c | 97 +++++++++++++++++++++++++++++++++
> >  3 files changed, 108 insertions(+)
> >  create mode 100644 drivers/iio/temperature/iqs620at-temp.c
> >   
> 
> Kind regards,
> Jeff LaBundy
