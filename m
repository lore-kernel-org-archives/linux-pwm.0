From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 0/6] IIO pulse capture support for TI ECAP
Date: Wed, 05 Feb 2014 23:23:25 +0300
Message-ID: <52F29DBD.9050305@cogentembedded.com>
References: <1391626901-31684-1-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:44769 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbaBETXB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Feb 2014 14:23:01 -0500
Received: by mail-lb0-f169.google.com with SMTP id q8so697626lbi.0
        for <linux-pwm@vger.kernel.org>; Wed, 05 Feb 2014 11:22:59 -0800 (PST)
In-Reply-To: <1391626901-31684-1-git-send-email-mporter@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matt Porter <mporter@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <robh+dt@kernel.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux IIO List <linux-iio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Hello.

On 02/05/2014 10:01 PM, Matt Porter wrote:

[...]

> This series adds support for PWM capture devices within IIO and
> adds a TI ECAP IIO driver.

> PWM capture devices are supported using a new IIO "pulse" channel type.

> The IIO ECAP driver implements interrupt driven triggered buffer capture
> only as raw sample reads are not applicable to this hardware.
> Initially, the driver supports a single pulse width measurement with
> configurable polarity. The ECAP hardware can support measurement of a
> complete period and duty cycle but this is not yet implemented.

    How about pulse counting? I have the hardware that can also count pulses 
in addition to measuring the periods, so I'm interested in this work 
(initially I supported it in driver/misc/ but it got turned down for iio).

WBR, Sergei

