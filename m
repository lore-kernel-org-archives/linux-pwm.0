From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCHv6 0/3] pwm: imx: support output polarity inversion
Date: Thu, 08 Sep 2016 15:15:57 -0700
Message-ID: <6c896634c4d6446df0388da2c0228232@agner.ch>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:51385 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbcIHWVU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Sep 2016 18:21:20 -0400
In-Reply-To: <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc: linux-pwm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Hi Lothar,

On 2014-10-10 07:22, Lothar Waßmann wrote:
> This patch series adds support for polarity inversion to the pwm-imx
> driver. The patches have been tested on i.MX6, i.MX53 and with the
> ti-ehrpwm.c driver.

Do you know what prevented this patchset from getting merged?

We are looking for Polarity support in PWM for too, this is especially
useful for backlight control.

--
Stefan

> 
> Changes wrt. v2:
> - make the use of '#pwm-cells = <3>' optional, so that the change does
>   not break existing DT blobs as suggested by Arnd Bergmann and Sascha
>   Hauer.
> 
> Changes wrt. v3:
> - implemented the approach suggested by Sascha Hauer 
> - don't modify struct pwm_ops in the imx_pwm probe function
> 
> Changes wrt. v4:
> - rebased onto current linux-next
> - dropped cleanup patch which is not necessary any more
> - resent with ACK from Shawn Guo and Reviewed-By tag from Sascha Hauer
> 
> Changes wrt. v5:
> - don't remove of_pwm_n_cells to keep sanity checks for #pwm-cells as
>   suggested by Thierry Reding
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
