From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 0/6] pwm: imx: Provide atomic operation for IMX PWM
 driver
Date: Mon, 24 Oct 2016 17:36:07 +0200
Message-ID: <20161024173607.36bc2cb9@bbrezillon>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:47230 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938646AbcJXPgO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Oct 2016 11:36:14 -0400
In-Reply-To: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de

On Sun, 23 Oct 2016 23:45:40 +0200
Lukasz Majewski <l.majewski@majess.pl> wrote:

> This patch set brings atomic operation to i.MX's PWMv2 driver.
> 
> This work has been supported and suggested by Boris Brezillon [1] and 
> Stefan Agner, by showing how simple the transition could be :-).
> 
> It has been divided into several steps:
> - Separate PWMv1 commits from "generic" and non atomic PWM code.
> 
>   NOTE: Since I do not have board with PWMv1, I would like to ask somebody
>   	for testing
> 
> - Move some imx_config_v2 code to separate functions
> 
> - Provide PWM atomic implementation (the ->apply() driver) in a single patch
>   for better readability.
> 
> - Remove redundant PWM code (disable, enable, config callbacks)
> 
> - Clean up the driver infrastructure
> 
> - Provide "polarity_supported" flag to indicate support for polarity 
>   inversion
> 
> This work should be applied on top of following commits:
> 
> http://patchwork.ozlabs.org/patch/679706/
> http://patchwork.ozlabs.org/patch/679707/
> http://patchwork.ozlabs.org/patch/679680/

I'm not sure I follow the logic here. Has patch [1] already been
applied? If that's not the case, then you should just drop it and put
your changes on top of mainline.

[1]http://patchwork.ozlabs.org/patch/679680/
