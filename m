From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH v2 0/3] pwm: lpc32xx: Add support to control PWM_PIN_LEVEL
 bit
Date: Thu, 30 Jun 2016 11:43:16 +0300
Message-ID: <ce29f743-e481-64b0-8e05-0b610fa33fb3@mleia.com>
References: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:34250 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbcF3InT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 30 Jun 2016 04:43:19 -0400
In-Reply-To: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

Hi Sylvain,

On 27.06.2016 16:09, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> The PWM_PIN_LEVEL bit is leave unset by the kernel PWM driver.
> 
> Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
> the PWM_PIN_LEVEL bit was always clear when the PWM was disable
> and a 0 logic level was apply to the output.
> 
> According to the LPC32x0 User Manual [1],
> the default value for bit 30 (PWM_PIN_LEVEL) is 0.
> 
> First patch:
> * initialize the pin level to 0 (default value) and update
>   the register value accordingly.
> 
> Second anf third patches:
> *  provide support to configure the pin output (i.e. PWM_PIN_LEVEL bit)
>    when the PWM is disabled.

a short question, how do you use PWM? Does it serve as a backlight
or something else?

> Note:
> * Follow this URL to access the discussion for version 1 of this
>   patch: http://thread.gmane.org/gmane.linux.pwm/3882
> 
> [1] http://www.nxp.com/documents/user_manual/UM10326.pdf
> 
> Sylvain Lemieux (3):
>   pwm: lpc32xx: Set PWM_PIN_LEVEL bit to default value
>   pwm: lpc32xx: Add support for PWM_PIN_LEVEL bit configuration
>   dt-bindings: pwm: lpc32xx: Add nxp,pwm-disabled-level-high property
> 
>  Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt |  3 +++
>  drivers/pwm/pwm-lpc32xx.c                             | 11 +++++++++++
>  2 files changed, 14 insertions(+)
> 

--
With best wishes,
Vladimir
