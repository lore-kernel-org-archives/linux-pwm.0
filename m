From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/8] PWM: add pwm-stm32 DT bindings
Date: Mon, 19 Dec 2016 12:55:52 +0000
Message-ID: <20161219125552.GD23486@dell>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-4-git-send-email-benjamin.gaignard@st.com>
 <20161212190205.b5t3x6i2o7igldlo@rob-hp-laptop>
 <20161213111137.GW3625@dell.home>
 <CAL_JsqL8pJSFb8LbABAYJOQ0URaMpyupbFryk_mS2ToN1kStdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqL8pJSFb8LbABAYJOQ0URaMpyupbFryk_mS2ToN1kStdA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>, Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>, Arnaud POULIQUEN <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>Linus Walleij <l>
List-Id: linux-pwm@vger.kernel.org

On Tue, 13 Dec 2016, Rob Herring wrote:
> On Tue, Dec 13, 2016 at 5:11 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On Mon, 12 Dec 2016, Rob Herring wrote:
> >
> >> On Fri, Dec 09, 2016 at 03:15:14PM +0100, Benjamin Gaignard wrote:
> >> > Define bindings for pwm-stm32
> >> >
> >> > version 6:
> >> > - change st,breakinput parameter format to make it usuable on stm32f7 too.
> >> >
> >> > version 2:
> >> > - use parameters instead of compatible of handle the hardware configuration
> >> >
> >> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
> >> > ---
> >> >  .../devicetree/bindings/pwm/pwm-stm32.txt          | 33 ++++++++++++++++++++++
> >> >  1 file changed, 33 insertions(+)
> >> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >> > new file mode 100644
> >> > index 0000000..866f222
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> >> > @@ -0,0 +1,33 @@
> >> > +STMicroelectronics STM32 Timers PWM bindings
> >> > +
> >> > +Must be a sub-node of an STM32 Timers device tree node.
> >> > +See ../mfd/stm32-timers.txt for details about the parent node.
> >> > +
> >> > +Required parameters:
> >> > +- compatible:              Must be "st,stm32-pwm".
> >> > +- pinctrl-names:   Set to "default".
> >> > +- pinctrl-0:               List of phandles pointing to pin configuration nodes for PWM module.
> >> > +                   For Pinctrl properties see ../pinctrl/pinctrl-bindings.txt
> >> > +
> >> > +Optional parameters:
> >> > +- st,breakinput:   Arrays of three u32 <index level filter> to describe break input configurations.
> >> > +                   "index" indicates on which break input the configuration should be applied.
> >> > +                   "level" gives the active level (0=low or 1=high) for this configuration.
> >> > +                   "filter" gives the filtering value to be applied.
> >> > +
> >> > +Example:
> >> > +   timers@40010000 {
> >>
> >> timer@...
> >
> > No, it should be timers.
> 
> Read the spec. "timer" is a generic node name. "timers" is not. How
> many is not relevant.

It's not the amount of timers that there are, it's the different types
of timers which this one IP contains.

In MFD we usually list the part number or IP name, however in this
case its difficult because the same IP doesn't have a specific name
listed, and provides; advanced, general purpose and basic timers, as
well as PWM functionality.

This IP is not a timer (although one of its children is one).  It's
the parent device of many different types of timer.

timer {
      timer {
      };

      pwm {
      };
};

... looks weird.

"timer" is not right for the parent IP.  Happy for you to provide an
alternative to "timers" though?

> > The 's' is intentional, since this parent (MFD) device houses 3
> > different types of timers.  The "timer" node is a child of this one.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
