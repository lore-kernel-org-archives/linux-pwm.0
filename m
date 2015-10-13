From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] backlight: pwm: reject legacy pwm request for device
 defined in dt
Date: Tue, 13 Oct 2015 08:29:41 +0100
Message-ID: <20151013072941.GR17172@x1>
References: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <561BB2BC.9090907@atmel.com>
 <20151012153029.62f948d2@bbrezillon>
 <561BBB9F.6060808@mentor.com>
 <20151012160608.41f04553@bbrezillon>
 <561BC177.2050000@mentor.com>
 <20151012171931.3fb922d2@bbrezillon>
 <561BD282.70305@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37048 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbbJMH3p (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Oct 2015 03:29:45 -0400
Received: by wijq8 with SMTP id q8so17543656wij.0
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2015 00:29:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <561BD282.70305@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, 12 Oct 2015, Vladimir Zapolskiy wrote:

> On 12.10.2015 18:19, Boris Brezillon wrote:
> > On Mon, 12 Oct 2015 17:19:35 +0300
> > Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com> wrote:
> >>
> >>> Thierry's patch makes sure that EPROBE_DEFER is not returned when=
 the
> >>> PWM device definition is not found using in the PWM lookup tables=
 or
> >>> the DT definition,
> >>
> >> This is okay, but I'm interested in proper handling of cases other=
 than
> >> EPROBE_DEFER. EPROBE_DEFER and the related issues are on your bala=
nce
> >> and I'm attempting to avoid interfering with it here :)
> >=20
> > I keep thinking we should fix all platforms using the ->pwm_id pdat=
a
> > field to attach a PWM device to a PWM backlight instead of trying t=
o
> > guess when falling back to the legacy API is acceptable...
> >=20
> >>
> >>> and in this case the pwm_bl code will fallback to
> >>> the legacy PWM API, which AFAICT is what you're trying to solve.
> >>
> >> Fallback must happen exclusively under (IS_ERR(pb->pwm) &&
> >> PTR_ERR(pb->pwm) !=3D -EPROBE_DEFER && !pdev->dev.of_node) conditi=
on IMHO.
> >>
> >> Before EPROBE_DEFER appeared on the scene the condition was
> >> (IS_ERR(pb->pwm) && !pdev->dev.of_node).
> >>
> >> So, the question is if my change requires any updates or not from =
your
> >> point of view.
> >=20
> > ... but from a functional point of view your patch seems correct.
>=20
> Sounds good, thank you for review.

So should I take this patch, or not?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
