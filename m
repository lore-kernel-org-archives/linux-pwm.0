From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/8] mfd: stm32-timers: add support for dmas
Date: Tue, 23 Jan 2018 16:41:21 +0000
Message-ID: <20180123164121.xjzhypqe2u5c7zza@dell>
References: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
 <1516106631-18722-5-git-send-email-fabrice.gasnier@st.com>
 <20180123133234.xmep76cgdremnj47@dell>
 <e611b40f-bd37-aa2d-afd9-997b86d55441@st.com>
 <20180123153035.2rvhspe2m5ej57op@dell>
 <ee021839-3298-d01b-8890-619aca0399a7@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ee021839-3298-d01b-8890-619aca0399a7-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 23 Jan 2018, Fabrice Gasnier wrote:
> On 01/23/2018 04:30 PM, Lee Jones wrote:
> > On Tue, 23 Jan 2018, Fabrice Gasnier wrote:
> > 
> >> On 01/23/2018 02:32 PM, Lee Jones wrote:
> >>> On Tue, 16 Jan 2018, Fabrice Gasnier wrote:
> >>>
> >>>> STM32 Timers can support up to 7 dma requests:
> >>>> 4 channels, update, compare and trigger.
> >>>> Optionally request part, or all dmas from stm32-timers MFD core.
> >>>> Also, keep reference of device's bus address to allow child drivers to
> >>>> transfer data from/to device by using dma.
> >>>>
> >>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
> >>>> ---
> >>>>  drivers/mfd/stm32-timers.c       | 37 ++++++++++++++++++++++++++++++++++++-
> >>>>  include/linux/mfd/stm32-timers.h | 14 ++++++++++++++
> >>>>  2 files changed, 50 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> >>>>  static int stm32_timers_probe(struct platform_device *pdev)
> >>>>  {
> >>>>  	struct device *dev = &pdev->dev;
> >>>> @@ -44,6 +61,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
> >>>>  	mmio = devm_ioremap_resource(dev, res);
> >>>>  	if (IS_ERR(mmio))
> >>>>  		return PTR_ERR(mmio);
> >>>> +	ddata->phys_base = res->start;
> >>>
> >>> What do you use this for?
> >>
> >> This is used in in child driver (pwm) for capture data transfer by dma.
> > 
> > Might be worth being clear about that.
> > 
> > Perhaps pass in 'dma_base' (phys_base + offset) instead?
> 
> I guess you've had a look at [PATCH 5/8] pwm: stm32: add capture
> support. Are you talking about passing phys_base + TIM_DMAR ?

I have and I am.

> If this is the case, I'd prefer to keep phys base only if you don't
> mind, and handle TIM_DMAR offset in pwm driver. This way, all dma slave
> config is kept locally at one place.
> Or do you mean something else ?
> 
> Maybe I can add a comment here about this ?
> Something like:
> /* phys_base to be used by child driver, e.g. DMA burst mode */

I haven't seen the memory map for this device, so it's not easy for me
to comment, but passing in the physical address of the parent MFD into
a child device doesn't quite sit right with me.

At what level does TIM_DMAR sit?  Is it a child (PWM) specific
property, or is it described at parent (Timer) level?

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
