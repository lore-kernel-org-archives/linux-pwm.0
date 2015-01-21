From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH v3 0/5] pwm: support backward compatibility of DTB extending
 PWM args
Date: Wed, 21 Jan 2015 15:16:35 +0200
Message-ID: <54BFA6B3.3070702@mentor.com>
References: <1416339438-7867-1-git-send-email-vladimir_zapolskiy@mentor.com> <547C801F.2010307@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:46219 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbAUNQw (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Jan 2015 08:16:52 -0500
In-Reply-To: <547C801F.2010307@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?B?TG90aGFy?= =?UTF-8?B?IFdhw59tYW5u?= <LW@KARO-electronics.de>, Sascha Hauer <s.hauer@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Hello Thierry,

On 01.12.2014 16:50, Vladimir Zapolskiy wrote:
> Hello Thierry,
>=20
> On 18.11.2014 21:37, Vladimir Zapolskiy wrote:
>> Please review this alternative in-house version of supporting backwa=
rd
>> compatibility of DTB files (new kernel/PWM driver and old DTS), over=
coming
>> a problem that pwms arguments of existing PWM drivers are to be exte=
nded
>> with polarity field.
>>
>> Unfortunately I've firstly created the change and only after that
>> found that Lothar Wa=C3=9Fmann is working on his version, so I won't=
 insist
>> on formal preference, but still I like to share my variant since it
>> technically different from Lothar's one.
>>
>> Changes from v2 to v3:
>> - improved commit messages
>> - added two more patches removing of_pwm_xlate_with_flags()
>>
>> Changes from v1 to v2:
>> - corrected the proper kernel log level, thanks to Lothar Wa=C3=9Fma=
nn.
>>
>> Vladimir Zapolskiy (5):
>>   pwm: process pwm polarity argument in of_pwm_simple_xlate()
>>   pwm: push up dynamic printk level on errors in of_pwm_get()
>>   pwm: set the actual number of pwms arguments defined in board dts
>>   pwm: do not set of_pwm_xlate_with_flags() as a callback
>>   pwm: remove of_pwm_xlate_with_flags() function
>>
>>  drivers/pwm/core.c            |   42 ++++++++++++------------------=
-----------
>>  drivers/pwm/pwm-atmel-hlcdc.c |    2 --
>>  drivers/pwm/pwm-atmel-tcb.c   |    2 --
>>  drivers/pwm/pwm-atmel.c       |    6 ------
>>  drivers/pwm/pwm-bcm-kona.c    |    2 --
>>  drivers/pwm/pwm-fsl-ftm.c     |    2 --
>>  drivers/pwm/pwm-renesas-tpu.c |    2 --
>>  drivers/pwm/pwm-rockchip.c    |    5 -----
>>  drivers/pwm/pwm-samsung.c     |    3 ---
>>  drivers/pwm/pwm-tiecap.c      |    2 --
>>  drivers/pwm/pwm-tiehrpwm.c    |    2 --
>>  drivers/pwm/pwm-vt8500.c      |    2 --
>>  include/linux/pwm.h           |    3 ---
>>  13 files changed, 12 insertions(+), 63 deletions(-)
>>
>=20
> could you please review this PWM DTB backward compatibility change?
>=20
> Thank you in advance.
>=20

the first three patches are unmodified since October 2014, but still no=
t
reviewed...

Could you please review the changeset?

Thank you in advance.

--
With best wishes,
Vladimir
