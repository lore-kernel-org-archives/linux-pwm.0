From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH v3 0/5] pwm: support backward compatibility of DTB extending
 PWM args
Date: Mon, 1 Dec 2014 16:50:07 +0200
Message-ID: <547C801F.2010307@mentor.com>
References: <1416339438-7867-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:59230 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbaLAOuW (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Dec 2014 09:50:22 -0500
In-Reply-To: <1416339438-7867-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?B?TG90aGFy?= =?UTF-8?B?IFdhw59tYW5u?= <LW@KARO-electronics.de>, Sascha Hauer <s.hauer@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Hello Thierry,

On 18.11.2014 21:37, Vladimir Zapolskiy wrote:
> Please review this alternative in-house version of supporting backwar=
d
> compatibility of DTB files (new kernel/PWM driver and old DTS), overc=
oming
> a problem that pwms arguments of existing PWM drivers are to be exten=
ded
> with polarity field.
>=20
> Unfortunately I've firstly created the change and only after that
> found that Lothar Wa=C3=9Fmann is working on his version, so I won't =
insist
> on formal preference, but still I like to share my variant since it
> technically different from Lothar's one.
>=20
> Changes from v2 to v3:
> - improved commit messages
> - added two more patches removing of_pwm_xlate_with_flags()
>=20
> Changes from v1 to v2:
> - corrected the proper kernel log level, thanks to Lothar Wa=C3=9Fman=
n.
>=20
> Vladimir Zapolskiy (5):
>   pwm: process pwm polarity argument in of_pwm_simple_xlate()
>   pwm: push up dynamic printk level on errors in of_pwm_get()
>   pwm: set the actual number of pwms arguments defined in board dts
>   pwm: do not set of_pwm_xlate_with_flags() as a callback
>   pwm: remove of_pwm_xlate_with_flags() function
>=20
>  drivers/pwm/core.c            |   42 ++++++++++++-------------------=
----------
>  drivers/pwm/pwm-atmel-hlcdc.c |    2 --
>  drivers/pwm/pwm-atmel-tcb.c   |    2 --
>  drivers/pwm/pwm-atmel.c       |    6 ------
>  drivers/pwm/pwm-bcm-kona.c    |    2 --
>  drivers/pwm/pwm-fsl-ftm.c     |    2 --
>  drivers/pwm/pwm-renesas-tpu.c |    2 --
>  drivers/pwm/pwm-rockchip.c    |    5 -----
>  drivers/pwm/pwm-samsung.c     |    3 ---
>  drivers/pwm/pwm-tiecap.c      |    2 --
>  drivers/pwm/pwm-tiehrpwm.c    |    2 --
>  drivers/pwm/pwm-vt8500.c      |    2 --
>  include/linux/pwm.h           |    3 ---
>  13 files changed, 12 insertions(+), 63 deletions(-)
>=20

could you please review this PWM DTB backward compatibility change?

Thank you in advance.

--
With best wishes,
Vladimir
