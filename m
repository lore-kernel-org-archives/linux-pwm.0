From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v5] clk: Add PWM clock driver
Date: Fri, 10 Apr 2015 14:45:05 -0700
Message-ID: <20150410214505.14369.98377@quantum>
References: <1423855132-20939-1-git-send-email-p.zabel@pengutronix.de>
 <1426154657.14455.13.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35848 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbbDJVpN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Apr 2015 17:45:13 -0400
Received: by iebrs15 with SMTP id rs15so27874384ieb.3
        for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2015 14:45:12 -0700 (PDT)
In-Reply-To: <1426154657.14455.13.camel@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: =?utf-8?q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Quoting Philipp Zabel (2015-03-12 03:04:17)
> Am Freitag, den 13.02.2015, 20:18 +0100 schrieb Philipp Zabel:
> > Some board designers, when running out of clock output pads, decide to
> > (mis)use PWM output pads to provide a clock to external components.
> > This driver supports this practice by providing an adapter between the
> > PWM and clock bindings in the device tree. As the PWM bindings specify
> > the period in the device tree, this is a fixed clock.
> > 
> > Tested-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > Changes since v4:
> > - Added missing static keywords, as pointed out by Stephen Boyd
> > - Turned to_clk_pwm into an inline function,
> > - added MODULE_AUTHOR/DESCRIPTION/LICENSE,
> > - and fixed PWM spelling issues, as pointed out by Thierry Reding
> 
> Are there any further changes you'd like me to make to this patch?

Applied.

Thanks,
Mike

> 
> regards
> Philipp
> 
