From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2] backlight: pwm: reject legacy pwm request for device
 defined in dt
Date: Mon, 12 Oct 2015 17:19:31 +0200
Message-ID: <20151012171931.3fb922d2@bbrezillon>
References: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com>
	<561BB2BC.9090907@atmel.com>
	<20151012153029.62f948d2@bbrezillon>
	<561BBB9F.6060808@mentor.com>
	<20151012160608.41f04553@bbrezillon>
	<561BC177.2050000@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42438 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751881AbbJLPTe (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Oct 2015 11:19:34 -0400
In-Reply-To: <561BC177.2050000@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, 12 Oct 2015 17:19:35 +0300
Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com> wrote:
> 
> > Thierry's patch makes sure that EPROBE_DEFER is not returned when the
> > PWM device definition is not found using in the PWM lookup tables or
> > the DT definition,
> 
> This is okay, but I'm interested in proper handling of cases other than
> EPROBE_DEFER. EPROBE_DEFER and the related issues are on your balance
> and I'm attempting to avoid interfering with it here :)

I keep thinking we should fix all platforms using the ->pwm_id pdata
field to attach a PWM device to a PWM backlight instead of trying to
guess when falling back to the legacy API is acceptable...

> 
> > and in this case the pwm_bl code will fallback to
> > the legacy PWM API, which AFAICT is what you're trying to solve.
> 
> Fallback must happen exclusively under (IS_ERR(pb->pwm) &&
> PTR_ERR(pb->pwm) != -EPROBE_DEFER && !pdev->dev.of_node) condition IMHO.
> 
> Before EPROBE_DEFER appeared on the scene the condition was
> (IS_ERR(pb->pwm) && !pdev->dev.of_node).
> 
> So, the question is if my change requires any updates or not from your
> point of view.

... but from a functional point of view your patch seems correct.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
