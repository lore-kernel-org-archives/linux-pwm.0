From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3] pwm: lpc32xx - Add a driver for the motor PWM
Date: Wed, 10 Sep 2014 11:21:29 +0200
Message-ID: <5900146.ZQPMvSzLeR@wuerfel>
References: <1410277361-26848-1-git-send-email-alban.bedel@avionic-design.de> <20140909160548.GB3896@leverpostej> <20140910104220.44558cf7@avionic-0020>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53626 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbaIJJVo (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Sep 2014 05:21:44 -0400
In-Reply-To: <20140910104220.44558cf7@avionic-0020>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <Pawel.Moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Roland Stigge <stigge@antcom.de>

On Wednesday 10 September 2014 10:42:20 Alban Bedel wrote:
> 
> > Please describe clocks in the binding. If the clock inputs are named,
> > please use clock-names.
> 
> No clock is defined in the current LPC32xx DTS, what should I do in
> this case?

This is a bit tricky. I would recommend describing the clock inputs
in the binding anyway, as "optional" properties, in case we ever get
a full DT-aware clocksource driver for lpc32xx.

I've just mentioned the topic to Roland yesterday, I would really
like to see such a clocksource driver done for other reasons
(multiplatform support), but introducing one with full DT support
is hard to do without breaking existing dtb files.

	Arnd
