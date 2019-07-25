From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 0/4] backlight: Expose brightness curve type through
 sysfs
Date: Thu, 25 Jul 2019 12:15:41 +0100
Message-ID: <20190725111541.GA23883@dell>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190722235926.GA250418@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722235926.GA250418@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, 22 Jul 2019, Matthias Kaehlcke wrote:

> On Tue, Jul 09, 2019 at 12:00:03PM -0700, Matthias Kaehlcke wrote:
> > Backlight brightness curves can have different shapes. The two main
> > types are linear and non-linear curves. The human eye doesn't
> > perceive linearly increasing/decreasing brightness as linear (see
> > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > linearly to human eye"), hence many backlights use non-linear (often
> > logarithmic) brightness curves. The type of curve is currently opaque
> > to userspace, so userspace often relies on more or less reliable
> > heuristics (like the number of brightness levels) to decide whether
> > to treat a backlight device as linear or non-linear.
> > 
> > Export the type of the brightness curve via a new sysfs attribute.
> > 
> > Matthias Kaehlcke (4):
> >   MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
> >   backlight: Expose brightness curve type through sysfs
> >   backlight: pwm_bl: Set scale type for CIE 1931 curves
> >   backlight: pwm_bl: Set scale type for brightness curves specified in
> >     the DT
> > 
> >  .../ABI/testing/sysfs-class-backlight         | 26 ++++++++++++++
> >  MAINTAINERS                                   |  2 ++
> >  drivers/video/backlight/backlight.c           | 19 ++++++++++
> >  drivers/video/backlight/pwm_bl.c              | 35 ++++++++++++++++++-
> >  include/linux/backlight.h                     |  8 +++++
> >  5 files changed, 89 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight
> 
> ping, any comments on v3?

Looks like PATCH 2/4 still needs seeing to.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
