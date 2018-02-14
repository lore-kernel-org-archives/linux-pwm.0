From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/8] Add support for PWM input capture on STM32
Date: Wed, 14 Feb 2018 09:38:53 +0000
Message-ID: <20180214093853.4sskffpd5iasswen@dell>
References: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
 <5ade7f05-f5cc-e272-842c-22effa78b716@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5ade7f05-f5cc-e272-842c-22effa78b716-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 14 Feb 2018, Fabrice Gasnier wrote:

> On 01/26/2018 04:11 PM, Fabrice Gasnier wrote:
> > This series adds support for capture to stm32-pwm driver.
> > Capture is based on DMAs.
> > - First two patches are precursor patches
> > - Subsequent two patches add support for requesting DMAs to MFD core
> > - Next three patches add support for capture to stm32-pwm driver
> > - This has been tested on stm32429i-eval board.
> > 
> > ---
> > Changes in v2:
> > - Abstract DMA handling from child driver: move it to MFD core
> > - Rework pwm capture routines to adopt this change
> > - Comment on optional dma support, beautify DMAs probe
> 
> Hi all,
> 
> Gentle ping for v2 driver review since DT Bindings has been reviewed by
> Rob and the series by Benjamin.

Best thing to do is collect the Acks you have and send the set out as
a [RESEND].

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
