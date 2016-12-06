From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 7/7] ARM: dts: stm32: add stm32 general purpose timer
 driver in DT
Date: Tue, 6 Dec 2016 12:54:10 +0000
Message-ID: <20161206125410.GE25385@dell.home>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-8-git-send-email-benjamin.gaignard@st.com>
 <20161202132251.GL2683@dell>
 <e15186cb-a93e-c2e7-13bb-6704be5e8949@st.com>
 <20161206094835.GB25385@dell.home>
 <8f881cf7-ba63-315f-b852-71869ad480f3@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8f881cf7-ba63-315f-b852-71869ad480f3-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Cc: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, 06 Dec 2016, Alexandre Torgue wrote:
> On 12/06/2016 10:48 AM, Lee Jones wrote:
> > On Mon, 05 Dec 2016, Alexandre Torgue wrote:
> > > On 12/02/2016 02:22 PM, Lee Jones wrote:
> > > > On Fri, 02 Dec 2016, Benjamin Gaignard wrote:
> > > > 
> > > > > Add general purpose timers and it sub-nodes into DT for stm32f4.
> > > > > Define and enable pwm1 and pwm3 for stm32f469 discovery board
> > > > > 
> > > > > version 3:
> > > > > - use "st,stm32-timer-trigger" in DT
> > > > > 
> > > > > version 2:
> > > > > - use parameters to describe hardware capabilities
> > > > > - do not use references for pwm and iio timer subnodes
> > > > > 
> > > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
> > > > > ---
> > > > >  arch/arm/boot/dts/stm32f429.dtsi      | 333 +++++++++++++++++++++++++++++++++-
> > > > >  arch/arm/boot/dts/stm32f469-disco.dts |  28 +++
> > > > >  2 files changed, 360 insertions(+), 1 deletion(-)
> > 
> > [...]
> > 
> > If you're only commenting on a little piece of the patch, it's always
> > a good idea to trim the rest.
> > 
> > > > > diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> > > > > index 8a163d7..df4ca7e 100644
> > > > > --- a/arch/arm/boot/dts/stm32f469-disco.dts
> > > > > +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> > > > > @@ -81,3 +81,31 @@
> > > > >  &usart3 {
> > > > >  	status = "okay";
> > > > >  };
> > > > > +
> > > > > +&gptimer1 {
> > > > > +	status = "okay";
> > > > > +
> > > > > +	pwm1@0 {
> > > > > +		pinctrl-0	= <&pwm1_pins>;
> > > > > +		pinctrl-names	= "default";
> > > > > +		status = "okay";
> > > > > +	};
> > > > > +
> > > > > +	timer1@0 {
> > > > > +		status = "okay";
> > > > > +	};
> > > > > +};
> > > > 
> > > > This is a much *better* format than before.
> > > > 
> > > > I still don't like the '&' syntax though.
> > > 
> > > Please keep "&" format to match with existing nodes.
> > 
> > Right.  I wasn't suggesting that he differs from the current format in
> > *this* set.  I am suggesting that we change the format in a subsequent
> > set though.
> 
> Why change? Looking at Linux ARM kernel patchwork, new DT board file
> contains this format. Did you already discuss with Arnd or Olof about it ?

Because the syntax is horrible.  It removes any indication of
hierarchy and insists all nodes include labels that would otherwise be
unnecessary.

The syntax is approved, so there is no issue with Arnd/Olof, nor the
DT Maintainers.  The decision is left to the sub-arch maintainer to
choose to use it or not.  My vote (which doesn't really count for
anything in this scenario) is to not use it for the aforementioned
reasons.

> > > > > +&gptimer3 {
> > > > > +	status = "okay";
> > > > > +
> > > > > +	pwm3@0 {
> > > > > +		pinctrl-0	= <&pwm3_pins>;
> > > > > +		pinctrl-names	= "default";
> > > > > +		status = "okay";
> > > > > +	};
> > > > > +
> > > > > +	timer3@0 {
> > > > > +		status = "okay";
> > > > > +	};
> > > > > +};
> > > > 
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
