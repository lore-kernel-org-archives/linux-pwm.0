From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] backlight: pwm: handle EPROBE_DEFER while requesting
 the PWM
Date: Mon, 25 May 2015 11:27:18 +0200
Message-ID: <20150525112718.5f7e2d7d@bbrezillon>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
	<20150312090224.GC3314@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56100 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750852AbbEYJ1W (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2015 05:27:22 -0400
In-Reply-To: <20150312090224.GC3314@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, jg1.han@samsung.com, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Hi Lee,

On Thu, 12 Mar 2015 09:02:24 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Thu, 19 Feb 2015, Nicolas Ferre wrote:
> 
> > When trying to request the PWM device with devm_pwm_get(), the EPROBE_DEFER
> > flag is not handled properly. It can lead to the PWM not being found.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Applied, thanks.

I don't see this patch in Linus' tree (actually, it's not even in
linux-next).
I don't know where it's stuck, but could you make sure it reaches
mainline for 4.2 (or 4.1 if it's not to late) ?

Best Regards,

Boris




-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
