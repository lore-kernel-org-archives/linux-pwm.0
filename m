From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] gpio: mvebu: avoid error message for optional IRQ
Date: Fri, 13 Mar 2020 07:45:01 +0100
Message-ID: <20200313064501.43h5htrebbgceudj@pengutronix.de>
References: <20200313034244.26336-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58141 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgCMGpO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Mar 2020 02:45:14 -0400
Content-Disposition: inline
In-Reply-To: <20200313034244.26336-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: thierry.reding@gmail.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Fri, Mar 13, 2020 at 04:42:44PM +1300, Chris Packham wrote:
> platform_get_irq() will generate an error message if the requested irq
> is not present
> 
>   mvebu-gpio f1010140.gpio: IRQ index 3 not found
> 
> use platform_get_irq_optional() to avoid the error message being
> generated.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

LGTM

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
