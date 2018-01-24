From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/8] mfd: stm32-timers: add support for dmas
Date: Wed, 24 Jan 2018 14:56:33 +0000
Message-ID: <20180124145633.tnblnqau7ncju7dp@dell>
References: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
 <1516106631-18722-5-git-send-email-fabrice.gasnier@st.com>
 <20180123133234.xmep76cgdremnj47@dell>
 <e611b40f-bd37-aa2d-afd9-997b86d55441@st.com>
 <20180123153035.2rvhspe2m5ej57op@dell>
 <ee021839-3298-d01b-8890-619aca0399a7@st.com>
 <20180123164121.xjzhypqe2u5c7zza@dell>
 <2e6afc46-9ad4-a858-29c7-692798ece82f@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33805 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933974AbeAXO4j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Jan 2018 09:56:39 -0500
Received: by mail-wr0-f196.google.com with SMTP id 36so4357992wrh.1
        for <linux-pwm@vger.kernel.org>; Wed, 24 Jan 2018 06:56:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2e6afc46-9ad4-a858-29c7-692798ece82f@st.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, benjamin.gaignard@linaro.org, mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

On Wed, 24 Jan 2018, Fabrice Gasnier wrote:
> On 01/23/2018 05:41 PM, Lee Jones wrote:
> > On Tue, 23 Jan 2018, Fabrice Gasnier wrote:
> >> On 01/23/2018 04:30 PM, Lee Jones wrote:
> >>> On Tue, 23 Jan 2018, Fabrice Gasnier wrote:
> >>>
> >>>> On 01/23/2018 02:32 PM, Lee Jones wrote:
> >>>>> On Tue, 16 Jan 2018, Fabrice Gasnier wrote:
> >>>>>
> >>>>>> STM32 Timers can support up to 7 dma requests:
> >>>>>> 4 channels, update, compare and trigger.
> >>>>>> Optionally request part, or all dmas from stm32-timers MFD core.
> >>>>>> Also, keep reference of device's bus address to allow child drivers to
> >>>>>> transfer data from/to device by using dma.
> >>>>>>
> >>>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> >>>>>> ---
> >>>>>>  drivers/mfd/stm32-timers.c       | 37 ++++++++++++++++++++++++++++++++++++-
> >>>>>>  include/linux/mfd/stm32-timers.h | 14 ++++++++++++++
> >>>>>>  2 files changed, 50 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> >>>>>>  static int stm32_timers_probe(struct platform_device *pdev)
> >>>>>>  {
> >>>>>>  	struct device *dev = &pdev->dev;
> >>>>>> @@ -44,6 +61,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
> >>>>>>  	mmio = devm_ioremap_resource(dev, res);
> >>>>>>  	if (IS_ERR(mmio))
> >>>>>>  		return PTR_ERR(mmio);
> >>>>>> +	ddata->phys_base = res->start;
> >>>>>
> >>>>> What do you use this for?
> >>>>
> >>>> This is used in in child driver (pwm) for capture data transfer by dma.
> >>>
> >>> Might be worth being clear about that.
> >>>
> >>> Perhaps pass in 'dma_base' (phys_base + offset) instead?
> >>
> >> I guess you've had a look at [PATCH 5/8] pwm: stm32: add capture
> >> support. Are you talking about passing phys_base + TIM_DMAR ?
> > 
> > I have and I am.
> > 
> >> If this is the case, I'd prefer to keep phys base only if you don't
> >> mind, and handle TIM_DMAR offset in pwm driver. This way, all dma slave
> >> config is kept locally at one place.
> >> Or do you mean something else ?
> >>
> >> Maybe I can add a comment here about this ?
> >> Something like:
> >> /* phys_base to be used by child driver, e.g. DMA burst mode */
> > 
> > I haven't seen the memory map for this device, so it's not easy for me
> > to comment, but passing in the physical address of the parent MFD into
> > a child device doesn't quite sit right with me.
> > 
> > At what level does TIM_DMAR sit?  Is it a child (PWM) specific
> > property, or is it described at parent (Timer) level?
> > 
> Hi Lee,
> 
> This isn't child (PWM) specific. TIM_DMAR is described at timer level as
> well as all timers DMA requests lines. Current patchset make it useful
> for PWM capture. Basically, I think this can be seen as interrupts, as
> each (0..7) dma request has an enable bit (in DIER: interrupt enable
> register). This is similar as interrupts at timer level.
> 
> So, I understand your point regarding passing physical address of the
> parent MFD... Speaking of interrupts, I'd probably have looked at
> irq_chip. Regarding dma, i'm not sure what is preferred way ?
> 
> Another way maybe to export a routine (export symbol) from MFD core, to
> handle dma transfer from there?
> By looking into drivers/mfd, I found similar approach, e.g.
> rtsx_pci_dma_transfer(). Do you think this is better approach ?
> 
> Please let me know your opinion.

It sounds fine in principle.  You are in a better position to make
that decision as you know the H/W more intimately than I, however it
does sound like a good idea to abstract the DMA handling from the
device if these aren't device-{level|specific} operations.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
